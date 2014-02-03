package flashselenium.core;

public interface DisplayObjectDriver {

    DisplayObjectDriver findElement(By by);

    boolean exists();

    Object getValue(String propertyName);

    String getString(String propertyName);

    long getNumber(String propertyName);

    boolean getBoolean(String propertyName);

    void click();

}
