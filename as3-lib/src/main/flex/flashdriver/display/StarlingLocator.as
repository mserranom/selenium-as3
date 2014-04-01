package flashdriver.display
{
import flash.utils.getQualifiedClassName;

import starling.display.DisplayObject;

import starling.display.DisplayObjectContainer;

public class StarlingLocator
{
    public function findByName(name: String, root: DisplayObjectContainer) : DisplayObject
    {
        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root[i];
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
            var displayObject:DisplayObject = root[i];
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

    public function findButton(text: String, root: DisplayObjectContainer) : DisplayObject
    {
        var numChildren : int = root.numChildren;
        for (var i:int = 0; i < numChildren; i++)
        {
            var displayObject:DisplayObject = root[i];
            if(hasLabel(displayObject, text) && isButton(displayObject))
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
