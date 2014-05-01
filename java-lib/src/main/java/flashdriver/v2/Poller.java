package flashdriver.v2;

import java.util.concurrent.TimeUnit;

public abstract class Poller<T> {

    private long timeout;

    private long pollInterval;

    public Poller(long timeout, long pollInterval) {
        this.timeout = timeout;
        this.pollInterval = pollInterval;
    }

    public T poll() {
        int maxAttempts = (int) (timeout / pollInterval) + 1;
        int currentAttempt = 0;

        while(true) {

            currentAttempt++;

            boolean isLastPoll = currentAttempt >= maxAttempts;

            try {
                T result = execute(isLastPoll);
                if( result != null || isLastPoll) {
                    return result;
                }
            } catch (RuntimeException e) {
                if(isLastPoll) {
                    throw e;
                }
            }

            try {
                TimeUnit.MILLISECONDS.sleep(pollInterval);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    protected abstract T execute(boolean isLastPoll);

}
