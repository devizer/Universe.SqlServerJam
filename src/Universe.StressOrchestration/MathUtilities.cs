using System;

namespace Universe.StressOrchestration;

public static class MathUtilities
{
    // std_dev = math.sqrt((s0 * s2 - s1 * s1) / (s0 * (s0 - 1)))
    public static double GetStdDev(long s0, double s1, double s2)
    {
        return s0 <= 1
            ? 0
            : Math.Sqrt((s0 * s2 - s1 * s1) / (s0 * (s0 - 1)));
    }

    public static string GetOrdinalSuffix(int num)
    {
        num = Math.Abs(num);

        switch (num % 100)
        {
            case 11:
            case 12:
            case 13:
                return "th";
        }

        switch (num % 10)
        {
            case 1:
                return "st";
            case 2:
                return "nd";
            case 3:
                return "rd";
            default:
                return "th";
        }
    }

    public static string GetOrdinalSuffix_Slow(int num)
    {
        string number = num.ToString("0");
        if (number.EndsWith("11")) return "th";
        if (number.EndsWith("12")) return "th";
        if (number.EndsWith("13")) return "th";
        if (number.EndsWith("1")) return "st";
        if (number.EndsWith("2")) return "nd";
        if (number.EndsWith("3")) return "rd";
        return "th";
    }
}