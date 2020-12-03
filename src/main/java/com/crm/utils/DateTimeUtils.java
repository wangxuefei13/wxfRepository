package com.crm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtils {

    public static void main(String[] args) {
        DateTimeUtils da = new DateTimeUtils();
        da.getNowDate();
    }
    public static String getNowDate() {
        Date d1 = new Date(119,7,15,12,12,12);
        //设置时间输出格式
        SimpleDateFormat sz = new SimpleDateFormat("yyyy-MM--dd HH:mm:ss");
        //将date转换成String
        String format = sz.format(d1);
        System.out.println(format);
        return format;
    }


}
