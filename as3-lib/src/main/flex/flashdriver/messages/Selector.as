package flashdriver.messages
{
import mx.utils.ObjectUtil;

import org.hamcrest.text.re;

public class Selector
{
    public static const ID : String = "id";

    public static const LABEL : String = "label";

    public static const TYPE : String = "type";

    public static const TYPE_AND_LABEL : String = "typeAndLabel";

    public static const BUTTON_LABEL : String = "buttonLabel";

    private var _type : String;

    private var _value1 : String;

    private var _value2 : String;

    public function Selector(type:String, value1:String, value2 : String = null)
    {
        _type = type;
        _value1 = value1;
        _value2 = value2;
    }

    public function get type():String
    {
        return _type;
    }

    public function get value1():String
    {
        return _value1;
    }

    public function get value2():String
    {
        return _value1;
    }

    public static function fromData(data:Object) : Selector
    {
        if(data[Selector.ID])
        {
            return new Selector(Selector.ID, data[Selector.ID])
        }
        else if(data[Selector.TYPE])
        {
            return new Selector(Selector.TYPE, data[Selector.TYPE])
        }
        else if(data[Selector.BUTTON_LABEL])
        {
            return new Selector(Selector.BUTTON_LABEL, data[Selector.BUTTON_LABEL])
        }
        else if(data[Selector.LABEL])
        {
            return new Selector(Selector.LABEL, data[Selector.BUTTON_LABEL])
        }
        else if(data[Selector.TYPE_AND_LABEL])
        {
            var selectorValue : Array = data[Selector.TYPE_AND_LABEL] as Array;
            if(selectorValue && selectorValue.length >= 2)
            {
                return new Selector(Selector.TYPE_AND_LABEL, selectorValue[0], selectorValue[1]);
            }

        }
        throw new Error("unable to create selector from selector data: " + ObjectUtil.toString(data));
    }

    public function toString() : String
    {
        var result : String = "Selector.by(" + type + ") [" + value1;
        if(value2 != null)
        {
            result += "," + value2;
        }
        result += "]";
        return result;
    }

}
}
