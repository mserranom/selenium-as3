package flashdriver.integration.v2;


import flashdriver.exceptions.FlashDriverConnectionException;
import flashdriver.v2.BinarySocketFlashDriver;
import flashdriver.v2.FlashDriver;
import org.junit.After;
import org.junit.Test;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;

public class ConnectionTest {

    private static final String TEST_APP = "http://localhost:8080/testApp2.html";
    private static final String TEST_APP_NO_CONN = "http://localhost:8080/testAppNoConnection.html";

    private FirefoxDriver driver;

    protected FlashDriver flashDriver;

    @After
    public void closeBrowser() throws IOException {
        if(driver != null) {
            driver.quit();

        }
        if(flashDriver != null) {
            flashDriver.close();
        }
    }

    @Test(expected = FlashDriverConnectionException.class)
    public void connectingToWrongPort_throwsConnectionException() {
        driver = new FirefoxDriver();
        driver.get(TEST_APP);
        flashDriver = new BinarySocketFlashDriver();
        flashDriver.connect(1271329876);
    }

    @Test
    public void closingNotOpenedConnection_doesNotThrowError() {
        flashDriver = new BinarySocketFlashDriver();
        flashDriver.close();
    }

    @Test(expected = FlashDriverConnectionException.class)
    public void connect_fails_onTimeout() {
        driver = new FirefoxDriver();
        driver.get(TEST_APP_NO_CONN);
        flashDriver = new BinarySocketFlashDriver();

        long watch = System.currentTimeMillis();
        try {
            flashDriver.connect(56666, 2200);
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(2200L));
        }

    }

}
