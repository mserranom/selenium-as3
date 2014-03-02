package flashdriver.messages;

import org.json.simple.JSONObject;

public class Selector {


    private SelectorType type;

    private String value;

    public Selector(SelectorType type, String value) {
        this.type = type;
        this.value = value;
    }

    public SelectorType getType() {
        return type;
    }

    public String getValue() {
        return value;
    }

    public JSONObject toJson() {
        JSONObject result = new JSONObject();
        result.put(getType().getValue(), value);
        return result;
    }
}
