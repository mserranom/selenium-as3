package flashselenium.test;

import flashselenium.core.By;
import flashselenium.core.FlashDriver;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.junit.Assert.assertEquals;

public class MouseInteractionTest {


    private static final String TEST_APP = "http://localhost:8080/testApp.html";

    private static final String MY_LABEL_CLASS = "flashselenium::MyLabel";
    private static final String MY_CIRCLE_CLASS = "flashselenium::MyCircle";

    private static final String TEXT_PROPERTY = "text";

    private FirefoxDriver driver;
    private FlashDriver flashApp;

    @Before
    public void openBrowser() throws Exception {
        driver = new FirefoxDriver();
        driver.get(TEST_APP);
        flashApp = new FlashDriver(driver, "mySWF");
        flashApp.connect();
    }

    @After
    public void closeBrowser() throws IOException {
        driver.quit();
    }

    @Test
    public void labelInitialValue()  throws Exception{
        assertEquals("CLICK THE CIRCLE", flashApp.findElement(By.type(MY_LABEL_CLASS)).getString(TEXT_PROPERTY));
    }

    @Test
    public void labelChanges_afterClickingCircle()  throws Exception{
        flashApp.findElement(By.type(MY_CIRCLE_CLASS)).click();
        assertEquals("CIRCLE CLICKED!!", flashApp.findElement(By.type(MY_LABEL_CLASS)).getString("text"));
    }

}
