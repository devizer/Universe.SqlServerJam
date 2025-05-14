using System;
using System.Collections.Generic;
using System.Text;

namespace Universe.SqlServerJam
{
    public static class ResilientVersionParser
    {
        public static Version Parse(string rawVersion)
        {
            StringBuilder normal = new StringBuilder();
            int dotsCount = 0;
            foreach (var ch in rawVersion)
            {
                if (ch == '.') dotsCount++;
                bool isValidChar = ch >= '0' && ch <= '9' || ch == '.';
                if (!isValidChar)
                {
                    if (normal.Length >= 4)
                        return TryVersion(normal.ToString());
                }
                else
                {
                    normal.Append(ch);
                }
            }

            return TryVersion(normal.ToString());
        }

        static Version TryVersion(string rawVersion)
        {
#if NET35
            try
            {
                return new Version(rawVersion);
            }
            catch
            {
                return null;
            }
#else
            if (Version.TryParse(rawVersion, out var ret))
                    return ret;

            return null;
#endif
        }
    }
}
