package flashdriver.integration;

import flashdriver.core.By;
import flashdriver.exceptions.ExpectationException;
import flashdriver.exceptions.PropertyNotFoundException;
import org.junit.Test;

import static junit.framework.TestCase.assertTrue;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.greaterThan;

public class ExpectPropertyHasValueTest extends IntegrationTestBase {

    @Test
    public void when_propertyIsFound_waitReturns() throws Exception{
        flashDriver.waitUntilElement(By.id("rect1")).hasPropertyValue("x", "100");
        assertTrue(true);
    }

    @Test(expected = PropertyNotFoundException.class)
    public void propertyNotFoundException_isThrown() throws Exception{
        flashDriver.waitUntilElement(By.id("rect1")).hasPropertyValue("foo", "");
    }

    @Test(expected = PropertyNotFoundException.class)
    public void propertyNotFoundException_isThrown_withCorrectTimeouts() throws Exception{
        long watch = System.currentTimeMillis();
        try {
            flashDriver.withTimeout(1500, 200).waitUntilElement(By.id("rect1")).hasPropertyValue("foo", "");
        } finally {
            assertThat(System.currentTimeMillis() - watch, greaterThan(1500L));
        }
    }

    @Test(expected = ExpectationException.class)
    public void when_propertyHasDifferentValue_expectationExceptionIsThrown_containingValues() throws Exception{
        String realValueRect1DotX = "100";
        try {
            flashDriver.waitUntilElement(By.id("rect1")).hasPropertyValue("x", "1234");
        } catch (ExpectationException exception){
            assertThat(exception.getMessage(), containsString(realValueRect1DotX));
            assertThat(exception.getMessage(), containsString("1234"));
            throw exception;
        }
    }

    @Test(expected = PropertyNotFoundException.class)
    public void inverseQuery_when_propertyIsNotFound_throwsException() throws Exception{
        flashDriver.waitUntilElement(By.id("rect1")).not().hasPropertyValue("foo", "");
        assertTrue(true);
    }

    @Test
    public void inverseQuery_when_valueNotCorrect_waitReturns() throws Exception{
        flashDriver.waitUntilElement(By.id("rect1")).not().hasPropertyValue("x", "110");
        assertTrue(true);
    }
}

