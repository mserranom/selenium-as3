package flashdriver.exceptions;

public class PropertySetException extends RuntimeException{

    private String property;

    private String clazz;

    private String value;

    private String flashErrorMessage;

    public PropertySetException(String prop, String value, String clazz, String flashErrorMsg) {
        super("Unable to set value '" + value + "' in property '" + prop + "' in object of type "
                + clazz + ": " + flashErrorMsg);
        this.property = prop;
        this.value = value;
        this.clazz = clazz;
        this.flashErrorMessage = flashErrorMsg;
    }

    public String getProperty() {
        return property;
    }

    public String getClazz() {
        return clazz;
    }

    public String getValue() {
        return value;
    }

    public String getFlashErrorMessage() {
        return flashErrorMessage;
    }

}
