package flashselenium.exceptions;

import org.openqa.selenium.NoSuchElementException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ExceptionProcessor {

    private static final String SEPARATOR = "%%%";


    public void throwErrorFromMessage(String message) {
        List<String> split = new ArrayList<String>(Arrays.asList(message.split(SEPARATOR)));
        split.set(0, split.get(0).substring(8));
        FlashErrors error = FlashErrors.fromCode(split.get(0));
        switch (error) {
            case ELEMENT_NOT_FOUND:
                throw new NoSuchElementException(createNoSuchElementExceptionMessage(split));
            case TYPE_NOT_FOUND:
                throw new FlashTypeNotFoundException("Unable to resolve type " + split.get(1));
            default:
                throw new FlashDriverException(split.get(0));
        }
    }

    private String createNoSuchElementExceptionMessage(List<String> args) {
        String result = "Couldn't find element";
        if(args.size() == 2) {
            result += " of type " + args.get(1) + " in " + args.get(2);
        } else if(args.size() == 2) {
            result += " with property " + args.get(1) + "=" + args.get(2);
        }
        return result;
    }

}
