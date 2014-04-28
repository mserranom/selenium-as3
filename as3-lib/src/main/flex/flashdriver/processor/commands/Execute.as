package flashdriver.processor.commands
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.log.Logger;
import flashdriver.messages.WireCommand;
import flashdriver.finder.ElementFinder;

import mx.logging.ILogger;

public class Execute
{

    private static const LOG : ILogger = Logger.getLogger(Execute);

    public function process(command:WireCommand) : String
    {
        const func : Function = new ElementFinder().getFunction(command.selector.value1);
        LOG.info("executing function with id='" + command.selector.value1 + "' with params="
                + JSON.stringify(command.params));
        try
        {
            return func.apply(null, command.params);
        }
        catch (error:Error)
        {
            var msg : String = error.getStackTrace() ? error.getStackTrace() : error.message;
            throw new FlashDriverError(ErrorCodes.FUNCTION_INVOCATION_ERROR,
                    [command.selector.value1, msg]);
        }
        return "";
    }
}
}
