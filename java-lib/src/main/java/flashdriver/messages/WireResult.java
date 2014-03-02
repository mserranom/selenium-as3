package flashdriver.messages;

public class WireResult {

    private WireResultType type;

    private String result;

    public WireResult(WireResultType type, String result) {
        this.type = type;
        this.result = result;
    }

    public WireResultType getType() {
        return type;
    }

    public String getResult() {
        return result;
    }
}
