using System;
using System.Linq;
using Dapper;

namespace Universe.SqlServerJam
{
    public class ServerConfigurationSettingsManager
    {
        private readonly SqlServerManagement _ServerManagement;

        public bool ClrEnabled
        {
            get => ReadOption<bool>("clr enabled")?.RunValue == true;
            set => SetOption<bool>("clr enabled", value);
        }

        public bool ServerTriggerRecursion
        {
            get => ReadOption<bool>("server trigger recursion")?.RunValue == true;
            set => SetOption<bool>("server trigger recursion", value);
        }
        
        // On Azure always false
        public bool ShowAdvancedOption
        {
            get => ReadOption<bool>(Names.ShowAdvancedOption)?.RunValue == true;
            set => SetOption<bool>(Names.ShowAdvancedOption, value);
        }

        public FileStreamAccessLevels FileStreamAccessLevel
        {
            get => !_ServerManagement.IsFileStreamSupported ? FileStreamAccessLevels.NotSupported : (FileStreamAccessLevels) ReadOption<int>(Names.FilestreamAccessLevel).RunValue;
            set => SetOption<int>(Names.FilestreamAccessLevel, (int) value);
        }

        public bool BackupCompressionDefault
        {
            get => _ServerManagement.IsCompressedBackupSupported && ReadOption<bool>(Names.BackupCompressionDefault)?.RunValue == true;
            set => SetOption<bool>(Names.BackupCompressionDefault, value);
        }

        // On Azure always false
        public bool XpCmdShell
        {
            get => _ServerManagement.IsWindows && ReadAdvancedOption<bool>(Names.XpCmdShell)?.RunValue == true;
            set => SetAdvancedOption<bool>(Names.XpCmdShell, value);
        }

        // Not a dynamic option, restart required
        // 0 and 100 are the same
        public int FillFactor
        {
            get => ReadAdvancedOption<int>("fill factor (%)")?.RunValue ?? 0;
            set => SetAdvancedOption<int>("fill factor (%)", value);
        }

        // On Azure always 0 (zero)
        public int MaxServerMemory
        {
            get => ReadAdvancedOption<int>(Names.MaxServerMemory)?.RunValue ?? 0;
            set => SetAdvancedOption<int>(Names.MaxServerMemory, value);
        }

        // On Azure always 0 (zero)
        public int MinServerMemory
        {
            get => ReadAdvancedOption<int>(Names.MinServerMemory)?.RunValue ?? 0;
            set => SetAdvancedOption<int>(Names.MinServerMemory, value);
        }

        // Not for Express and Azure
        public short AffinityCount
        {
            get => MaskToCount(this.AffinityMask);
            set => this.AffinityMask = CountToMask(value);
        }

        private short MaskToCount(long affinityMask)
        {
            if (affinityMask == 0) return (short)this._ServerManagement.CpuCount;
            int count = 0;
            long scale = 1;
            for (int i = 0; i < 64; i++)
            {
                if ((affinityMask & scale) != 0) count++;
                scale <<= 1;
            }

            return (short)count;
        }

        long CountToMask(short count)
        {
            short cpuCount = (short) this._ServerManagement.CpuCount;
            if (count == cpuCount) return 0;
            long ret = 0;
            long scale = 1;
            for (int i = 0; i < count; i++)
            {
                ret += scale;
                scale <<= 1;
            }

            return ret;
        }

        // Not for Express and Azure
        public long AffinityMask
        {
            get => GetAffinityMask("");
            set => SetAffinityMask("", value);
        }
        private long AffinityIoMask
        {
            get => GetAffinityMask("I/O");
            set => SetAffinityMask("I/O", value);
        }

        private void SetAffinityMask(string suffix, long value)
        {
            // Console.WriteLine($"[DEBUG] SetAffinityMask={value}");
            suffix = string.IsNullOrEmpty(suffix) ? "" : $"{suffix} ";
            var lowName = $"affinity {suffix}mask";
            var highName = $"affinity64 {suffix}mask";
            int lowValue = (int)(value & 0xFFFFFFFF);
            int highValue = (int)((value >> 32) & 0xFFFFFFFF);
            SetAdvancedOption(lowName, lowValue);
            try
            {
                SetAdvancedOption(highName, highValue);
            }
            catch
            {
                // No Additional Action is required,
                // Because lower 32 bit affinity is successfully updated
                bool is32bit = true;
            }
        }

