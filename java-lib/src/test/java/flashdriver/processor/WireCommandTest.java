package flashdriver.processor;

import flashdriver.messages.Selector;
import flashdriver.messages.SelectorType;
import flashdriver.messages.WireCommand;
import flashdriver.messages.WireCommandType;
import junit.framework.TestCase;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class WireCommandTest extends TestCase {

    private WireCommand command;

    @Test
    public void testExists_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"id\":\"myId\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testClick_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        command = new WireCommand(WireCommandType.CLICK, selector);
        String expectedJSon = "[\"click\",{\"id\":\"myId\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testGetProperty_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        List<String> params = new ArrayList<String>();
        params.add("propName");
        command = new WireCommand(WireCommandType.GET_PROPERTY, selector, params);
        String expectedJSon = "[\"getProperty\",{\"id\":\"myId\"},\"propName\"]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testSetProperty_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        List<String> params = new ArrayList<String>();
        params.add("propName");
        params.add("propValue");
        command = new WireCommand(WireCommandType.SET_PROPERTY, selector, params);
        String expectedJSon = "[\"setProperty\",{\"id\":\"myId\"},\"propName\",\"propValue\"]";
        assertEquals(expectedJSon, command.toJsonString());
    }
}
