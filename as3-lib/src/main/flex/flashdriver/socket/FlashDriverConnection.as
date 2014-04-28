package flashdriver.socket
{
import flash.events.ProgressEvent;
import flash.net.Socket;

import flashdriver.log.Logger;
import flashdriver.messages.WireResult;

import flashdriver.processor.ICommandProcessorFacade;

import mx.logging.ILogger;

public class FlashDriverConnection
{
    private static const LOG : ILogger = Logger.getLogger(FlashDriverConnection);

    private var _socket : Socket;

    private var _processor : ICommandProcessorFacade;

    public function start(socket:Socket, processor : ICommandProcessorFacade) : void
    {
        if(_socket)
        {
            throw new Error("connection is already established");
        }
        if(!socket.connected)
        {
            throw new Error("a connected socket is required to establish connection with flashdriver server");
        }
        _socket = socket;
        _processor = processor;
        _socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
        LOG.debug("started flash driver connection");
    }

    public function destroy() : void
    {
        _socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
        _socket = null;
        _processor = null;
    }

    private function onSocketData(event:ProgressEvent):void
    {
        LOG.debug("received socket data");

        var commandResult : String;

        if(_socket.bytesAvailable > 0)
        {
            try
            {
                LOG.debug("bytes available: " + _socket.bytesAvailable);
                var commandReceived : String = _socket.readUTFBytes( _socket.bytesAvailable);
                LOG.debug("Received command: " + commandReceived);
            }
            catch(error:Error)
            {
                LOG.error("error reading socket data: " + error.message);
                var res : WireResult = new WireResult(WireResult.ERROR, "could not read data from socket", []);
                commandResult = res.toJsonString();
                _socket.writeUTF(commandResult + "\n");
                _socket.flush();
                LOG.error("sent: " + commandResult);
                return;
            }

            commandReceived = commandReceived.slice(0, commandReceived.length - 1); //trimming \n

            try
            {
                commandResult = _processor.process(commandReceived);
                LOG.debug("Command processed. Sending response: " + commandResult);
            }
            catch(error:Error)
            {
                LOG.error("error processing command received: " + error.toString());
                res = new WireResult(WireResult.ERROR, "error processing command received", []);
                commandResult = res.toJsonString();
            }


            _socket.writeUTF(commandResult + "\n");
            _socket.flush();
        }




    }
}
}
