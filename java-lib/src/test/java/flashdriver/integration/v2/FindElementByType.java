package flashdriver.integration.v2;

import flashdriver.core.By;
import flashdriver.exceptions.ElementNotFoundException;
import org.junit.Test;

import static junit.framework.TestCase.assertTrue;

public class FindElementByType extends IntegrationTestBase {


    public static final String MY_CIRCLE_TYPE = "flashselenium.testapps::MyCircle";
    public static final String MY_SQUARE_TYPE = "flashselenium.testapps.MyLabel";
    public static final String MY_LABEL_TYPE = "flashselenium.testapps.MySquare";
    public static final String TEST_APP_TYPE = "flashselenium.testapps.TestApp";

    @Test
    public void findElements() {
        flashDriver.findElement(By.type(MY_CIRCLE_TYPE)).exists();
        flashDriver.findElement(By.type(MY_SQUARE_TYPE)).exists();
        flashDriver.findElement(By.type(MY_LABEL_TYPE)).exists();
        flashDriver.findElement(By.type(TEST_APP_TYPE)).exists();
        assertTrue(true);
    }

    @Test(expected = ElementNotFoundException.class)
    public void elementNotFound_throwsException() {
        flashDriver.findElement(By.type("foo.MyClass")).exists();
    }
}
