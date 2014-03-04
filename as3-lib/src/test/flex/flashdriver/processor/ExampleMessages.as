/**
 * Created by miguel on 26/02/2014.
 */
package flashdriver.processor
{
public class ExampleMessages
{
    public static const EXISTS_BY_ID : String = "[\"exists\",{\"id\":\"myId\"}]";

    public static const CLICK_BY_ID : String = "[\"click\",{\"id\":\"myId\"}]";

    public static const GET_PROPERTY_BY_ID : String = "[\"getProperty\",{\"id\":\"myId\"},\"myProp\",\"notRequiredArgument\"]";

    public static const SET_PROPERTY_BY_ID : String = "[\"setProperty\",{\"id\":\"myId\"},\"myProp\",\"myValue\"]";

    public static const EXECUTE : String = "[\"execute\",{\"id\":\"myId\"},\"param\"]";

    public static const WRONG_COMMAND : String = "[\"xsts\",{\"id\":\"myId\"}]";


    public static const NO_SELECTOR : String = "[\"exists\",{\"nothing\":\"myId\"}]";

    public static const MISSING_SET_PROP_PARAMS : String = "[\"setProperty\",{\"id\":\"myId\"},\"myProp\"]";

    public static const MISSING_GET_PROP_PARAMS : String = "[\"getProperty\",{\"id\":\"myId\"}]";

}
}
