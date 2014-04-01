package flashdriver.processor
{
import flashdriver.log.Logger;
import flashdriver.messages.WireCommand;
import flashdriver.processor.commands.Click;
import flashdriver.processor.commands.Execute;
import flashdriver.processor.commands.Exists;
import flashdriver.processor.commands.GetProperty;
import flashdriver.processor.commands.SetProperty;

import mx.logging.ILogger;

public class CommandProcessor implements ICommandProcessor
{
    private static const LOG : ILogger = Logger.getLogger(CommandProcessor);

    private var _cache : ElementCacheProxy;

    public function CommandProcessor(cache:ElementCacheProxy)
    {
        _cache = cache;
    }

    public function process(command:WireCommand) : String
    {
        switch(command.type)
        {
            case WireCommand.CLICK:
                return processClick(command);
            case WireCommand.EXISTS:
                return processExists(command);
            case WireCommand.GET_PROPERTY:
                return processGetProperty(command);
            case WireCommand.SET_PROPERTY:
                return processSetProperty(command);
            case WireCommand.EXECUTE:
                return processExecute(command);
            default:
                throw new Error("Unknown command type: " + command.type)
        }
    }

    private function processClick(command:WireCommand) : String
    {
        return new Click(_cache).process(command);
    }

    private function processExists(command:WireCommand) : String
    {
        return new Exists(_cache).process(command);
    }

    private function processGetProperty(command:WireCommand) : String
    {
        return new GetProperty(_cache).process(command);
    }

    private function processSetProperty(command:WireCommand) : String
    {
        return new SetProperty(_cache).process(command);
    }

    private function processExecute(command:WireCommand) : String
    {
        return new Execute(_cache).process(command);
    }
}
}
