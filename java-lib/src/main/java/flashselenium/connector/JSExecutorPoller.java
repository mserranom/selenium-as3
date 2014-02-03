package flashselenium.connector;

import flashselenium.connector.JSBridge;
import org.openqa.selenium.NoSuchElementException;

import static java.lang.Thread.sleep;

public class JSExecutorPoller {

    private JSBridge _jsBridge;

    public JSExecutorPoller(JSBridge jsBridge) {
        _jsBridge = jsBridge;
    }

    public Object execute(String script) {
        int MAX_ATTEMPTS = 10;
        int INTERVAL = 500;

        int attemptCount = 0;

        while(true) {
            try {
                return _jsBridge.executeViewSpy(script);
            }
            catch(NoSuchElementException e) {
                if(attemptCount > MAX_ATTEMPTS) {
                    throw e;
                } else {
                    doWait(INTERVAL);
                    attemptCount++;
                }
            }
        }
    }

    private void doWait(long millis) {
        try {
            sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
