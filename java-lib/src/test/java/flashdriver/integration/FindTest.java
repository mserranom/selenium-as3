package flashdriver.integration;

import flashdriver.FlashDriver;
import flashdriver.core.By;
import flashdriver.core.FlashDriverException;
import flashdriver.core.FlashElement;
import junit.framework.Assert;
import org.json.simple.parser.ParseException;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.io.IOException;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertFalse;
import static junit.framework.TestCase.assertTrue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;

public class FindTest {

    private static final String TEST_APP = "http://localhost:8080/testApp2.html";

    private FirefoxDriver driver;
    private FlashDriver flashDriver;

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

    @Test
    public void testFindElements() throws Exception{
        flashDriver.findElement(By.ID("label")).exists();
        flashDriver.findElement(By.ID("rect1")).exists();
        flashDriver.findElement(By.ID("rect2")).exists();
        assertTrue(true);
    }

    @Test
    public void testWaitForElement() throws Exception{
        flashDriver.waitForElement(By.ID("label")).exists();
        assertTrue(true);
    }

    @Test(expected = FlashDriverException.class)
    public void elementNotFound_throwsException_and_defaultTimeout_isCorrect() throws IOException, ParseException {
        long watch = System.currentTimeMillis();
        try {
            flashDriver.waitForElement(By.ID("foo")).exists();
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(FlashDriver.DEFAULT_TIMEOUT));
        }
    }

    @Test(expected = FlashDriverException.class)
    public void elementNotFound_throwsException_and_timeoutSet_isCorrect() throws IOException, ParseException {
        long watch = System.currentTimeMillis();
        try {
            flashDriver.waitForElement(By.ID("foo"), 1000).exists();
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(1000L));
        }
    }

    @Test(expected = FlashDriverException.class)
    public void testFindElements_throwsError() throws Exception{
        flashDriver.findElement(By.ID("fooxfx")).exists();
    }

    @Test
    public void getString_returnsValue() throws Exception{
        assertEquals("100", flashDriver.findElement(By.ID("rect1")).getString("x"));
    }

    @Test
    public void getNumber_returnsValue() throws Exception{
        assertEquals(100F, flashDriver.findElement(By.ID("rect1")).getNumber("x"));
    }

    @Test
    public void getInt_returnsValue() throws Exception{
        assertEquals(100, flashDriver.findElement(By.ID("rect1")).getInt("x"));
    }

    @Test
    public void getBoolean_returnsValue() throws Exception{
        assertTrue(flashDriver.findElement(By.ID("rect1")).getBoolean("doubleClickEnabled"));
        assertFalse(flashDriver.findElement(By.ID("rect2")).getBoolean("doubleClickEnabled"));
    }

    @Test
    public void testTextSetter() throws Exception{
        FlashElement element = flashDriver.findElement(By.ID("rect1"));
        assertEquals(100, element.getInt("x"));
        element.setProperty("x", "312");
        assertEquals(312, element.getInt("x"));
    }

}
