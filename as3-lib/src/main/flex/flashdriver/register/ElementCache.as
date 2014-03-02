package flashdriver.register
{
import flash.utils.Dictionary;

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
            throw new Error("Unable to find element with id=" + id + " in the cache");
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
                throw new Error("Unable to find element with id=" + selector.value + " in the cache");
            }
            return result;
        }
        else
        {
            throw new Error("TODO");
        }

    }
}
}
