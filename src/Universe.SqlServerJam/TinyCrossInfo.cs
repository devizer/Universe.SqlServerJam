using System;
using System.Runtime.InteropServices;

namespace Universe.SqlServerJam
{
    internal static class TinyCrossInfo
    {
#if NETFRAMEWORK
        public static bool IsWindows => 
            Environment.OSVersion.Platform == PlatformID.Win32NT
            || Environment.OSVersion.Platform == PlatformID.Win32Windows
            || Environment.OSVersion.Platform == PlatformID.Win32S
            || Environment.OSVersion.Platform == PlatformID.WinCE;
#else
        public static bool IsWindows => RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
#endif
    }
}