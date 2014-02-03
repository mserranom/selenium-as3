package flashselenium.test;

import flashselenium.connector.JSBridge;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class JSBridgeTest {

    private static String TEST_JS_BRIDGE = "http://localhost:8080/testJSBridge.html";
    private static String TEST_APP = "http://localhost:8080/testApp.html";

    private FirefoxDriver driver;
    private JSBridge jsBridge;

    @Before
    public void openBrowser() {

        driver = new FirefoxDriver();
        jsBridge = new JSBridge(driver, "mySWF");
    }

    @After
    public void closeBrowser() throws IOException {
        driver.quit();
    }

    @Test
    public void testCreateJSCallback() throws IOException {
        driver.get(TEST_JS_BRIDGE);
        jsBridge.createJSCallback();
        driver.executeScript("window.testFlashSuiteACK()");
        assertTrue(jsBridge.isFlashConnectionACKed());
    }

    @Test
    public void testConnection_isInitially_nonAcked() throws IOException {
        driver.get(TEST_JS_BRIDGE);
        jsBridge.createJSCallback();
        assertFalse(jsBridge.isFlashConnectionACKed());
    }

    @Test
    public void testWaitACK() throws Exception {
        driver.get(TEST_APP);
        jsBridge.createJSCallback();
        jsBridge.waitForConnectionACK();
    }

}