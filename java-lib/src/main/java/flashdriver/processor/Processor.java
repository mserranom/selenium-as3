package flashdriver.processor;

import flashdriver.messages.WireCommand;
import flashdriver.messages.WireResult;
import flashdriver.messages.WireResultParser;
import flashdriver.socket.FlashDriverConnection;
import org.json.simple.parser.ParseException;

import java.io.IOException;

public class Processor {

    FlashDriverConnection connection;

    public WireResult process(WireCommand command) throws ParseException, IOException {
        String response = connection.sendRequest(command.toJsonString());
        return WireResultParser.parse(response);
    }

    public void connect(int port) throws IOException {
        connection = new FlashDriverConnection();
        connection.connect(port);
    }

    public void disconnect() throws IOException {
        connection.close();
    }
}
