package flashdriver.processor.commands
{
import flashdriver.messages.WireCommand;
import flashdriver.processor.ElementCacheProxy;

public class Exists
{
    private var _cache : ElementCacheProxy;

    public function Exists(cache:ElementCacheProxy)
    {
        _cache = cache;
    }

    public function process(command:WireCommand) : String
    {
        const element : * = _cache.getElement(command.selector);
        return "";
    }
}
}
