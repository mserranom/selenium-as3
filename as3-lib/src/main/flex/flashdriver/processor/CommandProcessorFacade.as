package flashdriver.processor
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.log.Logger;
import flashdriver.messages.WireCommand;
import flashdriver.messages.WireCommandParser;
import flashdriver.messages.WireResult;
import flashdriver.socket.FlashDriverConnection;

import mx.logging.ILogger;

public class CommandProcessorFacade implements ICommandProcessorFacade
{

    private static const LOG : ILogger = Logger.getLogger(FlashDriverConnection);

    private var _processor : IWireCommandExecutor;
    private var _parser : WireCommandParser;

    public function CommandProcessorFacade(processor:IWireCommandExecutor, parser : WireCommandParser)
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
            const result : String = _processor.execute(wireCmd);
        }
        catch(error:FlashDriverError)
        {
            LOG.error("error executing wire command:" + command + "\n" + error.toString());
            var wireResult : WireResult = new WireResult(WireResult.ERROR, error.code, error.params);
            return wireResult.toJsonString()
        }
        catch (error:Error)
        {
            LOG.error("error parsing processing wire command:" + command + "\n" + error.toString());
            var msg : String = error.getStackTrace() ? error.getStackTrace() : error.message;
            wireResult = new WireResult(WireResult.ERROR, ErrorCodes.INTERNAL, [msg]);
            return wireResult.toJsonString()
        }

        return createResultMessage(result);
    }

    private function createResultMessage(result:String):String
    {
        const wireResult : WireResult = new WireResult(WireResult.SUCCESS, result, []);
        return wireResult.toJsonString();
    }
}
}
