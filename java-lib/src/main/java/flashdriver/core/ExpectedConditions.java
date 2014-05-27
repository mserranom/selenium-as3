package flashdriver.core;


public interface ExpectedConditions {

    ExpectedConditions not();

    void hasPropertyValue(String property, String value);

}
