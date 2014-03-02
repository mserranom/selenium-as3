package flashdriver.messages
{
import flashdriver.processor.*;

public class WireCommand
{
    public static const EXISTS : String = "exists";

    public static const CLICK : String = "click";

    public static const SET_PROPERTY : String = "setProperty";

    public static const GET_PROPERTY : String = "getProperty";

    private var _type : String;

    private var _selector : Selector;

    private var _params : Array;

    public function WireCommand(type : String, selector : Selector, params : Array)
    {
        _type = type;
        _selector = selector;
        _params = params;
    }

    public function get selector():Selector
    {
        return _selector;
    }

    public function get params():Array
    {
        return _params;
    }

    public function get type():String
    {
        return _type;
    }
}
}
