package flashdriver.core;

import flashdriver.messages.Selector;
import flashdriver.messages.SelectorType;

public class By {

    private Selector selector;

    private By(SelectorType selectorType, String query) {
        this.selector = new Selector(selectorType, query);
    }

    private By(SelectorType selectorType, String query1, String query2) {
        this.selector = new Selector(selectorType, query1, query2);
    }

    public Selector getSelector() {
        return selector;
    }

    public static By id(String query) {
        return new By(SelectorType.ID, query);
    }

    public static By label(String query) {
        return new By(SelectorType.LABEL, query);
    }

    public static By type(String query) {
        return new By(SelectorType.TYPE, query);
    }

    public static By typeAndLabel(String type, String label) {
        return new By(SelectorType.TYPE_AND_LABEL, type, label);
    }

    public static By buttonLabel(String query) {
        return new By(SelectorType.BUTTON_LABEL, query);
    }

    @Override
    public String toString() {
        return "by " + selector.getType().getValue() + " = " + selector.valuesString();
    }

}
