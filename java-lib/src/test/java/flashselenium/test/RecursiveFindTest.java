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

public class RecursiveFindTest {

    /*
         App structure: app-> MySquare -> Sprite -> MySquare
     */

    private static final String TEST_APP = "http://localhost:8080/testApp.html";

    private static final String MY_SQUARE_CLASS = "flashselenium.testapps::MySquare";
    public static final String MOVIE_CLIP_CLASS = "flash.display.MovieClip";
    public static final String SPRITE_CLASS = "flash.display.Sprite";

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
    public void testFirstLevelFound()  throws Exception{
        assertTrue(flashApp.findElement(By.type(MY_SQUARE_CLASS)).exists());
    }

    @Test
    public void test2ndLevelFound()  throws Exception{
        assertTrue(flashApp.findElement(By.type(MY_SQUARE_CLASS))
                .findElement(By.type(SPRITE_CLASS))
                .exists());
    }

    @Test
    public void test2ndLevelFailure()  throws Exception{
        assertFalse(flashApp.findElement(By.type(MY_SQUARE_CLASS))
                .findElement(By.type(MOVIE_CLIP_CLASS))
                .exists());
    }

    @Test
    public void test3rdLevelFound()  throws Exception{
        assertTrue(flashApp.findElement(By.type(MY_SQUARE_CLASS))
                .findElement(By.type(SPRITE_CLASS))
                .findElement(By.type(MY_SQUARE_CLASS))
                .exists());
    }

    @Test
    public void testCrossesFrom1stTo3rdLevel()  throws Exception{
        assertTrue(flashApp.findElement(By.type(MY_SQUARE_CLASS))
                .findElement(By.type(MY_SQUARE_CLASS))
                .exists());
    }

}
