package flashdriver.finder
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.finder.display.DisplayListLocator;
import flashdriver.finder.display.StarlingLocator;
import flashdriver.messages.Selector;
import flashdriver.register.Register;

public class FindByLabel implements IFinder
{
    public function find(selector:Selector) : *
    {
        var result : *;
        if(Register.starlingRoot)
        {
            var locator : StarlingLocator = new StarlingLocator();
            result = locator.findLabel(selector.value1, Register.starlingRoot);
        }
        else if(Register.root)
        {
            var displayListLocator : DisplayListLocator = new DisplayListLocator();
            result = displayListLocator.findLabel(selector.value1, Register.root);
        }
        else
        {
            throw new FlashDriverError(ErrorCodes.DISPLAY_ROOT_NOT_DEFINED,[]);
        }
        if(!result)
        {
            throw new FlashDriverError(ErrorCodes.ELEMENT_NOT_FOUND,[selector.toString()]);
        }
    }

}
}
