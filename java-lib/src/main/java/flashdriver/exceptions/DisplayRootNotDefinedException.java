package flashdriver.exceptions;

public class DisplayRootNotDefinedException  extends RuntimeException {

    public DisplayRootNotDefinedException() {
        super("display list or starling root has to be provided to lookup for display elements");
    }
}