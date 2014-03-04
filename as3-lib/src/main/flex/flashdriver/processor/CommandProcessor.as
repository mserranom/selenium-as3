package flashdriver.processor
{
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.getQualifiedClassName;

import flashdriver.error.ErrorCodes;

import flashdriver.error.FlashDriverError;
import flashdriver.log.Logger;

import flashdriver.messages.WireCommand;

import mx.logging.ILogger;

public class CommandProcessor implements ICommandProcessor
{
    private static const LOG : ILogger = Logger.getLogger(CommandProcessor);

    private var _cache : ElementCacheProxy;

    public function CommandProcessor(cache:ElementCacheProxy)
    {
        _cache = cache;
    }

    public function process(command:WireCommand) : String
    {
        switch(command.type)
        {
            case WireCommand.CLICK:
                return processClick(command);
            case WireCommand.EXISTS:
                return processExists(command);
            case WireCommand.GET_PROPERTY:
                return processGetProperty(command);
            case WireCommand.SET_PROPERTY:
                return processSetProperty(command);
            case WireCommand.EXECUTE:
                return processExecute(command);
            default:
                throw new Error("Unknown command type: " + command.type)
        }
    }

    private function processClick(command:WireCommand) : String
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

    private function processExists(command:WireCommand) : String
    {
        const element : * = _cache.getElement(command.selector);
        return "";
    }

    private function processGetProperty(command:WireCommand) : String
    {
        const element : * = _cache.getElement(command.selector);
        const prop : String = command.params[0];
        if(!element.hasOwnProperty(prop))
        {
            throw new FlashDriverError(ErrorCodes.PROPERTY_NOT_FOUND,
                    [prop, getQualifiedClassName(element)]);
        }
        return String(element[prop]);
    }

    private function processSetProperty(command:WireCommand) : String
    {
        const element : * = _cache.getElement(command.selector);
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
            throw new Error("Unable to set value " + value + " to property " + prop
                    + " in object of type " + getQualifiedClassName(element))
        }

        return "";
    }

    private function processExecute(command:WireCommand) : String
    {
        const func : Function = _cache.getFunction(command.selector.value);
        LOG.info("executing function with id='" + command.selector.value + "' with params="
                + JSON.stringify(command.params));
        try
        {
            return func.apply(null, command.params);
        }
        catch (error:Error)
        {
            var msg : String = error.getStackTrace() ? error.getStackTrace() : error.message;
            throw new FlashDriverError(ErrorCodes.FUNCTION_INVOCATION_ERROR,
                    [command.selector.value, msg]);
        }
        return "";
    }
}
}
