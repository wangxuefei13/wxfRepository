package com.crm.utils;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5UTils {
    /**
     * md5算法进行密码加密程序
     */
    public static String md5(String str) {
        byte[] secretBytes = null;
        try {
            secretBytes = MessageDigest.getInstance("md5").digest(
                    str.getBytes());
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("md5算法出现错误！");
        }

        String md5code = new BigInteger(1, secretBytes).toString(16);// 16进制数字
        // 如果生成数字未满32位，需要前面补0
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        return md5code;
    }

    public static void main(String[] args) {
        System.out.println(md5("123"));

    }


   public static String getMD5(String password){

       try {
           //得到一个信息摘要器
           MessageDigest digest = MessageDigest.getInstance("md5");
           byte[] result = digest.digest(password.getBytes());
           StringBuffer buffer =  new StringBuffer();
           //吧每一个byte 做一个与运算 0×ff;
           for (byte b : result) {
               //与运算
               int number = b & 0xff;//加盐加密
               String str = Integer.toHexString(number);
               if (str.length()==1){
                   buffer.append("0");
               }
               buffer.append(str);
           }
           //标准的md5加密后的结果
           return buffer.toString();
       } catch (NoSuchAlgorithmException e) {
           e.printStackTrace();
           return "";
       }

   }




}
