package flashdriver.exceptions;


public class ElementNotFoundException  extends RuntimeException {

    public ElementNotFoundException(String selector) {
        super("Unable to find element with selector '" + selector + "'");
    }


}
