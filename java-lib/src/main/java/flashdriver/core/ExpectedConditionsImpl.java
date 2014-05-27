package flashdriver.core;

import flashdriver.exceptions.ExpectationException;
import flashdriver.processor.Processor;
import flashdriver.processor.Poller;

public class ExpectedConditionsImpl implements ExpectedConditions {

    private By by;
    private Processor processor;
    private long timeout = 0;
    private long pollInterval = 0;

    private boolean shouldComply = true;

    public ExpectedConditionsImpl(By by, Processor processor, long timeout, long pollInterval) {
        this.by = by;
        this.processor = processor;
        this.timeout = timeout;
        this.pollInterval = pollInterval;
    }

    @Override
    public ExpectedConditions not() {
        shouldComply = !shouldComply;
        return this;
    }

    @Override
    public void hasPropertyValue(final String property, final String value) {
        Poller<FlashElement> poller = new Poller<FlashElement>(timeout, pollInterval) {
            @Override
            protected FlashElement execute(boolean isLastPoll) {

                FlashElement element = new FlashElement(by.getSelector(), processor);
                String valueFound = element.getString(property);

                boolean valueIsEqual = valueFound.equals(value);

                if(isLastPoll && (valueIsEqual != shouldComply)) {
                    throw new ExpectationException("Expected property '" + value
                            + "', but '" + valueFound + "' was found");
                }

                if(valueIsEqual == shouldComply) {
                    return element;
                }

                return null;
            }
        };
        poller.poll();
    }
}
