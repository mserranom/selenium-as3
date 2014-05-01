package flashdriver.v2;


public interface ExpectedConditions {

    ExpectedConditions not();

    void hasPropertyValue(String property, String value);

}
