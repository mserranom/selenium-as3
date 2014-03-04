package flashdriver.exceptions;


public class FunctionNotFoundException  extends RuntimeException {

    private String elementId;

    public FunctionNotFoundException(String id) {
        super("unable to find function with id '" + id + "'");
        elementId = id;
    }

    public String getElementId() {
        return elementId;
    }

}

