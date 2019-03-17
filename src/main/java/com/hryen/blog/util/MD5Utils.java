package com.hryen.blog.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

// https://www.jianshu.com/p/317a10b8b410

public class MD5Utils {

    public static String encode(String str) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(str.getBytes());
            byte[] digest = md5.digest();
            String md5code = new BigInteger(1, digest).toString(16);
            for (int i = 0; i < 32 - md5code.length(); i++) {
                md5code = "0" + md5code;
            }
            return md5code;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            System.out.println("No MD5 algorithm!");
            return null;
        }
    }

}
