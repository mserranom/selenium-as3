package flashdriver.exceptions;

import flashdriver.messages.WireResult;

import java.util.List;

public class ExceptionFactory {

    private static final String ELEMENT_NOT_FOUND = "#10";

    private static final String PROPERTY_NOT_FOUND = "#11";

    private static final String FUNCTION_NOT_FOUND = "#12";

    private static final String UNABLE_TO_SET_PROPERTY = "#13";

    private static final String DISPLAY_ROOT_NOT_DEFINED = "#14";

    private static final String FUNCTION_INVOCATION_ERROR = "#21";

    private static final String INTERNAL = "#99";

    public static RuntimeException fromError(WireResult result) {
        if(result.getResult().equals(ELEMENT_NOT_FOUND)) {
            return createElementNotFound(result);
        } else if(result.getResult().equals(PROPERTY_NOT_FOUND)) {
            return createPropertyNotFound(result);
        } else if(result.getResult().equals(UNABLE_TO_SET_PROPERTY)) {
            return createPropertySet(result);
        } else if(result.getResult().equals(FUNCTION_NOT_FOUND)) {
            return createFunctionNotFound(result);
        } else if(result.getResult().equals(FUNCTION_INVOCATION_ERROR)) {
            return createFunctionInvocation(result);
        } else if(result.getResult().equals(DISPLAY_ROOT_NOT_DEFINED)) {
            return createDisplayRootNotDefined(result);
        } else if(result.getResult().equals(INTERNAL)) {
            return createInternal(result);
        } else {
            return new FlashDriverInternalException("Unknown error code " + result.getResult());
        }
    }

    private static RuntimeException createElementNotFound(WireResult result) {
        if(result.getParams().size() < 1) {
            return new FlashDriverInternalException("raising element not found exception requires an id");
        }
        return new ElementNotFoundException(result.getParams().get(0));
    }

    private static RuntimeException createPropertyNotFound(WireResult result) {
        if(result.getParams().size() < 2) {
            return new FlashDriverInternalException("raising property not found exception requires a property" +
                    " name and a type");
        }
        return new PropertyNotFoundException(result.getParams().get(0), result.getParams().get(1));
    }

    private static RuntimeException createPropertySet(WireResult result) {
        if(result.getParams().size() < 3) {
            return new FlashDriverInternalException("raising property set exception requires a property" +
                    ", value and a type");
        }
        List<String> params = result.getParams();
        return new PropertySetException(params.get(0), params.get(1), params.get(2), params.get(3));
    }

    private static RuntimeException createFunctionNotFound(WireResult result) {
        if(result.getParams().size() < 1) {
            return new FlashDriverInternalException("raising function not found exception requires an id");
        }
        return new FunctionNotFoundException(result.getParams().get(0));
    }

    private static RuntimeException createFunctionInvocation(WireResult result) {
        if(result.getParams().size() < 2) {
            return new FlashDriverInternalException("raising element not found exception requires " +
                    "an id and stack trace");
        }
        return new FlashDriverFunctionInvocationException(result.getParams().get(0), result.getParams().get(1));
    }

    private static RuntimeException createDisplayRootNotDefined(WireResult result) {
        return new DisplayRootNotDefinedException();
    }

    private static RuntimeException createInternal(WireResult result) {
        if(result.getParams().size() < 1) {
            return new FlashDriverInternalException("raising internal exception requires a stack trace or message");
        }
        return new FlashDriverInternalException(result.getParams().get(0));
    }

}


