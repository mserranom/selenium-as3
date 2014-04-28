package flashdriver.register
{
import flash.display.DisplayObjectContainer;
import flash.utils.Dictionary;

import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;

import starling.display.DisplayObjectContainer;

public class Register
{
    private static var _cacheId : Dictionary = new Dictionary(true);

    private static var _functionsCache : Dictionary = new Dictionary(true);

    private static var _root : flash.display.DisplayObjectContainer;

    private static var _starlingRoot : starling.display.DisplayObjectContainer;

    public static function registerElementById(id:String, element:*) : void
    {
        if(_cacheId[id])
        {
            throw new Error("Element with id=" + id + " has already been registered");
        }
        _cacheId[id] = element;
    }

    public static function removeElementById(id:String, element:*) : void
    {
        if(!_cacheId[id])
        {
            throw new FlashDriverError(ErrorCodes.ELEMENT_NOT_FOUND,[id]);
        }
        delete _cacheId[id];
    }

    public static function registerFunction(id:String, func:Function) : void
    {
        if(_functionsCache[id])
        {
            throw new Error("function with id=" + id + " has already been registered");
        }
        _functionsCache[id] = func;
    }

    public static function removeFunction(id:String, func:Function) : void
    {
        if(!_functionsCache[id])
        {
            throw new FlashDriverError(ErrorCodes.FUNCTION_NOT_FOUND,[id]);
        }
        delete _functionsCache[id];
    }

    public static function clearCache() : void
    {
        _cacheId = new Dictionary(true);
        _functionsCache = new Dictionary(true);
    }

    public static function getElement(id:String) : *
    {
        return _cacheId[id];
    }

    public static function getFunction(id:String) : Function
    {
        return _functionsCache[id];
    }

    public static function registerRoot(root:flash.display.DisplayObjectContainer) : void
    {
        _root = root;
    }

    public static function registerStarlingRoot(root:starling.display.DisplayObjectContainer) : void
    {
        _starlingRoot = root;
    }

    public static function get root() : flash.display.DisplayObjectContainer
    {
        return _root;
    }

    public static function get starlingRoot() : starling.display.DisplayObjectContainer
    {
        return _starlingRoot;
    }
}
}
