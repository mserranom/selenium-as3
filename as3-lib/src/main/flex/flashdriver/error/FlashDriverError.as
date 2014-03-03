package flashdriver.error
{
public class FlashDriverError
{
    private var _type : String;

    private var _params : Array;

    public function FlashDriverError(type:String, params:Array)
    {
        _type = type;
        _params = params;
    }

    public function get type():String
    {
        return _type;
    }

    public function get params():Array
    {
        return _params;
    }

    public function toString() : String
    {
        return "FlashDriverError " + _type + ": "  + JSON.stringify(_params);
    }
}
}
