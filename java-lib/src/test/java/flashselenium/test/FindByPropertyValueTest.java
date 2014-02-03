package flashselenium.test;

import flashselenium.core.By;
import flashselenium.core.FlashDriver;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class FindByPropertyValueTest {

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

    @Test
    public void testShapeCircleFound()  throws Exception{
        assertTrue(flashApp.findElement(By.propertyValue("shape", "circle")).exists());
    }

    @Test
    public void testPropertyNotFound()  throws Exception{
        assertFalse(flashApp.findElement(By.propertyValue("tryeiyiye", "circle")).exists());
    }

    @Test
    public void testValueNotFound()  throws Exception{
        assertFalse(flashApp.findElement(By.propertyValue("shape", "ertwerwuw")).exists());
    }

    @Test
    public void shouldFindCircleWithAlphaEquals074()  throws Exception{
        assertTrue(flashApp.findElement(By.propertyValue("scaleX", 0.74)).exists());
    }

    @Test
    public void shouldNotFindCircleWithAlphaEquals053()  throws Exception{
        assertFalse(flashApp.findElement(By.propertyValue("scaleX", 0.53)).exists());
    }

    @Test
    public void shouldNotFindCircleWithVisibilityEqualsFalse()  throws Exception{
        assertFalse(flashApp.findElement(By.propertyValue("visible", false)).exists());
    }

    @Test
    public void shouldFindCircleWithDoubleClickEnabledEqualsTrue()  throws Exception{
        assertTrue(flashApp.findElement(By.propertyValue("doubleClickEnabled", true)).exists());
    }


}
