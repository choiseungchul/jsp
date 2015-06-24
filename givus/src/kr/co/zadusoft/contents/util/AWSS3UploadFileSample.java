/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.io.File;
import java.io.InputStream;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.transfer.TransferManager;

public class AWSS3UploadFileSample {
	public static void main(String[] args) throws Exception{
		
		// upload
		String sampleFile = "g:/temp/lottoinfo.txt";
		File file = new File( sampleFile);
		AWSCredentials myCredentials = new BasicAWSCredentials( "AKIAJKNQAKPZ3KTLPG6A", "lgoEBjEWsr0wqOIKA1jEJfzHrOtLWhTjrON4turL");
		AmazonS3 s3client = new AmazonS3Client( myCredentials);
		s3client.putObject(new PutObjectRequest( "givus-uploaded-files", "1234", file));
		
		TransferManager tm = new TransferManager( myCredentials);
		
		// download
		try{
			S3Object object = s3client.getObject( new GetObjectRequest( "givus-uploaded-files", "139152921276101.jpg"));
			InputStream objectData = object.getObjectContent();
			objectData.close();
		}catch( AmazonS3Exception e){
			System.out.println( e.getMessage());
			System.out.println( "file not exist");
		}
		// Process the objectData stream.
	}
}
