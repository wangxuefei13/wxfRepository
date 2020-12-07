package com.crm.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class IPutil {

    private static HttpServletRequestWrapper request;

    public static String getClientIp() {

        String remoteAddr = "";


            if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        return remoteAddr;
    }

}



