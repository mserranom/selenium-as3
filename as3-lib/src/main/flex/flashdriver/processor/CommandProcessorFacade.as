package flashdriver.processor
{
import flashdriver.log.Logger;
import flashdriver.messages.WireCommand;
import flashdriver.messages.WireCommandParser;
import flashdriver.messages.WireResult;
import flashdriver.socket.FlashDriverConnection;

import mx.logging.ILogger;

public class CommandProcessorFacade implements ICommandProcessorFacade
{

    private static const LOG : ILogger = Logger.getLogger(FlashDriverConnection);

    private static const ERROR : String = "error";
    private static const SUCCESS : String = "success";

    private var _processor : ICommandProcessor
    private var _parser : WireCommandParser

    public function CommandProcessorFacade(processor:ICommandProcessor, parser : WireCommandParser)
    {
        _processor = processor;
        _parser = parser;
    }

    public function process(command:String) : String
    {
        try
        {
            LOG.debug("processing command: " + command);
            const wireCmd : WireCommand = _parser.parse(command);
            const result : String = _processor.process(wireCmd);
        }
        catch (error:Error)
        {
            LOG.error("Error parsing processing wire command:" + command + "\n" + error.toString());
            return createErrorMessage(error);
        }

        return createResultMessage(result);
    }

    private function createErrorMessage(error:Error):String
    {
        const wireResult : WireResult = new WireResult(WireResult.ERROR, error.message, []);

        const message : Array = [ERROR, error.message];
        return wireResult.toJsonString()
    }

    private function createResultMessage(result:String):String
    {
        const wireResult : WireResult = new WireResult(WireResult.SUCCESS, result, []);
//        const message : Array = [SUCCESS, result];
        return wireResult.toJsonString();
    }
}
}
