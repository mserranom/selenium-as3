package flashdriver.integration;

import flashdriver.core.By;
import flashdriver.core.FlashElement;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class SetPropertyTest extends IntegrationTestBase {

    @Test
    public void textSetter() throws Exception{
        FlashElement element = flashDriver.findElement(By.ID("rect1"));
        assertEquals(100, element.getInt("x"));
        element.setProperty("x", "312");
        assertEquals(312, element.getInt("x"));
    }

}
