package com.voicehelp.backend.common;

import java.util.Map;

public class StringUtils {

    /**
     * Format string with params names in brackets
     *
     * @param pattern    string pattern
     * @param parameters Map of parameter name(key) and parameter value
     */
    public static String formatWithParams(String pattern, Map<String, String> parameters) {
        var result = pattern;
        for (Map.Entry<String, String> entry : parameters.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            result = pattern.replace("{"+key+"}", value);
        }
        return result;
    }

}