        private long GetAffinityMask(string suffix)
        {
            suffix = string.IsNullOrEmpty(suffix) ? "" : $"{suffix} ";
            var lowName = $"affinity {suffix}mask";
            var highName = $"affinity64 {suffix}mask";
            var lowOption = ReadAdvancedOption<int>(lowName);
            var highOption = ReadAdvancedOption<int>(highName);
            var lowValue = lowOption?.RunValue ?? 0;
            var highValue = highOption?.RunValue ?? 0;
            long ret = ((long)highValue) << 32 | ((long)lowValue);
            return ret;
        }



        static class Names
        {
            public const string ShowAdvancedOption = "show advanced option"; // bool

            public const string XpCmdShell = "xp_cmdshell"; // bool

            public const string TwoDigitYearCutoff = "two digit year cutoff"; // 2049

            public const string MinServerMemory = "min server memory (MB)"; // 0+
            public const string MaxServerMemory = "max server memory (MB)"; // 128+

            public const string BackupCompressionDefault = "backup compression default"; // bool
            public const string FilestreamAccessLevel = "filestream access level"; // enum 
        }

        public class Option<T>
        {
            public string Name { get; set; }
            public T RunValue { get; set; }
            public T ConfigValue { get; set; }
            public T Min { get; set; }
            public T Max { get; set; }
        }

        class OptionRecord
        {
            public string Name { get; set; }
            public int run_value { get; set; } // "value_in_use"
            public int config_value { get; set; } // "value"
            public int minimum { get; set; }
            public int maximum { get; set; }
        }


        public ServerConfigurationSettingsManager(SqlServerManagement serverManagement)
        {
            _ServerManagement = serverManagement;
        }

        public Option<T> ReadAdvancedOption<T>(string name)
        {
            if (_ServerManagement.IsAzure) return null;
            bool showAdvancedOption = this.ShowAdvancedOption;
            try
            {
                if (!showAdvancedOption) this.ShowAdvancedOption = true;

                return ReadOption<T>(name);
            }
            finally
            {
                if (!showAdvancedOption) this.ShowAdvancedOption = false;
            }
        }

        public void SetAdvancedOption<T>(string name, T value)
        {
            if (_ServerManagement.IsAzure) return;

            bool showAdvancedOption = this.ShowAdvancedOption;
            try
            {
                if (!showAdvancedOption) this.ShowAdvancedOption = true;

                SetOption<T>(name, value);
            }
            finally
            {
                if (!showAdvancedOption) this.ShowAdvancedOption = false;
            }
        }

        public Option<T> ReadOption<T>(string name)
        {
            var sqlViaSp = "exec sp_configure @name";
            var sqlViaView = "Select name, value_in_use run_value, value config_value, minimum, maximum from sys.configurations where name = @name";
            var row = _ServerManagement.SqlConnection.Query<OptionRecord>(
                sqlViaView,
                new { name }
            ).FirstOrDefault();

            // null on Azure or incorrect name.
            if (row == null) return null;

            return new Option<T>()
            {
                Name = name,
                ConfigValue = ParseInt<T>(row.config_value),
                RunValue = ParseInt<T>(row.run_value),
                Min = ParseInt<T>(row.minimum),
                Max = ParseInt<T>(row.maximum),
            };
        }

        public void SetOption<T>(string name, T value)
        {
            _ServerManagement.SqlConnection.Execute(
                "exec sp_configure @name, @v; RECONFIGURE WITH OVERRIDE;",
                new { name, v = AsInt(value) }
            );

        }

        static T ParseInt<T>(int arg)
        {
            if (typeof(T) == typeof(bool) || typeof(T) == typeof(bool?)) return (T)(object)(arg != 0);
            if (typeof(T) == typeof(int) || typeof(T) == typeof(int?)) return (T)(object)arg;

            throw new ArgumentException($"Option Type '{typeof(T)}' is not supported");
        }

        static int AsInt<T>(T arg)
        {
            if (typeof(T) == typeof(bool)) return (bool)(object)arg ? 1 : 0;
            if (typeof(T) == typeof(bool?)) return ((bool?)(object)arg == true) ? 1 : 0;

            if (typeof(T) == typeof(int)) return (int)(object)arg;
            if (typeof(T) == typeof(int?)) return ((int?)(object)arg).GetValueOrDefault();

            throw new ArgumentException($"Option Type '{typeof(T)}' is not supported");
        }
    }

    public enum FileStreamAccessLevels
    {
        NotSupported = -1,
        Disabled = 0,
        Enabled = 1,
        EnabledWithWin32Streaming = 2,
    }
}