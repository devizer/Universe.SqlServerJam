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
        public bool ShowAdvancedOption
        {
            get => ReadOption<bool>(Names.ShowAdvancedOption)?.RunValue == true;
            set => SetOption<bool>(Names.ShowAdvancedOption, value);
        }

        public FileStreamAccessLevels FileStreamAccessLevel
        {
            get => (FileStreamAccessLevels) ReadOption<int>(Names.FilestreamAccessLevel).RunValue;
            set => SetOption<int>(Names.FilestreamAccessLevel, (int) value);
        }

        public bool BackupCompressionDefault
        {
            get => _ServerManagement.IsCompressedBackupSupported && ReadOption<bool>(Names.BackupCompressionDefault)?.RunValue == true;
            set => SetOption<bool>(Names.BackupCompressionDefault, value);
        }

        public bool XpCmdShell
        {
            get => ReadAdvancedOption<bool>(Names.XpCmdShell)?.RunValue == true;
            set => SetAdvancedOption<bool>(Names.XpCmdShell, value);
        }

        public int MaxServerMemory
        {
            get => ReadAdvancedOption<int>(Names.MaxServerMemory).RunValue;
            set => SetAdvancedOption<int>(Names.MaxServerMemory, value);
        }


        static class Names
        {
            public const string ShowAdvancedOption = "show advanced option"; // bool

            public const string XpCmdShell = "xp_cmdshell"; // bool

            public const string TwoDigitYearCutoff = "two digit year cutoff"; // 2049

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
            public int run_value { get; set; }
            public int config_value { get; set; }
            public int minimum { get; set; }
            public int maximum { get; set; }
        }


        public ServerConfigurationSettingsManager(SqlServerManagement serverManagement)
        {
            _ServerManagement = serverManagement;
        }

        public Option<T> ReadAdvancedOption<T>(string name)
        {
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
            var row = _ServerManagement.SqlConnection.Query<OptionRecord>(
                "exec sp_configure @name",
                new { name }
            ).FirstOrDefault();

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
            if (typeof(T) == typeof(bool?)) return ((int?)(object)arg).GetValueOrDefault();

            throw new ArgumentException($"Option Type '{typeof(T)}' is not supported");
        }
    }

    public enum FileStreamAccessLevels
    {
        Disabled = 0,
        Enabled = 1,
        EnabledWithWin32Streaming = 2,
    }
}