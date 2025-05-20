using System.Threading.Tasks;

namespace Universe.StressOrchestration;

public interface IAsyncStressAction
{
    Task ActAsync();
}