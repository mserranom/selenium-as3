package flashdriver.exceptions;

public class FlashDriverFunctionInvocationException extends RuntimeException {

    private String id;

    public FlashDriverFunctionInvocationException(String id, String message) {
        super("error invoking function with id='" + id + "'\n" + message);
    }

    public String getId() {
        return id;
    }
}


