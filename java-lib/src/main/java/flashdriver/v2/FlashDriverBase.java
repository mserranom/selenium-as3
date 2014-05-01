package flashdriver.v2;

import flashdriver.core.By;
import flashdriver.core.FlashElement;
import flashdriver.core.FlashFunction;
import flashdriver.messages.Selector;
import flashdriver.messages.SelectorType;
import flashdriver.processor.Processor;

import java.util.ArrayList;
import java.util.List;

public abstract class FlashDriverBase implements FlashDriver {


    public static final long DEFAULT_POLL_INTERVAL = 500;
    public static final long DEFAULT_TIMEOUT = 5000;

    private long implicitTimeout = DEFAULT_TIMEOUT;
    private long implicitPollInterval = DEFAULT_POLL_INTERVAL;

    private long dirtyTimeout;
    private long dirtyPollInterval;
    private boolean timeoutIsDirty;

    @Override
    public abstract void connect();

    @Override
    public abstract void connect(int port, int timeout);

    @Override
    public abstract void close();

    protected abstract Processor getProcessor();

    @Override
    public Query withTimeout(long timeout) {
        return withTimeout(timeout, implicitPollInterval);
    }

    @Override
    public Query withTimeout(long timeout, long pollInterval) {
        dirtyPollInterval = implicitPollInterval;
        dirtyTimeout = timeout;
        timeoutIsDirty = true;
        return this;
    }

    @Override
    public void setDefaultTimeout(long timeout) {
        setDefaultTimeout(timeout, implicitPollInterval);
    }

    @Override
    public void setDefaultTimeout(long timeout, long pollInterval) {
        implicitTimeout = timeout;
        implicitPollInterval = pollInterval;
    }

    @Override
    public FlashElement findElement(final By by) {

        FindElement finder;
        if(timeoutIsDirty) {
            timeoutIsDirty = false;
            finder = new FindElement(getProcessor(), dirtyTimeout, dirtyPollInterval);
        } else {
            finder =  new FindElement(getProcessor(), implicitTimeout, implicitPollInterval);
        }
        return finder.find(by);
    }

    @Override
    public ExpectedConditions waitUntilElement(By by) {
        ExpectedConditions expectedConditions;
        if(timeoutIsDirty) {
            timeoutIsDirty = false;
            expectedConditions = new ExpectedConditionsImpl(by, getProcessor(), dirtyTimeout, dirtyPollInterval);
        } else {
            expectedConditions = new ExpectedConditionsImpl(by, getProcessor(), implicitTimeout, implicitPollInterval);
        }
        return expectedConditions;
    }

    @Override
    public String executeFunction(String id) {
        return executeFunction(id, new ArrayList<String>());
    }

    @Override
    public String executeFunction(String id, List<String> params) {
        FlashFunction element = new FlashFunction(new Selector(SelectorType.ID, id), getProcessor());
        return element.execute(params);
    }
}
