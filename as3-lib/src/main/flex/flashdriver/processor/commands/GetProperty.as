package flashdriver.processor.commands
{
import flash.utils.getQualifiedClassName;

import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;

import flashdriver.messages.WireCommand;
import flashdriver.finder.ElementFinder;

public class GetProperty
{

    public function process(command:WireCommand) : String
    {
        const element : * = new ElementFinder().find(command.selector);
        const prop : String = command.params[0];
        if(!element.hasOwnProperty(prop))
        {
            throw new FlashDriverError(ErrorCodes.PROPERTY_NOT_FOUND,
                    [prop, getQualifiedClassName(element)]);
        }
        return String(element[prop]);
    }
}
}
