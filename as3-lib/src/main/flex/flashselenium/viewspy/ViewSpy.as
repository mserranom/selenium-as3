/**
 * Created by miguel on 25/11/2013.
 */
package flashselenium.viewspy
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.MouseEvent;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

import flashselenium.errors.ErrorsEnum;
import flashselenium.viewspy.helpers.FindByPropertyValue;
import flashselenium.viewspy.helpers.FindByTypeName;

public class ViewSpy
{
    private var _view : DisplayObject;

    public function ViewSpy(root:DisplayObject)
    {
        _view = root
    }

    public function findByType(type:String) : ViewSpy
    {
        return FindByTypeName.find(_view, type);
    }

    public function findByPropertyValue(prop:String, value:*) : ViewSpy
    {
        return FindByPropertyValue.find(_view, prop, value);
    }

    public function getValue(propName:String) : Object
    {
        if(!_view.hasOwnProperty(propName))
        {
            throw new Error("Object " + _view + " doesn't have property " + propName);
        }
        return _view[propName];
    }

    public function click() : void
    {
        _view.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }
}
}
