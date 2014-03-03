package flashdriver.exceptions;

public class PropertyNotFoundException extends RuntimeException{

    private String elementId;

    private String clazz;

    public PropertyNotFoundException(String id, String clazz) {
        super("Unable to find property '" + id + "' in element of type " + clazz);
        elementId = id;
        this.clazz = clazz;
    }

    public String getElementId() {
        return elementId;
    }

    public String getClazz() {
        return clazz;
    }

}
