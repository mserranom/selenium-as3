package flashselenium.core;

public class ExpectedConditions {

    private By _by;

    public ExpectedConditions(By locator) {
        _by = locator;
    }

    public String getQuery() {
        return _by.getQuery();
    }

    public static ExpectedConditions elementIsPresent(By locator) {
        return new ExpectedConditions(locator);
    }

}
