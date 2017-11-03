using System;
using System.Diagnostics;
using System.Linq;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests
{
    class NUnit3Logs
    {
        private static bool _Bound = false;
        static readonly object Sync = new object();

        // Rarely used method
        public static void Bind()
        {
            if (!_Bound)
                lock (Sync)
                    if (!_Bound)
                    {
                        var name = Process.GetCurrentProcess()?.ProcessName ?? "";
                        var runners = new[] {"JetBrains.ReSharper.TaskRunner", "nunit-agent"};
                        if (true || runners.Any(x => name.StartsWith(x, StringComparison.InvariantCultureIgnoreCase)))
                        {
                            Debug.Listeners.Add(new TextWriterTraceListener(TestContext.Progress));
                        }

                        Debug.WriteLine("[NUnit3Logs.Bind] Process: " + name);

                        _Bound = true;
                    }
        }
    }
}