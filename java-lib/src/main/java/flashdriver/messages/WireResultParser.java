package flashdriver.messages;


import flashdriver.exceptions.FlashDriverInternalException;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class WireResultParser {

    public static WireResult parse(String jsonString) {
        JSONParser parser = new JSONParser();
        JSONArray array = null;
        try {
            array = (JSONArray) parser.parse(jsonString);
        } catch (ParseException e) {
            throw new FlashDriverInternalException("unable to parse WireResult, " + e.getMessage() + ": " + jsonString);
        }
        if(array.size() < 2) {
            throw new FlashDriverInternalException("result message requires at least two parameters: " + jsonString);
        }

        WireResultType type = WireResultType.fromString((String) array.get(0));
        String value = (String) array.get(1);
        List<String> resultParams = new ArrayList<String>();

        if(type == WireResultType.ERROR && array.size() > 2) {
            try {
                JSONArray errorParams = (JSONArray) array.get(2);
                Iterator i = errorParams.iterator();
                while(i.hasNext()) {
                    resultParams.add((String) i.next());
                }
            } catch(RuntimeException e) {
                throw new FlashDriverInternalException("unable to parse error parameters, "
                        + e.getMessage() + ":, " + jsonString);
            }
        }
        return new WireResult(type, value, resultParams);
    }

}
