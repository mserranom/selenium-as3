package flashdriver.processor
{
import flashdriver.messages.WireCommandParser;

public class CommandProcessorFacadeFactory
{
    public static function create() : ICommandProcessorFacade
    {
        return new CommandProcessorFacade(
                    new CommandProcessor(new ElementCacheProxy()),
                    new WireCommandParser());
    }
}
}
