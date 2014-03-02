package flashdriver;


import flashdriver.core.By;
import flashdriver.core.FlashElement;
import flashdriver.core.FlashDriverException;
import flashdriver.processor.Processor;
import org.json.simple.parser.ParseException;

import java.io.IOException;

public class FlashDriver {

    public static long DEFAULT_POLL_INTERVAL = 500;

    public static long DEFAULT_TIMEOUT = 5000;

    private Processor processor;

    public void connect() throws IOException {
        processor = new Processor();
        processor.connect(54080);
    }

    public void close() throws IOException {
        processor.disconnect();
    }

    public FlashElement findElement(By by) throws IOException, ParseException {
        FlashElement element = new FlashElement(by.getSelector(), processor);
        element.exists();
        return element;
    }

    public FlashElement waitForElement(By by) throws IOException, ParseException {
        return waitForElement(by, DEFAULT_TIMEOUT, DEFAULT_POLL_INTERVAL);
    }

    public FlashElement waitForElement(By by, float timeout) throws IOException, ParseException {
        return waitForElement(by, timeout, DEFAULT_POLL_INTERVAL);
    }

    public FlashElement waitForElement(By by, float timeout, float pollInterval) throws IOException, ParseException {

        int maxAttempts = (int) (timeout / pollInterval);
        int currentAttempt = 1;

        while(true) {
            if(currentAttempt > maxAttempts) {
                throw new FlashDriverException("unable to find element " + by.toString());
            }

            try {
                FlashElement element = new FlashElement(by.getSelector(), processor);
                element.exists();
                return element;
            } catch (FlashDriverException e) { }


            try {
                Thread.sleep((long) pollInterval);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            currentAttempt++;
        }
    }

}
