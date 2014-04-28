package flashdriver.processor.commands
{
import flash.utils.getQualifiedClassName;

import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;

import flashdriver.messages.WireCommand;
import flashdriver.finder.ElementFinder;

public class SetProperty
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

        const value : String = command.params[1];
        var valueToSet : * = value;

        if(value == "true" || value == "false")
        {
            valueToSet = (value == "true") ? true : false;
        }

        try
        {
            element[prop] = valueToSet;
            return "";
        }
        catch (error:Error)
        {
            throw new FlashDriverError(ErrorCodes.UNABLE_TO_SET_PROPERTY,
                    [prop, value, getQualifiedClassName(element), error.message]);
        }

        return "";
    }
}
}
