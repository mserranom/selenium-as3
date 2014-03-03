package flashdriver.core;

import flashdriver.exceptions.ExceptionFactory;
import flashdriver.messages.*;
import flashdriver.processor.Processor;

import java.util.ArrayList;
import java.util.List;

public class FlashElement {

    private Selector selector;

    private Processor processor;

    public FlashElement(Selector selector, Processor processor) {
        this.selector = selector;
        this.processor = processor;
    }

    public void exists() {
        WireCommand command = new WireCommand(WireCommandType.EXISTS, selector);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw ExceptionFactory.fromError(result);
        }
    }

    public void click() {
        WireCommand command = new WireCommand(WireCommandType.CLICK, selector);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw ExceptionFactory.fromError(result);
        }
    }

    public void setProperty(String property, String value) {
        List<String> params = new ArrayList<String>(2);
        params.add(property);
        params.add(value);
        WireCommand command = new WireCommand(WireCommandType.SET_PROPERTY, selector, params);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw ExceptionFactory.fromError(result);
        }
    }

    public String getString(String property) {
        List<String> params = new ArrayList<String>(1);
        params.add(property);
        WireCommand command = new WireCommand(WireCommandType.GET_PROPERTY, selector, params);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw ExceptionFactory.fromError(result);
        }
        return result.getResult();
    }

    public float getNumber(String property) {
        String result = getString(property);
        return Float.parseFloat(result);
    }

    public int getInt(String property) {
        String result = getString(property);
        return Integer.parseInt(result);
    }

    public boolean getBoolean(String property) {
        String result = getString(property);
        return Boolean.parseBoolean(result);
    }

}
