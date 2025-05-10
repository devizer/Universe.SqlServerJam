using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
// using NUnit.Framework.Legacy;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    public class VersionComparerTests : NUnitTestsBase
    {
        private static readonly int MaxTestPermutations = 100000;
        string[] Versions => "PG$11.22, PG$11.1, PG$10.1, PG$9.6, PG$9.3, PG$10.3, PG$11.1:7, PG$11.2, PG$11.2:9, PG$11, PG$11.14".Split(',').Select(x => x.Trim()).Where(x => x.Length > 0).ToArray();
        private Row[] Rows => Versions.Select(x => new Row() { VersionRaw = x }).ToArray();

        [Test]
        public void TestRawString()
        {
            var sorted = Rows.OrderBy(x => x.VersionRaw, VersionStringComparer.Instance);
            Console.WriteLine(DumpSorted(sorted));
        }

        [Test]
        public void TestVersionString()
        {
            var sorted = Rows.OrderBy(x => x.VersionSortable);
            Console.WriteLine(DumpSorted(sorted));
        }

        [Test]
        [TestCase("First")]
        [TestCase("Next")]
        public void TestAllRawString(string id)
        {
            var originalRows = Rows;
            string expected = null;
            int index = 0;
            foreach (var permutation in SimplePermutations.GetAll(originalRows.Length))
            {
                // Console.WriteLine(index);
                var rows = permutation.Select(x => originalRows[x]);
                var sorted = rows.OrderBy(x => x.VersionRaw, VersionStringComparer.Instance);
                var actual = DumpSorted(sorted);
                expected = expected ?? actual;
                // Assert.AreEqual(expected, actual);
                Assert.That(actual, Is.EqualTo(expected));
                if (index >= MaxTestPermutations) break;
                index++;
            }
        }

        [Test]
        [TestCase("First")]
        [TestCase("Next")]
        public void TestAllVersionString(string id)
        {
            var originalRows = Rows;
            Row[] expected = null;
            int index = 0;
            foreach (var permutation in SimplePermutations.GetAll(originalRows.Length))
            {
                var rows = permutation.Select(x => originalRows[x]);
                Row[] actual = rows.OrderBy(x => x.VersionSortable).ToArray();
                expected = expected ?? actual;
                // CollectionAssert.AreEqual(expected.Select(x => x.VersionRaw), actual.Select(x => x.VersionRaw));
                Assert.That(actual.Select(x => x.VersionRaw), Is.EqualTo(expected.Select(x => x.VersionRaw)));
                if (index >= MaxTestPermutations) break;
                index++;
            }

            Console.WriteLine(DumpSorted(expected));
        }

        private string DumpSorted(IEnumerable<Row> sorted)
        {
            var asTextList = sorted.Select(x => $"  * {x.VersionRaw}");
            var ret = $"Sorted:{Environment.NewLine}{string.Join(Environment.NewLine, asTextList.ToArray())}";
            // Console.WriteLine(ret);
            return ret;
        }

        [Test]
        [TestCase(0)]
        [TestCase(1)]
        [TestCase(2)]
        [TestCase(3)]
        [TestCase(4)]
        // [TestCase(11)]
        public void TestPermutations(int count)
        {
            
            Console.WriteLine($"TOTAL: {SimplePermutations.GetAll(count).Count()}");
            foreach (var permutation in SimplePermutations.GetAll(count))
            {
                Console.WriteLine(string.Join(",", permutation.Select(x => x.ToString()).ToArray()));
            }
        }

        // SLOW
        class Row_Slow
        {
            public string VersionRaw { get; set; }
            public VersionString VersionSortable => new VersionString(VersionRaw);
        }

        // FAST
        class Row
        {
            private string _VersionRaw;
            private VersionString _VersionSortable;
            public VersionString VersionSortable => _VersionSortable;

            public string VersionRaw
            {
                get => _VersionRaw;
                set { 
                    _VersionRaw = value;
                    _VersionSortable = new VersionString(value);
                }
            }
        }



    }
}
