package flashdriver.core;

import flashdriver.exceptions.ExceptionFactory;
import flashdriver.messages.*;
import flashdriver.processor.Processor;

import java.util.List;

public class FlashFunction {

    private Selector selector;

    private Processor processor;

    public FlashFunction(Selector selector, Processor processor) {
        this.selector = selector;
        this.processor = processor;
    }

    public String execute(List<String> params) {
        WireCommand command = new WireCommand(WireCommandType.EXECUTE, selector, params);
        WireResult result = processor.process(command);
        if(result.getType() == WireResultType.ERROR) {
            throw ExceptionFactory.fromError(result);
        }
        return result.getResult();
    }

}
