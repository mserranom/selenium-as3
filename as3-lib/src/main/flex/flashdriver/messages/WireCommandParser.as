package flashdriver.messages
{
import flashdriver.processor.*;

public class WireCommandParser
{

    private var _currentMsg : String;

    public function parse(jsonObject:String) : WireCommand
    {
        _currentMsg = jsonObject;

        try
        {
            const message : Array = JSON.parse(jsonObject) as Array;
        }
        catch (error:Error)
        {
            throw new Error("Unable to parse JSON message: " + jsonObject + "\n" + error.toString());
        }

        if(message == null)
        {
            throw new Error("Unable to deserialize message: " + _currentMsg);
        }

        if(message.length < 1)
        {
            throw new Error("Message not valid, expected 2 elements: " + _currentMsg);
        }

        const type : String = getType(message);
        const selector : Selector = getSelector(message);
        const params : Array = message.slice(2);

        const result : WireCommand = new WireCommand(type, selector, params);
        validateWireCommand(result);

        return result;
    }

    private function getType(message:Array) : String
    {
        switch ( message[0])
        {
            case WireCommand.CLICK:
            case WireCommand.EXISTS:
            case WireCommand.GET_PROPERTY:
            case WireCommand.SET_PROPERTY:
            case WireCommand.EXECUTE:
                return message[0];
            default:
                throw new Error("Unknown message type: " + message[0] + ". message=" + _currentMsg);
        }
    }

    private function getSelector(message:Array) : Selector
    {
        const selectorObject : Object = message[1];
        if(selectorObject[Selector.ID])
        {
            return new Selector(Selector.ID, selectorObject[Selector.ID])
        }
        else
        {
            throw new Error("Unable to resolve element selector:" + _currentMsg);
        }
    }

    private function validateWireCommand(command:WireCommand) : void
    {
        switch (command.type)
        {
            case WireCommand.CLICK:
            case WireCommand.EXISTS:
                return;
            case WireCommand.GET_PROPERTY:
                if(command.params.length < 1)
                {
                    throw new Error(WireCommand.GET_PROPERTY + " command requires one parameter: " + _currentMsg)
                }
                return;
            case WireCommand.SET_PROPERTY:
                if(command.params.length < 2)
                {
                    throw new Error(WireCommand.SET_PROPERTY + " command requires two parameter: " + _currentMsg)
                }
                return;
            case WireCommand.EXECUTE:
                if(command.selector.type != Selector.ID)
                {
                    throw new Error(WireCommand.EXECUTE + " command requires selection by id: " + _currentMsg)
                }
                return;
            default:
                throw new Error("Unknown command type: " + command.type)
        }
    }
}
}
