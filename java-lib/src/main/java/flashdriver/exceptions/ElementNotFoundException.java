package flashdriver.exceptions;


public class ElementNotFoundException  extends RuntimeException {

    private String elementId;

    public ElementNotFoundException(String id) {
        super("Unable to find element with id '" + id + "'");
        elementId = id;
    }

    public String getElementId() {
        return elementId;
    }

}
