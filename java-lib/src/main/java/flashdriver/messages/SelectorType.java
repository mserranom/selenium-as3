package flashdriver.messages;


public enum SelectorType {

    ID("id");

    private String value;

    SelectorType(String type) {
        value = type;
    }

    public String getValue() {
        return value;
    }

    public static SelectorType fromString(String type) {
        for (SelectorType selectorType : SelectorType.values()) {
            if(type.equals(selectorType.getValue())) {
                return selectorType;
            }
        }
        throw new RuntimeException(type  + " is not a valid selector type");
    }
}
