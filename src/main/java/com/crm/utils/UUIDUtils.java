package com.crm.utils;

import java.util.UUID;

public class UUIDUtils {
    public static void main(String[] args) {
        UUIDUtils ud = new UUIDUtils();
        ud.uu("123");
    }
    public static String uu(String i){
        String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        System.out.println(uuid);
        return uuid;
    }

}
