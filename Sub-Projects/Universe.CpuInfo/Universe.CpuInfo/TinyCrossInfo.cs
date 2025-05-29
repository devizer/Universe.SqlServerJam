using System.Runtime.InteropServices;

namespace Universe;

internal static class TinyCrossInfo
{
#if NET20_OR_GREATER
    public static bool IsWindows => 
        Environment.OSVersion.Platform == PlatformID.Win32NT 
        || Environment.OSVersion.Platform == PlatformID.Win32Windows 
        || Environment.OSVersion.Platform == PlatformID.Win32S 
        || Environment.OSVersion.Platform == PlatformID.WinCE;
#else
    public static bool IsWindows => RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
#endif
}