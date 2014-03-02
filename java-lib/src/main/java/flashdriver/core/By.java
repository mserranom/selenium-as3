package flashdriver.core;

import flashdriver.messages.Selector;
import flashdriver.messages.SelectorType;

public class By {

    private Selector selector;

    private By(SelectorType selectorType, String query) {
        this.selector = new Selector(selectorType, query);
    }

    public Selector getSelector() {
        return selector;
    }

    public static By ID(String query) {
        return new By(SelectorType.ID, query);
    }

    @Override
    public String toString() {
        return "by " + selector.getType().getValue() + " = " + selector.getValue();
    }
}
