package flashdriver.processor
{
import asmock.framework.Expect;
import asmock.framework.MockRepository;
import asmock.integration.flexunit.IncludeMocksRule;

import flashdriver.messages.WireCommandParser;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertEquals;
import org.hamcrest.collection.arrayWithSize;

public class CommandProcessorFacadeTest
{
    [Rule]
    public var includeMocks : IncludeMocksRule = new IncludeMocksRule([
        ICommandProcessor,WireCommandParser]);

    private var mockRepo : MockRepository;

    private var processorMock : ICommandProcessor;
    private var parserMock : WireCommandParser;

    private var processorFacade : CommandProcessorFacade;

    [Before]
    public function setup() : void
    {
        mockRepo = new MockRepository();
        processorMock = mockRepo.createStub(ICommandProcessor) as ICommandProcessor;
        parserMock = mockRepo.createStub(WireCommandParser) as WireCommandParser;
        mockRepo.replayAll();
        processorFacade = new CommandProcessorFacade(processorMock, parserMock)
    }

    [Test]
    public function testSuccess_returnsCorrectNumber() : void
    {
        mockForProcessorFacadeToReturn("123");

        const result : Object = JSON.parse(processorFacade.process("foo"));
        assertThat(result, arrayWithSize(2));
        assertEquals("success", result[0]);
        assertEquals("123", result[1]);
        mockRepo.verifyAll();
    }

    [Test]
    public function testFail_returnsErrorMEssage() : void
    {
        mockForProcessorFacadeToThrow("myErrorMessage");
        const result : Object = JSON.parse(processorFacade.process("foo"));
        assertThat(result, arrayWithSize(2));
        assertEquals("error", result[0]);
        assertEquals("myErrorMessage", result[1]);
        mockRepo.verifyAll();
    }

    private function mockForProcessorFacadeToReturn(value:String) : void
    {
        mockRepo.backToRecord(parserMock);
        Expect.call(parserMock.parse(null)).repeat.once().ignoreArguments().returnValue(null);

        mockRepo.backToRecord(processorMock);
        Expect.call(processorMock.process(null)).repeat.once().ignoreArguments().returnValue(value);

        mockRepo.replayAll();
    }

    private function mockForProcessorFacadeToThrow(message:String) : void
    {
        mockRepo.backToRecord(parserMock);
        Expect.call(parserMock.parse(null)).repeat.once().ignoreArguments().returnValue(null);

        mockRepo.backToRecord(processorMock);
        Expect.call(processorMock.process(null)).repeat.once().ignoreArguments().throwError(new Error(message));

        mockRepo.replayAll();
    }
}
}
