package flashdriver.processor;

import flashdriver.messages.Selector;
import flashdriver.messages.SelectorType;
import flashdriver.messages.WireCommand;
import flashdriver.messages.WireCommandType;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class WireCommandTest {

    private WireCommand command;



    // exists with different By options

    @Test
    public void testExists_byID_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"id\":\"myId\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testExists_byType_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.TYPE, "myType");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"type\":\"myType\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testExists_byLabel_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.LABEL, "myText");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"label\":\"myText\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testExists_byButtonLabel_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.BUTTON_LABEL, "myText");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"buttonLabel\":\"myText\"}]";
        assertEquals(expectedJSon, command.toJsonString());
    }

    @Test
    public void testExists_byTypeAndLabel_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.TYPE_AND_LABEL, "myType", "myText");
        command = new WireCommand(WireCommandType.EXISTS, selector);
        String expectedJSon = "[\"exists\",{\"typeAndLabel\":[\"myType\",\"myText\"]}]";
        assertEquals(expectedJSon, command.toJsonString());
    }



    // rest of commands

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

    @Test
    public void testExecute_producesCorrectJSON() {
        Selector selector = new Selector(SelectorType.ID, "myId");
        List<String> params = new ArrayList<String>();
        params.add("param1");
        params.add("param2");
        command = new WireCommand(WireCommandType.EXECUTE, selector, params);
        String expectedJSon = "[\"execute\",{\"id\":\"myId\"},\"param1\",\"param2\"]";
        assertEquals(expectedJSon, command.toJsonString());
    }
}
