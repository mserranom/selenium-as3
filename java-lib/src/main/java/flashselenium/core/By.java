package flashselenium.core;

public class By {

    private String _query;

    private By(String query) {
        _query = query;
    }

    public String getQuery() {
        return _query;
    }

    public static By type(String typeName) {
        return new By("findByType('" + typeName + "')");
    }

    public static By propertyValue(String property, String value) {
        return new By("findByPropertyValue('" + property + "','" + value + "')");
    }

    public static By propertyValue(String property, double value) {
        return new By("findByPropertyValue('" + property + "'," + value + ")");
    }

    public static By propertyValue(String property, boolean value) {
        String boolValue = value ? "true" : "false";
        return new By("findByPropertyValue('" + property + "'," + boolValue + ")");
    }


}
