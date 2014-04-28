package flashdriver.finder
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.messages.Selector;
import flashdriver.register.Register;

public class ElementFinder
{
    public function find(selector:Selector) : *
    {
        switch(selector.type)
        {
            case Selector.ID:
                return new FindById().find(selector);
            case Selector.LABEL:
                return new FindByLabel().find(selector);
            case Selector.BUTTON_LABEL:
                return new FindByButtonLabel().find(selector);
            case Selector.TYPE:
                return new FindByType().find(selector);
            case Selector.TYPE_AND_LABEL:
                return new FindByTypeAndLabel().find(selector);
            default:
                throw new Error("Unable to process selector: " + selector.toString());
        }
    }

    public function getFunction(id:String) : Function
    {
        const result : * = flashdriver.register.Register.getFunction(id);
        if(!result)
        {
            throw new FlashDriverError(ErrorCodes.FUNCTION_NOT_FOUND,[id]);
        }
        return result;
    }
}
}
