package flashdriver.messages;

public enum WireCommandType {

    EXISTS("exists"),
    CLICK("click"),
    GET_PROPERTY("getProperty"),
    SET_PROPERTY("setProperty"),
    EXECUTE("execute");

    private String value;

    WireCommandType(String type) {
        value = type;
    }

    public String getValue() {
        return value;
    }
}
