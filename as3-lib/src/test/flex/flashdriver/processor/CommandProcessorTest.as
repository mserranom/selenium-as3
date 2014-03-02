package flashdriver.processor
{
import asmock.framework.MockRepository;
import asmock.framework.SetupResult;
import asmock.integration.flexunit.IncludeMocksRule;

import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.MouseEvent;

import flashdriver.messages.Selector;

import flashdriver.messages.WireCommand;

import flashdriver.processor.vo.BooleanBasedVO;
import flashdriver.processor.vo.IntegerBasedVO;
import flashdriver.processor.vo.NumberBasedVO;

import flashdriver.processor.vo.StringBasedVO;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;

import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;

public class CommandProcessorTest
{
    [Rule]
    public var includeMocks : IncludeMocksRule = new IncludeMocksRule([
        ElementCacheProxy]);

    private var mockRepo : MockRepository;

    private var elementCacheProxyMock : ElementCacheProxy;

    private var processor : CommandProcessor;

    [Before]
    public function setup() : void
    {
        mockRepo = new MockRepository();
        elementCacheProxyMock = mockRepo.createStub(ElementCacheProxy) as ElementCacheProxy;
        mockRepo.replayAll();

        processor = new CommandProcessor(elementCacheProxyMock);
    }

    [Test]
    public function existsCommands_returnCorrectResult() : void
    {
        const element : Object = { myProp : "myValue" };
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.EXISTS, selector, []);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertStrictlyEquals("", processor.process(command));
    }

    [Test]
    public function getProperty_returnCorrectResult() : void
    {
        const element : Object = { myProp : "myValue" };
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.GET_PROPERTY, selector, ["myProp"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("myValue", processor.process(command));
    }


    // click command

    [Test]
    public function clickCommands_returnCorrectResult() : void
    {
        const element : MovieClip = new MovieClip();
        element.myProp = "myValue";
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.CLICK, selector, []);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertStrictlyEquals("", processor.process(command));
    }

    [Test]
    public function clickCommands_clicksDisplayObject() : void
    {
        var eventWasTriggered : Boolean = false; // mocks weren't working properly

        const element : Sprite = new Sprite();
        element.addEventListener(MouseEvent.CLICK, function(e:*) {eventWasTriggered = true});

        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.CLICK, selector, []);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);

        mockRepo.replayAll();

        processor.process(command);

        assertTrue(eventWasTriggered);
    }



    // Setting string values

    [Test]
    public function setProperty_setsValue_String() : void
    {
        const element : StringBasedVO = new StringBasedVO();
        element.property = "myValue";
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","newValue"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals("newValue", element.property);
    }

    [Test]
    public function setProperty_setsValue_String_asBoolean() : void
    {
        const element : StringBasedVO = new StringBasedVO();
        element.property = "false";
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","true"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals("true", element.property);
    }

    [Test]
    public function setProperty_setsValue_String_asNumber() : void
    {
        const element : StringBasedVO = new StringBasedVO();
        element.property = "myValue";
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","921.66"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals("921.66", element.property);
    }

    [Test]
    public function setProperty_setsValue_String_asNumber_NaN() : void
    {
        const element : StringBasedVO = new StringBasedVO();
        element.property = "myValue";
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","NaN"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals("NaN", element.property);
    }



    // Setting Boolean values

    [Test]
    public function setProperty_setsValueFalse_Boolean() : void
    {
        const element : BooleanBasedVO = new BooleanBasedVO();
        element.property = true;
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","false"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertFalse(element.property);
    }

    [Test]
    public function setProperty_setsValueTrue_Boolean() : void
    {
        const element : BooleanBasedVO = new BooleanBasedVO();
        element.property = false;
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","true"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertTrue(element.property);
    }


    // Setting Number values

    [Test]
    public function setProperty_setsValue_Number() : void
    {
        const element : NumberBasedVO = new NumberBasedVO();
        element.property = 111;
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","412.7"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals(412.7, element.property);
    }

    [Test]
    public function setProperty_setsValue_Number_NaN() : void
    {
        const element : NumberBasedVO = new NumberBasedVO();
        element.property = 111;
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","NaN"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertTrue(isNaN(element.property));
    }



    // Setting Integer values

    [Test]
    public function setProperty_setsValue_Integer() : void
    {
        const element : IntegerBasedVO = new IntegerBasedVO();
        element.property = 111;
        const selector : Selector = new Selector(Selector.ID, "myID");
        const command : WireCommand = new WireCommand(WireCommand.SET_PROPERTY, selector, ["property","412"]);

        mockRepo.backToRecord(elementCacheProxyMock);
        SetupResult.forCall(elementCacheProxyMock.getElement(selector)).returnValue(element);
        mockRepo.replayAll();

        assertEquals("", processor.process(command));
        assertEquals(412, element.property);
    }
}
}
