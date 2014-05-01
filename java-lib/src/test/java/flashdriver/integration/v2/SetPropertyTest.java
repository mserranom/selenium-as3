package flashdriver.integration.v2;

import flashdriver.core.By;
import flashdriver.core.FlashElement;
import flashdriver.exceptions.PropertySetException;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;

public class SetPropertyTest extends IntegrationTestBase {

    @Test
    public void textSetter() {
        FlashElement element = flashDriver.findElement(By.id("rect1"));
        assertEquals(100, element.getInt("x"));
        element.setProperty("x", "312");
        assertEquals(312, element.getInt("x"));
    }

    @Test(expected = PropertySetException.class)
    public void setting_readOnly_throws_propertySetException() throws Exception{
        FlashElement element = flashDriver.findElement(By.id("rect1"));
        try {
            element.setProperty("mouseX", "312");
        } catch (PropertySetException e) {
            assertEquals("mouseX", e.getProperty());
            assertEquals("312", e.getValue());
            assertEquals("flashselenium.testapps::MySquare", e.getClazz());
            assertThat(e.getFlashErrorMessage(), containsString("Error #1074"));
            throw e;
        }
    }

}
