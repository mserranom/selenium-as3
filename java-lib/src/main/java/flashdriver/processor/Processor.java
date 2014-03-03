package flashdriver.processor;

import flashdriver.messages.WireCommand;
import flashdriver.messages.WireResult;
import flashdriver.messages.WireResultParser;
import flashdriver.socket.FlashDriverConnection;

public class Processor {

    private FlashDriverConnection connection;

    private int connectionTimeout;

    public WireResult process(WireCommand command) {
        String response = connection.sendRequest(command.toJsonString());
        return WireResultParser.parse(response);
    }

    public void connect(int port) {
        connection = new FlashDriverConnection();
        connection.setConnectionTimeout(connectionTimeout);
        connection.connect(port);
    }

    public void disconnect() {
        connection.close();
    }

    public void setConnectionTimeout(int value) {
        this.connectionTimeout = value;
    }
}
