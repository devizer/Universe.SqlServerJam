using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

namespace Universe
{
    public class VersionString : IComparable<VersionString>
    {
        public readonly string Value;
        public readonly IComparer<string> StringComparer;
        internal List<Section> Sections => _Sections.Value;

        private readonly Lazy<List<Section>> _Sections;
        private static readonly List<Section> EmptySections = new List<Section>();

        public int CompareTo(VersionString other)
        {
            return VersionStringComparer.CompareVersionStrings(StringComparer, this, other);
        }

        public VersionString(string value) : this(value, System.StringComparer.OrdinalIgnoreCase)
        {
        }

        public VersionString(string value, IComparer<string> comparer)
        {
            Value = value;
            _Sections = new Lazy<List<Section>>(GetSections, LazyThreadSafetyMode.None);
            StringComparer = comparer;
        }

        internal enum SectionType : byte
        {
            Null,
            Text,
            Numeric
        }

        internal class Section
        {
            public string Value;
            public SectionType Type;
        }
        
        List<Section> GetSections()
        {
            if (Value == null) return EmptySections;
            List<Section> ret = new List<Section>();
            SectionType sectionType = SectionType.Null;
            StringBuilder sectionBuffer = new StringBuilder();

            foreach (char c in Value)
            {
                SectionType nextSectionType = c >= '0' && c <= '9' ? SectionType.Numeric : SectionType.Text;
                if (nextSectionType == sectionType)
                {
                    sectionBuffer.Append(c);
                }
                else
                {
                    if (sectionBuffer.Length > 0)
                    {
                        var vRaw = sectionBuffer.ToString();
                        var v = sectionType == SectionType.Numeric ? vRaw.PadLeft(VersionStringComparer.MaxNumberSectionLength, '0') : vRaw;
                        ret.Add(new Section() { Type = sectionType, Value = v });
                    }

                    sectionBuffer.Length = 0;
                    sectionType = nextSectionType;
                    sectionBuffer.Append(c);
                }
            }
            if (sectionBuffer.Length > 0)
            {
                var vRaw = sectionBuffer.ToString();
                var v = sectionType == SectionType.Numeric ? vRaw.PadLeft(VersionStringComparer.MaxNumberSectionLength, '0') : vRaw;
                ret.Add(new Section() { Type = sectionType, Value = v });
            }

            return ret;
        }
    }

    // v1 equals v001
    public class VersionStringComparer : IComparer<string>, IComparer<VersionString>
    {
        public static readonly VersionStringComparer Instance = new VersionStringComparer();
        private readonly IComparer<string> StringComparer;
        internal const int MaxNumberSectionLength = 22;

        public VersionStringComparer()
        {
            StringComparer = System.StringComparer.OrdinalIgnoreCase;
        }

        public VersionStringComparer(IComparer<string> stringComparer)
        {
            StringComparer = stringComparer;
        }

        int IComparer<VersionString>.Compare(VersionString x, VersionString y)
        {
            return CompareVersionStrings(StringComparer, x, y);
        }

        public static int CompareVersionStrings(IComparer<string> stringComparer, VersionString x, VersionString y)
        {
            if (stringComparer == null) throw new ArgumentNullException(nameof(stringComparer));
            if (x == null && y == null) return 0;
            if (x == null) { return -1; }
            if (y == null) { return 1; }
            List<VersionString.Section> xSections = x.Sections;
            List<VersionString.Section> ySections = y.Sections;
            int xSize = xSections.Count;
            int ySize = ySections.Count;
            int count = Math.Min(xSize, ySize);
            for (int i = 0; i < count; i++)
            {
                VersionString.SectionType xType = xSections[i].Type;
                var yType = ySections[i].Type;
                if (xType != yType)
                {
                    // Optimized (part 1 of 2)
                    return xType == VersionString.SectionType.Numeric? -1 : 1;
                }
                // if (xSections[i].Type == VersionString.SectionType.Numeric && ySections[i].Type != VersionString.SectionType.Text) return -1;
                int valueCompare = stringComparer.Compare(xSections[i].Value, ySections[i].Value);
                // Two Commented Lines: non optimized
                // if (xType == yType && valueCompare == 0) continue;
                // return valueCompare;
                // Optimized (part 2 of 2)
                if (valueCompare != 0) return valueCompare;
            }

            // n=count sections of both strings are equal
            return xSize.CompareTo(ySize);
        }

        int IComparer<string>.Compare(string x, string y)
        {
            if (x == null && y == null) return 0;
            if (x == null) { return -1; }
            if (y == null) { return 1; }
            return this.StringComparer.Compare(NormalizeVersionFragments(x), NormalizeVersionFragments(y));
        }


        static string NormalizeVersionFragments(string raw)
        {
            StringBuilder ret = new StringBuilder(), numberBuffer = new StringBuilder();
            foreach (char c in raw)
            {
                if (c >= '0' && c <= '9') numberBuffer.Append(c);
                else
                {
                    if (numberBuffer.Length > 0)
                    {
                        ret.Append(numberBuffer.ToString().PadLeft(MaxNumberSectionLength, '0'));
                        numberBuffer.Length = 0;
                    }
                    ret.Append(c);
                }
            }
            if (numberBuffer.Length > 0)
            {
                ret.Append(numberBuffer.ToString().PadLeft(MaxNumberSectionLength, '0'));
            }

            return ret.ToString();
        }
    }
}
