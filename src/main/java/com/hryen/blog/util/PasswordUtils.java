package com.hryen.blog.util;

import org.springframework.stereotype.Component;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.SecureRandom;

@Component
public class PasswordUtils {

    private final byte[] DES_KEY = { 22, 1, -110, 82, -32, -85, -128, -65 };

    public String encrypt(String str) {
        String tempStr = null;
        try {
            SecureRandom secureRandom = new SecureRandom();
            DESKeySpec desKeySpec = new DESKeySpec(DES_KEY);
            SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = secretKeyFactory.generateSecret(desKeySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, secureRandom);
            tempStr = new BASE64Encoder().encode(cipher.doFinal(str.getBytes()));
        } catch (Exception e) {}
        return tempStr;
    }

    public String decrypt(String str) {
        String tempStr = null;
        try {
            SecureRandom secureRandom = new SecureRandom();
            DESKeySpec desKeySpec = new DESKeySpec(DES_KEY);
            SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey secretKey = secretKeyFactory.generateSecret(desKeySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey, secureRandom);
            tempStr = new String(cipher.doFinal(new BASE64Decoder().decodeBuffer(str)));
        } catch (Exception e) {}
        return tempStr;
    }

}









