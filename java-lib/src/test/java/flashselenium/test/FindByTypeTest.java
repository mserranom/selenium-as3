package flashselenium.test;

import flashselenium.core.By;
import flashselenium.core.ExpectedConditions;
import flashselenium.core.FlashDriver;
import flashselenium.exceptions.FlashTypeNotFoundException;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertEquals;

public class FindByTypeTest {


    private static final String TEST_APP = "http://localhost:8080/testApp.html";

    private static final String MY_LABEL_CLASS = "flashselenium.testapps::MyLabel";
    private static final String MY_CIRCLE_CLASS = "flashselenium.testapps::MyCircle";

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

    @Test(expected = FlashTypeNotFoundException.class)
    public void classNotFoundException()  throws Exception{
        flashApp.findElement(By.type("pack.Clazz")).getString(TEXT_PROPERTY);
    }

    @Test(expected = NoSuchElementException.class)
    public void elementNotFoundException()  throws Exception{
        flashApp.findElement(By.type("flash.display.MovieClip")).getString(TEXT_PROPERTY);
    }

    @Test
    public void checkExists_passes_withCircle() {
       flashApp.findElement(By.type(MY_LABEL_CLASS)).exists();
    }

    @Test
    public void circleExists() {
        assertTrue(flashApp.findElement(By.type(MY_CIRCLE_CLASS)).exists());
    }

    @Test
    public void movieClip_doesNot_exist() {
        assertFalse(flashApp.findElement(By.type("flash.display.MovieClip")).exists());
    }

    @Test(expected = FlashTypeNotFoundException.class)
    public void checkExists_breaks_withNonExistingClass() {
       flashApp.findElement(By.type("pack.Clazz")).exists();
    }
}
