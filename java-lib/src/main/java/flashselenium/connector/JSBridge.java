package flashselenium.connector;

import flashselenium.exceptions.ExceptionProcessor;
import flashselenium.exceptions.FlashConnectionException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriverException;

import static java.lang.Thread.sleep;

public class JSBridge {

    private JavascriptExecutor _driver;

    private String _swfObjectID;

    public JSBridge(JavascriptExecutor driver, String swfObjectID) {
        _driver = driver;
        _swfObjectID = swfObjectID;
    }

    public void createJSCallback() {
        String script = "window.testFlashSuiteACKed = false;"
                + "window.testFlashSuiteACK = function() { "
                + "window.testFlashSuiteACKed = true; };";
        _driver.executeScript(script);
    }

    public boolean isFlashConnectionACKed() {
        return (Boolean) _driver.executeScript("return window.testFlashSuiteACKed");
    }

    public void waitForConnectionACK() throws Exception {
        int i = 0;
        while(i < 40) {
            boolean isACKed = (Boolean) _driver.executeScript("return window.testFlashSuiteACKed");
            if(isACKed) {
                return;
            }
            doWait(200);
            i++;
        }
        throw new FlashConnectionException("Unable to ACK External Interface connection");
    }

    public Object executeViewSpy(String script){
        String wrappedScript = "return " + _swfObjectID + ".flashTestSuite_robotEyesScript( \"" + script + "\" )";

        try {
            return _driver.executeScript(wrappedScript);
        } catch(WebDriverException e) {
             new ExceptionProcessor().throwErrorFromMessage(e.getMessage());
        }

        return null;
    }

    private void doWait(long millis) {
        try {
            sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }


}
