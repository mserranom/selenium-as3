package flashselenium.test;

import flashselenium.core.By;
import flashselenium.core.ExpectedConditions;
import flashselenium.core.FlashDriver;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;

public class ExplicitWaitsTest {


    private static final String TEST_APP = "http://localhost:8080/testApp.html";

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

    @Test(expected = NoSuchElementException.class)
    public void elementNotFound_throwsException_and_timeout_isCorrect() {
        long watch = System.currentTimeMillis();
        try {
            flashApp.doWait().until(ExpectedConditions.elementIsPresent(By.type("flash.display.MovieClip")));
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(5000L));
        }
    }

}
