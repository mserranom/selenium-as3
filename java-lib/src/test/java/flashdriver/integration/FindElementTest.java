package flashdriver.integration;

import flashdriver.FlashDriver;
import flashdriver.core.By;
import flashdriver.exceptions.ElementNotFoundException;
import org.junit.Test;

import java.io.IOException;

import static junit.framework.TestCase.assertTrue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;

public class FindElementTest extends IntegrationTestBase {

    @Test
    public void findElements() throws Exception{
        flashDriver.findElement(By.ID("label")).exists();
        flashDriver.findElement(By.ID("rect1")).exists();
        flashDriver.findElement(By.ID("rect2")).exists();
        assertTrue(true);
    }

    @Test
    public void waitForElement() throws Exception{
        flashDriver.waitForElement(By.ID("label")).exists();
        assertTrue(true);
    }

    @Test(expected = ElementNotFoundException.class)
    public void elementNotFound_throwsException_and_defaultTimeout_isCorrect() throws IOException {
        long watch = System.currentTimeMillis();
        try {
            flashDriver.waitForElement(By.ID("foo")).exists();
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(FlashDriver.DEFAULT_TIMEOUT));
        }
    }

    @Test(expected = ElementNotFoundException.class)
    public void elementNotFound_throwsException_and_timeoutSet_isCorrect() throws IOException {
        long watch = System.currentTimeMillis();
        try {
            flashDriver.waitForElement(By.ID("foo"), 1000).exists();
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(1000L));
        }
    }

    @Test(expected = ElementNotFoundException.class)
    public void findElements_throwsError() throws Exception{
        flashDriver.findElement(By.ID("fooxfx")).exists();
    }

}
