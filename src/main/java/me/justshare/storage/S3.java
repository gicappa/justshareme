package me.justshare.storage;

import org.jets3t.service.S3Service;
import org.jets3t.service.S3ServiceException;
import org.jets3t.service.acl.AccessControlList;
import org.jets3t.service.impl.rest.httpclient.RestS3Service;
import org.jets3t.service.model.S3Bucket;
import org.jets3t.service.model.S3Object;
import org.jets3t.service.security.AWSCredentials;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 16, 2010
 */
public class S3 {

    private static final String awsAccessKey = AmazonKeys.awsAccessKey;
    private static final String awsSecretKey = AmazonKeys.awsSecretKey;
    private static final String BUCKET = "justshareme";

    S3Service s3Service;

    public S3() throws S3ServiceException
    {
        AWSCredentials awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        s3Service = new RestS3Service(awsCredentials);
    }

    public void listBuckets() throws S3ServiceException
    {
        S3Bucket[] myBuckets = s3Service.listAllBuckets();
        for (S3Bucket bucket : myBuckets)
            System.out.println(bucket.getName());
    }

    public void storeFile(File f, String space) throws S3ServiceException
    {
        S3Bucket photoBucket = getApplicationBucket();

        S3Object obj = new S3Object();
        obj.setAcl(AccessControlList.REST_CANNED_PUBLIC_READ);
        obj.setDataInputFile(f);
        obj.setKey(space + "/"+System.currentTimeMillis()+"-"+f.getName());
        obj.setBucketName(BUCKET);
        obj.setContentLength(f.length());
        obj.setContentType(guessContentType(f.getName()));
        s3Service.putObject(photoBucket, obj);
    }

    public void storeStream(String key, InputStream stream, String space) throws S3ServiceException
    {
        S3Bucket photoBucket = getApplicationBucket();

        S3Object obj = new S3Object();
        obj.setAcl(AccessControlList.REST_CANNED_PUBLIC_READ);
        obj.setDataInputStream(stream);
        obj.setKey(space + "/"+System.currentTimeMillis()+"-"+key);
        obj.setBucketName(BUCKET);
        obj.setContentType(guessContentType(key));
        s3Service.putObject(photoBucket, obj);
    }

    private S3Bucket getApplicationBucket() throws S3ServiceException {
        S3Bucket photoBucket = s3Service.getBucket(BUCKET);
        return photoBucket;
    }


    private String guessContentType(String name) {
        if (name.endsWith(".jpg") || name.endsWith(".jpeg"))
            return "image/jpeg";
        else if (name.endsWith(".png"))
            return "image/x-png";
        else if (name.endsWith(".gif"))
            return "image/gif";
        else
            return "text/plain";


    }

    public static void main(String[] args) throws S3ServiceException {
//		new Storage().storeFile(new File("/Users/fdiotalevi/Pictures/photo.diotalevi.com/roma1.jpg"));

        new S3().storeFile(new File("/Users/fdiotalevi/Desktop/doc.txt"), "test");
    }

}
    