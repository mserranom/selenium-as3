package flashdriver.socket
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;

import flashdriver.log.Logger;

import mx.logging.ILogger;

[Event(name="connect", type="flash.events.Event")]
[Event(name="close", type="flash.events.Event")]

public class SocketConnector extends EventDispatcher
{

    private static const LOG : ILogger = Logger.getLogger(SocketConnector);

    private static const LOCALHOST : String = "127.0.0.1";

    private var _currentSocket : Socket;

    public function connect(port:int) : Socket
    {
        _currentSocket = new Socket();

        LOG.debug("socket connection attemp to port " + port);
        _currentSocket.connect(LOCALHOST, port);
        addSocketEventListeners();

        return _currentSocket;
    }

    public function destroy() : void
    {
        removeSocketEventListeners();

        try
        {
            _currentSocket.close();
        }
        catch(error:Error)
        {
            LOG.debug("the socket couldn't be closed");
        }

        _currentSocket = null;
    }

    public function get socket() : Socket
    {
        return _currentSocket;
    }

    private function onSocketConnect(event:Event):void
    {
        LOG.info("socket connection succeeded");
        removeSocketEventListeners();
        dispatchEvent(new Event(Event.CONNECT));
    }

    private function onClientError(event:Event) : void
    {
        LOG.error("socket connection failed: " + event.toString());
        destroy();
        dispatchEvent(new Event(Event.CLOSE));
    }

    private function addSocketEventListeners() : void
    {
        _currentSocket.addEventListener(Event.CONNECT, onSocketConnect);
        _currentSocket.addEventListener(Event.CLOSE, onClientError);
        _currentSocket.addEventListener(IOErrorEvent.IO_ERROR, onClientError);
        _currentSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onClientError);
    }

    private function removeSocketEventListeners() : void
    {
        _currentSocket.removeEventListener(Event.CONNECT, onSocketConnect);
        _currentSocket.removeEventListener(Event.CLOSE, onClientError);
        _currentSocket.removeEventListener(IOErrorEvent.IO_ERROR, onClientError);
        _currentSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onClientError);
    }
}
}
