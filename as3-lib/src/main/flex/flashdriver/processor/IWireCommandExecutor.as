package flashdriver.processor
{
import flashdriver.messages.WireCommand;

public interface IWireCommandExecutor
{
    function execute(command:WireCommand) : String;
}
}
