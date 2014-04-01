package flashdriver.processor.commands
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.log.Logger;
import flashdriver.messages.WireCommand;
import flashdriver.processor.ElementCacheProxy;

import mx.logging.ILogger;

public class Execute
{

    private static const LOG : ILogger = Logger.getLogger(Execute);

    private var _cache : ElementCacheProxy;

    public function Execute(cache:ElementCacheProxy)
    {
        _cache = cache;
    }

    public function process(command:WireCommand) : String
    {
        const func : Function = _cache.getFunction(command.selector.value);
        LOG.info("executing function with id='" + command.selector.value + "' with params="
                + JSON.stringify(command.params));
        try
        {
            return func.apply(null, command.params);
        }
        catch (error:Error)
        {
            var msg : String = error.getStackTrace() ? error.getStackTrace() : error.message;
            throw new FlashDriverError(ErrorCodes.FUNCTION_INVOCATION_ERROR,
                    [command.selector.value, msg]);
        }
        return "";
    }
}
}
