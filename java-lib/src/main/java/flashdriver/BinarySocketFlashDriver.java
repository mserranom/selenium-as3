package flashdriver;

import flashdriver.processor.Processor;
import flashdriver.core.FlashDriverBase;

public class BinarySocketFlashDriver extends FlashDriverBase {


    public static final int DEFAULT_CONNECT_TIMEOUT = 30000;
    public static final int DEFAULT_PORT = 54081;

    private Processor processor;

    @Override
    public void connect() {
        this.connect(DEFAULT_PORT, DEFAULT_CONNECT_TIMEOUT);
    }

    @Override
    public void connect(int port) {
        this.connect(port, DEFAULT_CONNECT_TIMEOUT);
    }

    @Override
    public void connect(int port, int timeout) {
        processor = new Processor();
        processor.setConnectionTimeout(timeout);
        processor.connect(port);
    }

    @Override
    public void close() {
        if(processor != null) {
            processor.disconnect();
        }
    }

    @Override
    protected Processor getProcessor() {
        return processor;
    }

}
