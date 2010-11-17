package me.justshare.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 17, 2010
 */
public class ThisIsNotATest {

    public static void main(String[] a) throws FileNotFoundException {

        StorageService s = new StorageService();

        String space = "just-a-test-space-"+System.currentTimeMillis();
        s.createSpace(space, "123");

        test(s.existSpace(space));
        test(!s.existSpace(space+"lsd"));
        test(s.isPasswordCorrect(space, "123"));
        test(!s.isPasswordCorrect(space, "12d3"));

        test(s.listSharedItems(space, 0).size() == 0);

        s.store(space, new FileInputStream("/users/fdiotalevi/Desktop/doc.txt"), "doc.txt", "a description");
        test(s.listSharedItems(space, 0).size() == 1);

        test(s.listSharedItems(space, 0).get(0).getDescription().equals("a description"));
        test(s.listSharedItems(space, 0).get(0).getFileKey()!=null);
        
    }

    private static void test(boolean value) {
        if (!value)
            throw new RuntimeException("assertion failed");
        else
            System.out.println("ok");
    }



}
