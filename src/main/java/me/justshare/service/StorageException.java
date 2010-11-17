package me.justshare.service;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 17, 2010
 */
public class StorageException extends RuntimeException{

    public StorageException(String s, Throwable throwable) {
        super(s, throwable);
    }
}
