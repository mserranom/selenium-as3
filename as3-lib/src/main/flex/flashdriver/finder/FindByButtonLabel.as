package flashdriver.finder
{
import flashdriver.error.ErrorCodes;
import flashdriver.error.FlashDriverError;
import flashdriver.messages.Selector;
import flashdriver.register.Register;
import flashdriver.finder.display.DisplayListLocator;
import flashdriver.finder.display.StarlingLocator;

public class FindByButtonLabel implements IFinder
{

    public function find(selector:Selector) : *
    {
        var result : *;
        if(flashdriver.register.Register.starlingRoot)
        {
            var locator : StarlingLocator = new StarlingLocator();
            result = locator.findButton(selector.value1, flashdriver.register.Register.starlingRoot);
        }
        else if(flashdriver.register.Register.root)
        {
            var displayListLocator : DisplayListLocator = new DisplayListLocator();
            result = displayListLocator.findButton(selector.value1, flashdriver.register.Register.root);
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
