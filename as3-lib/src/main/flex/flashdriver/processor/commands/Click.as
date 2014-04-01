package flashdriver.processor.commands
{
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.getQualifiedClassName;

import flashdriver.messages.WireCommand;
import flashdriver.processor.ElementCacheProxy;

public class Click
{
    private var _cache : ElementCacheProxy;

    public function Click(cache:ElementCacheProxy)
    {
        _cache = cache;
    }

    public function process(command:WireCommand) : String
    {
        const element : * = _cache.getElement(command.selector);
        if(!(element is DisplayObject))
        {
            throw new Error("couldn't perform click, object of type"
                    + getQualifiedClassName(element) + " is not a DisplayObject")
        }

        const displayObject : DisplayObject = element as DisplayObject;
        displayObject.dispatchEvent(new MouseEvent(MouseEvent.CLICK));

        return "";
    }
}
}
