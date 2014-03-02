package flashdriver.processor
{
import flashdriver.messages.WireCommand;

public interface ICommandProcessor
{
    function process(command:WireCommand) : String;
}
}
