namespace Universe.CpuInfo.Tests;

[TestFixture]
public class TestFinal
{
    [Test]
    [TestCase("First")]
    [TestCase("Next")]
    public void Show_by_New_Instance(string kind)
    {
        Console.WriteLine(new WindowsCpuClockReader().GetSpeed());
    }

    [Test]
    [TestCase("First")]
    [TestCase("Next")]
    public void Show_by_Default_Instance(string kind)
    {
        Console.WriteLine(WindowsCpuClockReader.Default.GetSpeed());
    }

    [Test]
    [TestCase("First")]
    [TestCase("Next")]
    public void Create_Instance(string kind)
    {
        var x = WindowsCpuClockReader.Default;
    }
}