package flashselenium.viewspy.helpers
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import flashselenium.errors.ErrorsEnum;
import flashselenium.viewspy.ViewSpy;

public class FindByTypeName
{
    public static function find(root:DisplayObject, typeName:String) : ViewSpy
    {
        try
        {
            const typeClass : Class = getDefinitionByName(typeName) as Class;
        }
        catch(error:Error)
        {
            throw new Error(ErrorsEnum.createMessage(ErrorsEnum.TYPE_NOT_FOUND, [typeName]));
        }

        return findAny(root, typeClass);
    }

    private static function findAny(root:DisplayObject, type:Class) : ViewSpy
    {
        const container : DisplayObjectContainer = root as DisplayObjectContainer;

        if(!container)
        {
            throw new Error(ErrorsEnum.createMessage(ErrorsEnum.ELEMENT_NOT_FOUND,
                    [getQualifiedClassName(type), getQualifiedClassName(root)]));
        }

        var result : ViewSpy = findRecursively(container, type);

        if(!result)
        {
            throw new Error(ErrorsEnum.createMessage(ErrorsEnum.ELEMENT_NOT_FOUND,
                    [getQualifiedClassName(type), getQualifiedClassName(root)]));
        }

        return result;
    }

    private static function findRecursively(container:DisplayObjectContainer, type:Class) : ViewSpy
    {
        const numChildren : int = container.numChildren;

        // check 1st if children are of given type
        for(var i : uint = 0; i < numChildren; i++)
        {
            var child : DisplayObject = container.getChildAt(i);
            if(child is type)
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
                return findRecursively(child as DisplayObjectContainer, type)
            }
        }

        return null;
    }

}
}
