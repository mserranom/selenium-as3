package flashselenium.exceptions;

import java.util.List;

public enum FlashErrors {

    ELEMENT_NOT_FOUND("FL_ERR_#001"),
    TYPE_NOT_FOUND("FL_ERR_#002");

    private String _code;

    FlashErrors(String code) {
        _code = code;
    }

    public String getCode() {
        return _code;
    }

    public static FlashErrors fromCode(String code) {
        for(FlashErrors error : FlashErrors.values()) {
            if(error.getCode().equals(code)) {
                return error;
            }
        }
        return null;
    }
}
