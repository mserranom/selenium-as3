package flashdriver.processor
{
import flashdriver.messages.Selector;
import flashdriver.messages.WireCommand;
import flashdriver.messages.WireCommandParser;

import org.flexunit.asserts.assertEquals;

public class WireCommandParserTest
{

    private var parser : WireCommandParser;

    [Before]
    public function setup() : void
    {
        parser = new WireCommandParser();
    }

    [Test]
    public function testExists_isParsedCorrectly() : void
    {
        const command : WireCommand = parser.parse(ExampleMessages.EXISTS_BY_ID);
        assertEquals(WireCommand.EXISTS, command.type);
        assertEquals(Selector.ID, command.selector.type);
        assertEquals("myId", command.selector.value1);
    }

    [Test]
    public function testClick_isParsedCorrectly() : void
    {
        const command : WireCommand = parser.parse(ExampleMessages.CLICK_BY_ID);
        assertEquals(WireCommand.CLICK, command.type);
        assertEquals(Selector.ID, command.selector.type);
        assertEquals("myId", command.selector.value1);
    }

    [Test]
    public function testGetProperty_isParsedCorrectly() : void
    {
        const command : WireCommand = parser.parse(ExampleMessages.GET_PROPERTY_BY_ID);
        assertEquals(WireCommand.GET_PROPERTY, command.type);
        assertEquals(Selector.ID, command.selector.type);
        assertEquals("myId", command.selector.value1);
        assertEquals("myProp", command.params[0]);
    }

    [Test]
    public function testSetProperty_isParsedCorrectly() : void
    {
        const command : WireCommand = parser.parse(ExampleMessages.SET_PROPERTY_BY_ID);
        assertEquals(WireCommand.SET_PROPERTY, command.type);
        assertEquals(Selector.ID, command.selector.type);
        assertEquals("myId", command.selector.value1);
        assertEquals("myProp", command.params[0]);
        assertEquals("myValue", command.params[1]);
    }

    [Test]
    public function testExecute_isParsedCorrectly() : void
    {
        const command : WireCommand = parser.parse(ExampleMessages.EXECUTE);
        assertEquals(WireCommand.EXECUTE, command.type);
        assertEquals(Selector.ID, command.selector.type);
        assertEquals("myId", command.selector.value1);
        assertEquals("param", command.params[0]);
    }


    [Test(expects="Error")]
    public function testWrongCommandType_throwsError() : void
    {
        parser.parse(ExampleMessages.WRONG_COMMAND);
    }

    [Test(expects="Error")]
    public function testWrongSelector_throwsError() : void
    {
        parser.parse(ExampleMessages.NO_SELECTOR);
    }

    [Test(expects="Error")]
    public function testWrongParamCount_getProperty_throwsError() : void
    {
        parser.parse(ExampleMessages.MISSING_GET_PROP_PARAMS);
    }

    [Test(expects="Error")]
    public function testWrongParamCount_setProperty_throwsError() : void
    {
        parser.parse(ExampleMessages.MISSING_SET_PROP_PARAMS);
    }
}
}
