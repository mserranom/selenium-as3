package flashdriver.v2;

import flashdriver.core.By;
import flashdriver.core.FlashElement;
import flashdriver.processor.Processor;

public class FindElement {

    private long timeout;
    private long pollInterval;
    private Processor processor;

    public FindElement(Processor processor, long timeout, long pollInterval) {
        this.timeout = timeout;
        this.pollInterval = pollInterval;
        this.processor = processor;
    }

    public FlashElement find(final By by) {
        Poller<FlashElement> poller = new Poller<FlashElement>(timeout, pollInterval) {
            @Override
            protected FlashElement execute(boolean isLastPoll) {
                FlashElement element = new FlashElement(by.getSelector(), processor);
                element.exists();
                return element;
            }
        };
        return poller.poll();
    }
}
