package flashdriver.integration;

import flashdriver.core.By;
import flashdriver.exceptions.PropertyNotFoundException;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertFalse;
import static junit.framework.TestCase.assertTrue;

public class GetPropertyTest extends IntegrationTestBase {

    @Test
    public void findElements() throws Exception{
        flashDriver.findElement(By.ID("label")).exists();
        flashDriver.findElement(By.ID("rect1")).exists();
        flashDriver.findElement(By.ID("rect2")).exists();
        assertTrue(true);
    }

    @Test(expected = PropertyNotFoundException.class)
    public void propertyNotFoundException_isThrown() throws Exception{
        assertEquals("100", flashDriver.findElement(By.ID("rect1")).getString("xfxfxf"));
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

}
