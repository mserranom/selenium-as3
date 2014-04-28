package flashdriver.processor
{
import flashdriver.messages.WireCommandParser;
import flashdriver.finder.ElementFinder;

public class CommandProcessorFacadeFactory
{
    public static function create() : ICommandProcessorFacade
    {
        return new CommandProcessorFacade(
                    new WireCommandExecutor(new ElementFinder()),
                    new WireCommandParser());
    }
}
}
