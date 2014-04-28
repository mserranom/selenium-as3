package flashdriver.finder
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.messages.Selector;
import flashdriver.register.Register;

public class FindById implements IFinder
{
    public function find(selector:Selector):*
    {
        var result : * = flashdriver.register.Register.getElement(selector.value1);

        if(!result)
        {
            throw new FlashDriverError(ErrorCodes.ELEMENT_NOT_FOUND,[selector.toString()]);
        }

        return result;

    }
}
}
