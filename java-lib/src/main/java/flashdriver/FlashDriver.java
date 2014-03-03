package flashdriver;


import flashdriver.core.By;
import flashdriver.core.FlashElement;
import flashdriver.exceptions.ElementNotFoundException;
import flashdriver.processor.Processor;

public class FlashDriver {

    public static final int DEFAULT_CONNECT_TIMEOUT = 30000;
    public static final long DEFAULT_POLL_INTERVAL = 500;
    public static final long DEFAULT_TIMEOUT = 5000;
    public static final int DEFAULT_PORT = 54081;

    private Processor processor;

    private int connectionTimeout = DEFAULT_CONNECT_TIMEOUT;

    public void connect() {
        this.connect(DEFAULT_PORT);
    }

    public void connect(int port) {
        processor = new Processor();
        processor.setConnectionTimeout(connectionTimeout);
        processor.connect(port);
    }

    public void close() {
        if(processor != null) {
            processor.disconnect();
        }
    }

    public void setConnectionTimeout(int value) {
        this.connectionTimeout = value;
    }

    public FlashElement findElement(By by) {
        FlashElement element = new FlashElement(by.getSelector(), processor);
        element.exists();
        return element;
    }

    public FlashElement waitForElement(By by) {
        return waitForElement(by, DEFAULT_TIMEOUT, DEFAULT_POLL_INTERVAL);
    }

    public FlashElement waitForElement(By by, float timeout) {
        return waitForElement(by, timeout, DEFAULT_POLL_INTERVAL);
    }

    public FlashElement waitForElement(By by, float timeout, float pollInterval) {

        int maxAttempts = (int) (timeout / pollInterval);
        int currentAttempt = 1;

        while(true) {
            if(currentAttempt > maxAttempts) {
                throw new ElementNotFoundException(by.getSelector().getValue());
            }

            try {
                FlashElement element = new FlashElement(by.getSelector(), processor);
                element.exists();
                return element;
            } catch (ElementNotFoundException e) { }

            try {
                Thread.sleep((long) pollInterval);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            currentAttempt++;
        }
    }

}
