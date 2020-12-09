package com.crm.utils;

import java.util.UUID;

public class UUIDUtils {
    /**
     * by 冯帅
     * 通过随机数获取加密的id
     * @return
     * @param uu
     */
    public static String getEncryption_ID(String uu){
        String Encryption_ID = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        return Encryption_ID;
    }


}
