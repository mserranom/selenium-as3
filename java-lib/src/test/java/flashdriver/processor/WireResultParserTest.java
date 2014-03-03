package flashdriver.processor;

import flashdriver.exceptions.FlashDriverInternalException;
import flashdriver.messages.WireResult;
import flashdriver.messages.WireResultParser;
import flashdriver.messages.WireResultType;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class WireResultParserTest {

    @Test
    public void testParse_success() throws Exception {
        String msg = "[\"success\",\"successMessage\"]";
        WireResult sut = WireResultParser.parse(msg);
        assertEquals(WireResultType.SUCCESS, sut.getType());
        assertEquals("successMessage", sut.getResult());
    }

    @Test
    public void testParse_error() throws Exception {
        String msg = "[\"error\",\"errorMessage\",[\"param1\",\"param2\"]]";
        WireResult sut = WireResultParser.parse(msg);
        assertEquals(WireResultType.ERROR, sut.getType());
        assertEquals("errorMessage", sut.getResult());
        assertEquals("param1", sut.getParams().get(0));
        assertEquals("param2", sut.getParams().get(1));
    }

    @Test
    public void testRemainingParams_areIgnored_forSuccess() throws Exception {
        String msg = "[\"success\",\"successMessage\",\"notRequiredParam\"]";
        WireResult sut = WireResultParser.parse(msg);
        assertEquals(WireResultType.SUCCESS, sut.getType());
        assertEquals("successMessage", sut.getResult());
    }

    @Test(expected = RuntimeException.class)
    public void testOneParameterOnly_throwsException() throws Exception {
        String msg = "[\"success\"]";
        WireResult sut = WireResultParser.parse(msg);
    }

    @Test(expected = FlashDriverInternalException.class)
    public void testNoArrayAsThirdParameter_inError_throwsException() throws Exception {
        String msg = "[\"error\",\"successMessage\",\"notRequiredParam\"]";
        WireResult sut = WireResultParser.parse(msg);
    }
}
