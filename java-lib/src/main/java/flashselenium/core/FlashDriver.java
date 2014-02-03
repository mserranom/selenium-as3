package flashselenium.core;

import flashselenium.connector.JSBridge;
import flashselenium.core.impl.DisplayObjectDriverImpl;
import org.openqa.selenium.JavascriptExecutor;

public class FlashDriver {

    private JavascriptExecutor _driver;

    private String _swfObjectID;

    private JSBridge _jsBridge;

    public FlashDriver(JavascriptExecutor driver, String swfObjectID) {
        _driver = driver;
        _swfObjectID = swfObjectID;
    }

    public void connect() throws Exception {
        _jsBridge = new JSBridge(_driver, _swfObjectID);
        _jsBridge.createJSCallback();
        _jsBridge.waitForConnectionACK();
    }

    public DisplayObjectDriver findElement(By by) {
        return new DisplayObjectDriverImpl(_jsBridge).findElement(by);
    }

    public Wait doWait() {
        return new Wait(_jsBridge);
    }


}
