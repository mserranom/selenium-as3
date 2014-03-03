package flashdriver.register
{
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;

import flashdriver.messages.Selector;

public class ElementCache
{
    private static var _cacheId : Dictionary = new Dictionary(true);

    public static function registerElementById(id:String, element:*)
    {
        if(_cacheId[id])
        {
            throw new Error("Element with id=" + id + " has already been registered");
        }
        _cacheId[id] = element;
    }

    public static function removeElementById(id:String, element:*)
    {
        if(!_cacheId[id])
        {
            throw new FlashDriverError(ErrorCodes.ELEMENT_NOT_FOUND,[id]);
        }
        delete _cacheId[id];
    }

    public static function clearCache() : void
    {
        _cacheId = new Dictionary(true);
    }

    public static function getElement(selector:Selector) : *
    {
        if(selector.type == Selector.ID)
        {
            const result : * = _cacheId[selector.value];
            if(!result)
            {
                throw new FlashDriverError(ErrorCodes.ELEMENT_NOT_FOUND,[selector.value]);
            }
            return result;
        }
        else
        {
            throw new Error("Unknown selector type: " + selector.type);
        }

    }
}
}
