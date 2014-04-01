package flashdriver.messages;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

public class WireCommand {

    private WireCommandType type;
    private Selector selector;
    private List<String> params;

    public WireCommand(WireCommandType type, Selector selector) {
        this(type, selector, new ArrayList<String>());
    }

    public WireCommand(WireCommandType type, Selector selector, List<String> params) {
        this.type = type;
        this.selector = selector;
        this.params = params;
    }

    public String toJsonString() {
        JSONArray list = new JSONArray();
        list.put(type.getValue());

        list.put(selector.toJson());

        for(String param : params) {
            list.put(param);
        }

        return list.toString();
    }
}
