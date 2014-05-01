package flashdriver.v2;


public interface FlashDriver extends Query {

    public void connect();

    public void connect(int port);

    public void connect(int port, int timeout);

    public void close();

    Query withTimeout(long timeout);

    Query withTimeout(long timeout, long pollInterval);

    void setDefaultTimeout(long timeout);

    void setDefaultTimeout(long timeout, long pollInterval);

}
