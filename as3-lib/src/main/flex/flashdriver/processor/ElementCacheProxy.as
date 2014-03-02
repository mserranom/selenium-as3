/**
 * Created by miguel on 26/02/2014.
 */
package flashdriver.processor
{
import flashdriver.messages.Selector;
import flashdriver.register.ElementCache;

public class ElementCacheProxy
{
    public function getElement(selector:Selector) : *
    {
        return ElementCache.getElement(selector);
    }
}
}
