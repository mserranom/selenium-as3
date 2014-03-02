package flashdriver
{
import flash.events.Event;

import flashdriver.log.Logger;
import flashdriver.processor.CommandProcessorFacadeFactory;
import flashdriver.processor.ICommandProcessorFacade;
import flashdriver.register.ElementCache;
import flashdriver.socket.SocketConnector;
import flashdriver.socket.FlashDriverConnection;

import mx.logging.ILogger;

public class FlashDriver
{

    public static const DEFAULT_PORT : uint = 54080;

    private static const LOG : ILogger = Logger.getLogger(FlashDriver);

    private static var connector : SocketConnector;

    private static var flashDriverConnection : FlashDriverConnection;

    public static function registerElementByID(id:String, element:*)
    {
        ElementCache.registerElementById(id, element);
    }

    public static function removeElementById(id:String, element:*)
    {
        ElementCache.removeElementById(id, element);
    }

    public static function clearCache() : void
    {
        ElementCache.clearCache();
    }

    public static function connect(port:uint=DEFAULT_PORT) : void
    {
        if(connector)
        {
            throw new Error("a socket connection is already active.")
        }

        connector = new SocketConnector();
        connector.addEventListener(Event.CONNECT, onSocketConnect);
        connector.addEventListener(Event.CLOSE, onSocketError);
        connector.connect(port);
    }

    private static function onSocketConnect(event:Event):void
    {
        LOG.debug("socket connection established, creating flashdriver connection");
        const processor : ICommandProcessorFacade = CommandProcessorFacadeFactory.create();
        flashDriverConnection = new FlashDriverConnection();
        flashDriverConnection.start(connector.socket, processor);
    }

    private static function onSocketError(event:Event):void
    {
        LOG.error("couldn't establish socket connection");
        destroyConnection();
    }

    public static function destroyConnection() : void
    {
        connector.removeEventListener(Event.CONNECT, onSocketConnect);
        connector.removeEventListener(Event.CLOSE, onSocketError);
        connector.destroy();
        connector = null;
    }

}
}