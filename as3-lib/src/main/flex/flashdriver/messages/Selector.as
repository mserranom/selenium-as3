package flashdriver.messages
{
public class Selector
{
    public static const ID : String = "id";

    private var _type : String;

    private var _value : String;

    public function Selector(type:String, value:String)
    {
        _type = type;
        _value = value;
    }

    public function get type():String
    {
        return _type;
    }

    public function get value():String
    {
        return _value;
    }


}
}
