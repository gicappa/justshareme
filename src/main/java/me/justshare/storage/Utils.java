package me.justshare.storage;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 17, 2010
 */
public class Utils {

    public static String guessContentType(String name) {
        if (name.endsWith(".jpg") || name.endsWith(".jpeg"))
            return "image/jpeg";
        else if (name.endsWith(".png"))
            return "image/x-png";
        else if (name.endsWith(".gif"))
            return "image/gif";
        else
            return "application/octet-stream";
    }

}
