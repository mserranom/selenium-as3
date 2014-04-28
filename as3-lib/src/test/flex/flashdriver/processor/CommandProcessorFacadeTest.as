package flashdriver.processor
{
import asmock.framework.Expect;
import asmock.framework.MockRepository;
import asmock.integration.flexunit.IncludeMocksRule;

import flashdriver.error.ErrorCodes;
import flashdriver.messages.WireCommandParser;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertEquals;
import org.hamcrest.collection.arrayWithSize;
import org.hamcrest.core.isA;

public class CommandProcessorFacadeTest
{
    [Rule]
    public var includeMocks : IncludeMocksRule = new IncludeMocksRule([
        IWireCommandExecutor,WireCommandParser]);

    private var mockRepo : MockRepository;

    private var processorMock : IWireCommandExecutor;
    private var parserMock : WireCommandParser;

    private var processorFacade : CommandProcessorFacade;

    [Before]
    public function setup() : void
    {
        mockRepo = new MockRepository();
        processorMock = mockRepo.createStub(IWireCommandExecutor) as IWireCommandExecutor;
        parserMock = mockRepo.createStub(WireCommandParser) as WireCommandParser;
        mockRepo.replayAll();
        processorFacade = new CommandProcessorFacade(processorMock, parserMock)
    }

    [Test]
    public function testSuccess_returnsCorrectNumber() : void
    {
        mockForProcessorFacadeToReturn("123");

        const result : Object = JSON.parse(processorFacade.process("foo"));
        assertThat(result, arrayWithSize(3));
        assertEquals("success", result[0]);
        assertEquals("123", result[1]);
        assertThat(result[2], isA(arrayWithSize(0)));
        mockRepo.verifyAll();
    }

    [Test]
    public function testFail_returnsErrorMessage() : void
    {
        mockForProcessorFacadeToThrow("myErrorMessage");
        const result : Object = JSON.parse(processorFacade.process("foo"));
        assertThat(result, arrayWithSize(3));
        assertEquals("error", result[0]);
        assertEquals(ErrorCodes.INTERNAL, result[1]);
        assertEquals("myErrorMessage", result[2][0]);
        mockRepo.verifyAll();
    }

    private function mockForProcessorFacadeToReturn(value:String) : void
    {
        mockRepo.backToRecord(parserMock);
        Expect.call(parserMock.parse(null)).repeat.once().ignoreArguments().returnValue(null);

        mockRepo.backToRecord(processorMock);
        Expect.call(processorMock.execute(null)).repeat.once().ignoreArguments().returnValue(value);

        mockRepo.replayAll();
    }

    private function mockForProcessorFacadeToThrow(message:String) : void
    {
        mockRepo.backToRecord(parserMock);
        Expect.call(parserMock.parse(null)).repeat.once().ignoreArguments().returnValue(null);

        mockRepo.backToRecord(processorMock);
        Expect.call(processorMock.execute(null)).repeat.once().ignoreArguments().throwError(new Error(message));

        mockRepo.replayAll();
    }
}
}
