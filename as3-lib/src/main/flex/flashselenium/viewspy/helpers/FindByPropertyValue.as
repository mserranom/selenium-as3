package flashselenium.viewspy.helpers
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.getQualifiedClassName;

import flashselenium.errors.ErrorsEnum;
import flashselenium.viewspy.ViewSpy;

public class FindByPropertyValue
{
    public static function find(root:DisplayObject, prop:String, value:*) : ViewSpy
    {



        const container : DisplayObjectContainer = root as DisplayObjectContainer;

        if(!container)
        {
            throw new Error(ErrorsEnum.createMessage(ErrorsEnum.ELEMENT_NOT_FOUND,
                    [prop, value, getQualifiedClassName(root)]));
        }

        var result : ViewSpy = findRecursively(container, prop, value);

        if(!result)
        {
            throw new Error(ErrorsEnum.createMessage(ErrorsEnum.ELEMENT_NOT_FOUND,
                    [prop, value, getQualifiedClassName(root)]));
        }

        return result;
    }

    private static function findRecursively(container:DisplayObjectContainer, prop:String, value:*) : ViewSpy
    {

        const numChildren : int = container.numChildren;

        // check 1st if children are of given type
        for(var i : uint = 0; i < numChildren; i++)
        {
            var child : DisplayObject = container.getChildAt(i);

            if(child.hasOwnProperty(prop) && child[prop] == value)
            {
                return new ViewSpy(child);
            }
        }

        //otherwise, check recursively children
        for(i = 0; i < numChildren; i++)
        {
            child = container.getChildAt(i);
            if(child is DisplayObjectContainer)
            {
                return findRecursively(child as DisplayObjectContainer, prop, value)
            }
        }

        return null;
    }

}
}
