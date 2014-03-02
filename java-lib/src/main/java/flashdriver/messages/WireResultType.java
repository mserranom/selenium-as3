package flashdriver.messages;

public enum WireResultType {

    SUCCESS("success"),
    ERROR("error");

    private String value;

    WireResultType(String type) {
        value = type;
    }

    public String getValue() {
        return value;
    }

    public static WireResultType fromString(String type) {
        for (WireResultType wireResultType : WireResultType.values()) {
            if(type.equals(wireResultType.getValue())) {
                return wireResultType;
            }
        }
        throw new RuntimeException(type  + " is not a valid result type");
    }
}
