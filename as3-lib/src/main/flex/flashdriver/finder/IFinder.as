package flashdriver.finder
{
import flashdriver.messages.Selector;

public interface IFinder
{
    function find(selector:Selector) : *;
}
}
