using System.Diagnostics;
using System.Management;
using Universe.GenericTreeTable;

namespace Universe.CpuInfo.Tests
{
    [TestFixture]
    public class Tests
    {
        [Test]
        public void TestPerCents()
        {
            var maxClockSpeed = GetMaxClockSpeed();
            PerformanceCounter cpuCounter = new PerformanceCounter("Processor Information", "% Processor Performance", "_Total" ,true);
            var v1 = cpuCounter.NextValue();
            /*
            ThreadPool.QueueUserWorkItem(_ =>
            {
                while (true)
                {
                }
            });
            */
            // Thread.Sleep(1);
            var v2 = cpuCounter.NextValue();

            Console.WriteLine($"v1 = {v1*maxClockSpeed/100:n1}, v2 = {v2 * maxClockSpeed/100:n1}");
            for (int i = 1; i <= 10; i++)
            {
                var v3 = cpuCounter.NextValue();
                Console.WriteLine($"v3 = {v3 * maxClockSpeed / 100:n1}");
                Thread.Sleep(1);
            }



        }

        double GetMaxClockSpeed()
        {
            foreach (ManagementObject obj in new ManagementObjectSearcher("SELECT MaxClockSpeed FROM Win32_Processor").Get())
            {
                double maxSpeed = Convert.ToDouble(obj["MaxClockSpeed"]) / 1d;
                return maxSpeed;
            }

            return 0;
        }

        [Test]
        public void Test_Performance_Counters_Values()
        {
            var categories = new string[] { "Processor", "Processor Information" };

            foreach (string category in categories)
            {
                Console.WriteLine($"{category}");
                PerformanceCounterCategory cat = new PerformanceCounterCategory(category);
                string[]? instanceNames = cat.GetInstanceNames().OrderBy(x => x).ToArray();
                // Columns: instance names, Rows: Counter Name
                var columns = new List<string>() { "Counter" };
                columns.AddRange(instanceNames);
                ConsoleTable table = new ConsoleTable(columns.ToArray());
                var counterNames = GetCounterNamesByCategory(cat);
                foreach (var counterName in counterNames)
                {
                    List<object> values = new List<object>() { counterName };
                    foreach (var instanceName in instanceNames)
                    {
                        PerformanceCounter pc = new PerformanceCounter(category, counterName, instanceName, true);
                        values.Add(pc.NextValue().ToString("n3"));
                    }
                    table.AddRow(values.ToArray());
                }

                Console.WriteLine(table);
            }
        }

        static string[] GetCounterNamesByCategory(PerformanceCounterCategory cat)
        {
            HashSet<string> ret = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            var instas = cat.GetInstanceNames();
            foreach (var insta in instas)
            foreach (var performanceCounter in cat.GetCounters(insta))
            {
                ret.Add(performanceCounter.CounterName);
            }

            return ret.OrderBy(x => x).ToArray();
        }


        [Test/*, Explicit*/]
        public void Test_Performance_Counters_Names()
        {

            var categories = PerformanceCounterCategory.GetCategories()
                .ToArray()
                .OrderBy(x => x.CategoryName);

            foreach (var cat in categories)
            {
                Stopwatch sw = Stopwatch.StartNew();
                List<PerformanceCounter> list = new List<PerformanceCounter>();
                var iNames = cat.GetInstanceNames();
                foreach (var iName in iNames)
                {
                    try
                    {
                        PerformanceCounter[]? counters = cat.GetCounters(iName);
                        list.AddRange(counters);
                        if (counters.Length > 1) break;
                    }
                    catch
                    {
                        // thread disappeared
                    }
                }

                var counterNames = list.Select(x => x.CounterName).Distinct().OrderBy(x => x).ToArray();
                Console.WriteLine($"'{cat.CategoryName}': {counterNames.Length}, {sw.Elapsed.TotalSeconds:n1} seconds");
                foreach (var counterName in counterNames)
                {
                    Console.WriteLine($"  * {counterName}");
                }

                Console.WriteLine($"");
            }
        }

        [Test]
        public void Test1()
        {
            WindowsCpuClockReader ret = new WindowsCpuClockReader();
            ClockSpeed sp = ret.GetSpeed();
        }
    }
}