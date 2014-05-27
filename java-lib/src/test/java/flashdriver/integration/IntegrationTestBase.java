package flashdriver.integration;

import flashdriver.BinarySocketFlashDriver;
import flashdriver.FlashDriver;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.rules.Timeout;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

public class IntegrationTestBase {

    private static final String TEST_APP = "http://localhost:8080/testApp2.html";

    private FirefoxDriver driver;

    protected FlashDriver flashDriver;

    @Rule
    public Timeout globalTimeout = new Timeout(25000);

    @Before
    public void openBrowser() throws Exception {
        driver = new FirefoxDriver();
        driver.get(TEST_APP);
        while(flashDriver == null)
        {
            try {
                flashDriver = new BinarySocketFlashDriver();
                flashDriver.connect();
            } catch(Exception e) {
                flashDriver = null;
            }
        }
        flashDriver.setDefaultTimeout(800, 200);
    }

    @After
    public void closeBrowser() throws IOException {
        driver.quit();
        flashDriver.close();
    }

}
