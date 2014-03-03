package flashdriver.exceptions;

import flashdriver.messages.WireResult;

public class ExceptionFactory {

    private static String ELEMENT_NOT_FOUND = "#10";

    private static String PROPERTY_NOT_FOUND = "#11";

    private static String INTERNAL = "#99";

    public static RuntimeException fromError(WireResult result) {
        if(result.getResult().equals(ELEMENT_NOT_FOUND)) {
            return createElementNotFound(result);
        } else if(result.getResult().equals(PROPERTY_NOT_FOUND)) {
            return createPropertyNotFound(result);
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

    private static RuntimeException createInternal(WireResult result) {
        return null;
    }

}


