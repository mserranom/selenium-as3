package flashdriver.integration.v2;

import flashdriver.exceptions.FlashDriverFunctionInvocationException;
import flashdriver.exceptions.FunctionNotFoundException;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class ExecuteFunctionTest extends IntegrationTestBase {

    @Test
    public void callback_isExecuted() {
        List<String> params = new ArrayList<String>();
        params.add("hello");
        params.add("world");
        assertEquals("hello world!!", flashDriver.executeFunction("callback", params));
    }

    @Test(expected = FunctionNotFoundException.class)
    public void wrongId_throwsFunctionNotFoundException() {
        assertEquals("hello world!!", flashDriver.executeFunction("xfxff"));
    }

    @Test(expected = FlashDriverFunctionInvocationException.class)
    public void wrongParams_throwsExecutionException() {
        List<String> params = new ArrayList<String>();
        params.add("hello");
        assertEquals("hello world!!", flashDriver.executeFunction("callback", params));
    }
}
