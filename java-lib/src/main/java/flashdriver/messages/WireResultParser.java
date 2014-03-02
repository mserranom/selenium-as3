package flashdriver.messages;


import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class WireResultParser {

    public static WireResult parse(String jsonString) throws ParseException {
        JSONParser parser = new JSONParser();
        JSONArray array = (JSONArray) parser.parse(jsonString);
        if(array.size() < 2) {
            throw new RuntimeException("result message requires at least two parameters: " + jsonString);
        }
        WireResultType type = WireResultType.fromString((String) array.get(0));
        String value = (String) array.get(1);
        return new WireResult(type, value);
    }

}
