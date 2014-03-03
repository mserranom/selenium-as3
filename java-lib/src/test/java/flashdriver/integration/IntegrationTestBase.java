package flashdriver.integration;

import flashdriver.FlashDriver;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

public class IntegrationTestBase {

    private static final String TEST_APP = "http://localhost:8080/testApp2.html";

    private FirefoxDriver driver;

    protected FlashDriver flashDriver;

    @Before
    public void openBrowser() throws Exception {
        driver = new FirefoxDriver();
        driver.get(TEST_APP);
        flashDriver = new FlashDriver();
        flashDriver.connect();
    }

    @After
    public void closeBrowser() throws IOException {
        driver.quit();
        flashDriver.close();
    }

}
