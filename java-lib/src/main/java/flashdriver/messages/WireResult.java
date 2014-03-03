package flashdriver.messages;

import java.util.List;

public class WireResult {

    private WireResultType type;

    private String result;

    private List<String> params;

    public WireResult(WireResultType type, String result, List<String> params) {
        this.type = type;
        this.result = result;
        this.params = params;
    }

    public WireResultType getType() {
        return type;
    }

    public String getResult() {
        return result;
    }

    public List<String> getParams() {
        return params;
    }
}
