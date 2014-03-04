package flashdriver.error
{
public class FlashDriverError
{
    private var _code : String;

    private var _params : Array;

    public function FlashDriverError(code:String, params:Array)
    {
        _code = code;
        _params = params;
    }

    public function get code():String
    {
        return _code;
    }

    public function get params():Array
    {
        return _params;
    }

    public function toString() : String
    {
        return "FlashDriverError " + _code + ": "  + JSON.stringify(_params);
    }
}
}
