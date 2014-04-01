package flashdriver.messages;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Selector {


    private SelectorType type;

    private String value1;

    private String value2;

    public Selector(SelectorType type, String value) {
        this.type = type;
        this.value1 = value;
    }

    public Selector(SelectorType type, String value1, String value2) {
        this.type = type;
        this.value1 = value1;
        this.value2 = value2;
    }

    public SelectorType getType() {
        return type;
    }

    public JSONObject toJson() {
        JSONObject result = new JSONObject();
        if(value2 == null) {
            result.put(getType().getValue(), value1);
        } else {
            JSONArray values = new JSONArray();
            values.add(value1);
            values.add(value2);
            result.put(getType().getValue(), values);
        }

        return result;
    }

    public String valuesString() {
        if(value2 == null) {
            return value1;
        } else {
            return value1 + "," + value2;
        }
    }
}
