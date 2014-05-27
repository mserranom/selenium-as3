package flashdriver.core;

import java.util.List;

public interface Query {

    FlashElement findElement(By by);

    ExpectedConditions waitUntilElement(By by);

    String executeFunction(String id);

    String executeFunction(String id, List<String> params);

}
