package flashdriver.core;

import flashdriver.messages.*;
import flashdriver.processor.Processor;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FlashElement {

    private Selector selector;

    private Processor processor;

    public FlashElement(Selector selector, Processor processor) {
        this.selector = selector;
        this.processor = processor;
    }

    public void exists() throws IOException, ParseException {
        WireCommand command = new WireCommand(WireCommandType.EXISTS, selector);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw new FlashDriverException(result.getResult());
        }
    }

    public void click() throws IOException, ParseException {
        WireCommand command = new WireCommand(WireCommandType.CLICK, selector);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw new FlashDriverException(result.getResult());
        }
    }

    public void setProperty(String property, String value) throws IOException, ParseException {
        List<String> params = new ArrayList<String>(2);
        params.add(property);
        params.add(value);
        WireCommand command = new WireCommand(WireCommandType.SET_PROPERTY, selector, params);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw new FlashDriverException(result.getResult());
        }
    }

    public String getString(String property) throws IOException, ParseException {
        List<String> params = new ArrayList<String>(1);
        params.add(property);
        WireCommand command = new WireCommand(WireCommandType.GET_PROPERTY, selector, params);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw new FlashDriverException(result.getResult());
        }
        return result.getResult();
    }

    public float getNumber(String property) throws IOException, ParseException {
        String result = getString(property);
        return Float.parseFloat(result);
    }

    public int getInt(String property) throws IOException, ParseException {
        String result = getString(property);
        return Integer.parseInt(result);
    }

    public boolean getBoolean(String property) throws IOException, ParseException {
        String result = getString(property);
        return Boolean.parseBoolean(result);
    }

}
