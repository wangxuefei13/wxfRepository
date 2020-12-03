package com.crm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
/*

        时间util 测试时间是否失效；

 */
public class DateTimeUtils {

    public static String getSysTime() {
        //设置时间输出格式
        SimpleDateFormat sz = new SimpleDateFormat("yyyy-MM--dd HH:mm:ss");
        //将date转换成String
         Date date = new Date();
         String dateStr = sz.format(date);

         return  dateStr;
    }
}
