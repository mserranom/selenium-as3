package flashdriver.processor.commands
{
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.getQualifiedClassName;

import flashdriver.messages.WireCommand;
import flashdriver.finder.ElementFinder;

public class Click
{

    public function process(command:WireCommand) : String
    {
        const element : * = new ElementFinder().find(command.selector);
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
