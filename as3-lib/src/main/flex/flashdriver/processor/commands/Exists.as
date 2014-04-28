package flashdriver.processor.commands
{
import flashdriver.messages.WireCommand;
import flashdriver.finder.ElementFinder;

public class Exists
{

    public function process(command:WireCommand) : String
    {
        new ElementFinder().find(command.selector);
        return "";
    }
}
}
