package flashdriver
{
import flash.display.DisplayObjectContainer;
import flash.events.Event;

import flashdriver.log.Logger;
import flashdriver.processor.CommandProcessorFacadeFactory;
import flashdriver.processor.ICommandProcessorFacade;
import flashdriver.register.Register;
import flashdriver.socket.SocketConnector;
import flashdriver.socket.FlashDriverConnection;

import mx.logging.ILogger;

import starling.display.DisplayObjectContainer;

public class FlashDriver
{

    public static const DEFAULT_PORT : uint = 54081;

    private static const LOG : ILogger = Logger.getLogger(FlashDriver);

    private static var connector : SocketConnector;

    private static var flashDriverConnection : FlashDriverConnection;

    public static function registerElementByID(id:String, element:*) : void
    {
        flashdriver.register.Register.registerElementById(id, element);
    }

    public static function removeElementById(id:String, element:*) : void
    {
        flashdriver.register.Register.removeElementById(id, element);
    }

    public static function registerFunction(id:String, func:Function) : void
    {
       flashdriver.register.Register.registerFunction(id, func);
    }

    public static function removeFunction(id:String, func:Function) : void
    {
        flashdriver.register.Register.removeFunction(id, func);
    }

    public static function clearCache() : void
    {
        flashdriver.register.Register.clearCache();
    }

    public static function registerRoot(root:flash.display.DisplayObjectContainer) : void
    {
        flashdriver.register.Register.registerRoot(root);
    }

    public static function registerStarlingRoot(root:starling.display.DisplayObjectContainer) : void
    {
        flashdriver.register.Register.registerStarlingRoot(root);
    }

    public function connect(port:uint=DEFAULT_PORT) : void
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

    private function onSocketConnect(event:Event):void
    {
        LOG.debug("socket connection established, creating flashdriver connection");
        const processor : ICommandProcessorFacade = CommandProcessorFacadeFactory.create();
        flashDriverConnection = new FlashDriverConnection();
        flashDriverConnection.start(connector.socket, processor);
    }

    private function onSocketError(event:Event):void
    {
        LOG.error("couldn't establish socket connection");
        destroyConnection();
    }

    public function destroyConnection() : void
    {
        connector.removeEventListener(Event.CONNECT, onSocketConnect);
        connector.removeEventListener(Event.CLOSE, onSocketError);
        connector.destroy();
        connector = null;
    }

}
}
