package flashselenium.core;

import flashselenium.connector.JSBridge;
import flashselenium.connector.JSExecutorPoller;
import flashselenium.core.ExpectedConditions;

public class Wait {

    private static final int TIMEOUT_DEFAULT = 5000;

    private static final int POLL_INTERVAL_DEFAULT = 500;

    private long _pollInterval;

    private long _timeout;

    private JSBridge _jsBridge;

    public Wait(JSBridge jsbridge) {
        _timeout = TIMEOUT_DEFAULT;
        _pollInterval = POLL_INTERVAL_DEFAULT;
        _jsBridge = jsbridge;
    }

    public void until(ExpectedConditions conditions) {
        JSExecutorPoller poller = new JSExecutorPoller(_jsBridge);
        poller.execute(conditions.getQuery());
    }
}
