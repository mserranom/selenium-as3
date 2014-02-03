package flashselenium.core.impl;

import flashselenium.connector.JSBridge;
import flashselenium.core.By;
import flashselenium.core.DisplayObjectDriver;
import org.openqa.selenium.NoSuchElementException;

import static java.lang.Thread.sleep;

public class DisplayObjectDriverImpl implements DisplayObjectDriver {


    private String _query;

    private JSBridge _jsBridge;

    public DisplayObjectDriverImpl(JSBridge jsBridge) {
        _query = "";
        _jsBridge = jsBridge;
    }

    @Override
    public DisplayObjectDriver findElement(By by) {

        if(_query.length() > 0) {
            _query += ".";
        }
        _query += by.getQuery();
        return this;
    }

    @Override
    public boolean exists() {
        try {
            _jsBridge.executeViewSpy(_query);
            return true;
        } catch(NoSuchElementException error) {
            return false;
        }

    }

    @Override
    public Object getValue(String propertyName) {
        _query += ".getValue('" + propertyName + "')";
        return _jsBridge.executeViewSpy(_query);
    }

    @Override
    public String getString(String propertyName) {
        return (String) getValue(propertyName);
    }

    @Override
    public long getNumber(String propertyName) {
        return (Long) getValue(propertyName);
    }

    @Override
    public boolean getBoolean(String propertyName) {
        return (Boolean) getValue(propertyName);
    }

    @Override
    public void click() {
        _query += ".click()";
        try {
            sleep(30); //TODO replace with selenium timeouts
        } catch (InterruptedException e) {
            e.printStackTrace();
            Thread.currentThread().interrupt();
        }
        _jsBridge.executeViewSpy(_query);
    }


}
