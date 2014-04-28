package flashdriver.finder.display
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

public class DisplayListLocator
{
    public function findByName(name: String, root: DisplayObjectContainer) : DisplayObject
    {
        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root.getChildAt(i);
            if(displayObject.name == name)
            {
                return displayObject;
            }
            else if(displayObject is DisplayObjectContainer)
            {
                return findByName(name, displayObject as DisplayObjectContainer);
            }
        }
        return null;
    }

    public function findLabel(text: String, root: DisplayObjectContainer) : DisplayObject
    {
        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root.getChildAt(i);
            if(hasLabel(displayObject, text))
            {
                return displayObject;
            }
            else if(displayObject is DisplayObjectContainer)
            {
                return findLabel(text, displayObject as DisplayObjectContainer);
            }
        }
        return null;
    }


    public var msg : String = "";


    public function findType(type: String, root: DisplayObjectContainer) : DisplayObject
    {
        try
        {
            var clazz : Class = getDefinitionByName(type) as Class;
        }
        catch(error:Error)
        {
            return null;
        }

        var result : DisplayObject;

        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {

            var displayObject:DisplayObject = root.getChildAt(i);
            msg += getQualifiedClassName(displayObject) + "__"
            if(displayObject is clazz)
            {
                result = displayObject;
            }
            else if(displayObject is DisplayObjectContainer)
            {
                result = findType(type, displayObject as DisplayObjectContainer);
            }

            if(result)
            {
                return result;
            }
        }
        return null;
    }

    public function findTypeAndLabel(type: String, text:String, root: DisplayObjectContainer) : DisplayObject
    {
        try
        {
            var clazz : Class = getDefinitionByName(type) as Class;
        }
        catch(error:Error)
        {
            return null;
        }

        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root.getChildAt(i);
            if(displayObject is clazz && hasLabel(displayObject, text))
            {
                return displayObject;
            }
            else if(displayObject is DisplayObjectContainer)
            {
                return findTypeAndLabel(type, text, displayObject as DisplayObjectContainer);
            }
        }
        return null;
    }

    public function findButton(text: String, root: DisplayObjectContainer) : DisplayObject
    {
        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root.getChildAt(i);
            if(hasLabel(displayObject, text) && isButton(displayObject))
            {
                return displayObject;
            }
            else if(displayObject is DisplayObjectContainer)
            {
                return findButton(text, displayObject as DisplayObjectContainer);
            }
        }
        return null;
    }

    private function hasLabel(label:DisplayObject, text:String):Boolean
    {
        var properties : Array = ["text", "label", "htmlText"];
        for each (var textProperty:String in properties)
        {
            if(label[textProperty] && label[textProperty == text])
            {
                return true;
            }
        }
        return false;
    }

    private function isButton(displayObject:DisplayObject):Boolean
    {
        var typeName : String = getQualifiedClassName(displayObject).split(["::"])[0];
        return typeName.toLowerCase().indexOf("button") != -1;
    }
}
}
