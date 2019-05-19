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
                        Debug.Listeners.Add(new TextWriterTraceListener(TestContext.Progress));

                        var name = Process.GetCurrentProcess()?.ProcessName ?? "";
                        var ignoreCase = StringComparison.InvariantCultureIgnoreCase;
                        bool isNUnitAgent = name.StartsWith("nunit-agent", ignoreCase);
                        if (!isNUnitAgent)
                            Debug.Listeners.Add(new TextWriterTraceListener(Console.Out));

                        Debug.WriteLine("[NUnit3Logs.Bind] Process: " + name);

                        _Bound = true;
                    }
        }
    }
}