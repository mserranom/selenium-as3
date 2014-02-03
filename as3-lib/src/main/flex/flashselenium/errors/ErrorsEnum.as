/**
 * Created by miguel on 26/11/2013.
 */
package flashselenium.errors
{
public class ErrorsEnum
{
    public static const ELEMENT_NOT_FOUND : String = "FL_ERR_#001";

    public static const TYPE_NOT_FOUND : String = "FL_ERR_#002";

    public static function createMessage(errorType:String, params:Array) : String
    {
        const SEPARATOR : String = "%%%";
        var result : String = errorType;
        for each(var param : String in params)
        {
            result += SEPARATOR + param;
        }
        return result;
    }
}
}
