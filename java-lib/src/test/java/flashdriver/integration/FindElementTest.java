package flashdriver.integration;

import flashdriver.core.By;
import flashdriver.exceptions.ElementNotFoundException;
import org.junit.Test;

import java.io.IOException;

import static junit.framework.TestCase.assertTrue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.greaterThan;

public class FindElementTest extends IntegrationTestBase {

    @Test
    public void findElements() {
        flashDriver.findElement(By.id("label")).exists();
        flashDriver.findElement(By.id("rect1")).exists();
        flashDriver.findElement(By.id("rect2")).exists();
        assertTrue(true);
    }

    @Test
    public void findElement_withTimeout() {
        flashDriver.withTimeout(200).findElement(By.id("label")).exists();
        assertTrue(true);
    }

    @Test(expected = ElementNotFoundException.class)
    public void elementNotFound_throwsException_and_timeout_isCorrect() throws IOException {
        long watch = System.currentTimeMillis();
        try {
            flashDriver.withTimeout(1500, 200).findElement(By.id("foo")).exists();
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(1500L));
        }
    }

    @Test(expected = ElementNotFoundException.class)
    public void findElements_throwsError() throws Exception{
        flashDriver.findElement(By.id("foo1234")).exists();
    }

}
