#if !NETSTANDARD1_3
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace Universe.SqlServerJam
{
    public static class RamDriveInfo
    {
        public static DriveInfo[] FindRamDrives(long minAvailMegabytes)
        {
            List<DriveInfo> ret = new List<DriveInfo>();

            DriveInfo[] drives = DriveInfo.GetDrives();
            foreach (var i in drives)
            {
                string label = null;
                long? free = null;
                if (i.DriveType == DriveType.Fixed)
                {
                    try
                    {
                        free = i.AvailableFreeSpace;
                        label = i.VolumeLabel;
                    }
                    catch (Exception)
                    {
                    }
                }

                bool isRamDrive =
                    "RamDisk".Equals(label, StringComparison.InvariantCultureIgnoreCase)
                    || "RamDrive".Equals(label, StringComparison.InvariantCultureIgnoreCase)
                    || i.DriveType == DriveType.Ram;

                if (isRamDrive && free.Value >= minAvailMegabytes*1024*1024)
                    ret.Add(i);
            }

            return ret
                .OrderByDescending(x => x.AvailableFreeSpace)
                .ToArray();
        }
    }
}
#endif