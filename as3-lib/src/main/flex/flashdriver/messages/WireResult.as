package flashdriver.messages
{
public class WireResult
{

    public static const ERROR : String = "error";

    public static const SUCCESS : String = "success";

    private var _type : String;

    private var _result : String;

    private var _params : Array;

    public function WireResult(type : String, result : String, params : Array)
    {
        _type = type;
        _result = result;
        _params = params;
    }

    public function get result():String
    {
        return _result;
    }

    public function get params():Array
    {
        return _params;
    }

    public function get type():String
    {
        return _type;
    }

    public function toJsonString():String
    {
        return JSON.stringify([type, result, params]);
    }
}
}
