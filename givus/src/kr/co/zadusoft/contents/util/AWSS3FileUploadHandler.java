/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.transfer.TransferManager;
import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleOp;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.util.ConfigHandler;

import kr.co.zadusoft.contents.model.FileModel;

public class AWSS3FileUploadHandler extends FileUploadHandler{
	
	private ConfigHandler configHandler;
	
	public ConfigHandler getConfigHandler() {
		return configHandler;
	}
	public void setConfigHandler(ConfigHandler configHandler) {
		this.configHandler = configHandler;
		init();
	}
	
	protected AmazonS3 s3client;
	protected TransferManager tm;
	
	public AWSS3FileUploadHandler(){
		
	}
	
	public void init(){
		AWSCredentials myCredentials = new BasicAWSCredentials( configHandler.getProperty( "aws.accesskeeyid"), configHandler.getProperty( "aws.secretaccesskey"));
//		 tm = new TransferManager( myCredentials);
		s3client = new AmazonS3Client( myCredentials);
	}
	
	@Override
	public String saveFile(MultipartFile file) throws Exception {
		
		String key = generateFileName( file.getOriginalFilename());
		
		ObjectMetadata meta = new ObjectMetadata();
		meta.setContentLength( file.getSize());
		s3client.putObject(new PutObjectRequest( configHandler.getProperty( "aws.s3.bucketname"), key, file.getInputStream(), meta));
		
		return key;
	}
	
	/**
	 * size 크기의 썸네일 이미지를 생성한다.
	 * @param source
	 * @param thumbSize 생성되는 썸네일 이미지의 크기 
	 * @throws IOException
	 */
	public void createThumbnail( FileModel model, int thumbSize) throws IOException, DAException{
		
		InputStream fis = null;  
        InputStream bis = null;  
        BufferedOutputStream out = null;
		try{
			fis = getFileInputStream( model.getPath()); 
	        bis = new BufferedInputStream( fis);  
	        BufferedImage sourceImage = ImageIO.read(bis);  
	
			int thumbWidth, thumbHeight;
			if( sourceImage.getWidth( null) > sourceImage.getHeight( null))
			{
				thumbWidth = thumbSize;
				float ratio = (float)sourceImage.getHeight( null) / (float)sourceImage.getWidth( null);
				thumbHeight = (int)((float)thumbSize * ratio);
			}
			else
			{
				thumbHeight = thumbSize;
				float ratio = (float)sourceImage.getWidth( null) / (float)sourceImage.getHeight( null);
				thumbWidth = (int)((float)thumbSize * ratio);
			}
			
			// java-image-scaling-0.8.6
			ResampleOp resampleOp = new ResampleOp( thumbWidth, thumbHeight);
			resampleOp.setUnsharpenMask( AdvancedResizeOp.UnsharpenMask.Soft);
			BufferedImage rescaledImage = resampleOp.filter( sourceImage, null);
			
			// Thumbnail file name
	     	String fileName = getThumbnailFileName( model.getPath(), thumbSize);
	     	File temp = File.createTempFile( fileName, "_thumb");
	     	
			// create temp thumb image file
			ImageIO.write( rescaledImage, "jpg", temp);
	        
	        ObjectMetadata meta = new ObjectMetadata();
			meta.setContentLength( temp.length());
			
	        s3client.putObject( new PutObjectRequest( configHandler.getProperty( "aws.s3.bucketname"), fileName, new FileInputStream( temp), meta));
	        
	        FileModel fileModel = new FileModel();
			fileModel.setPath( fileName);
			fileModel.setName( model.getName());
			fileModel.setFileType( model.getFileType());
			fileModel.setSize( (int)temp.length());
			fileModel.setRelationId( model.getId());
			fileModel.setRelationType( FileModel.RELATIONTYPE_THUMB);
			
			getFileDAO().create( fileModel);
			
		}finally{
			if( fis != null){
				fis.close();
			}
			if( bis != null){
				bis.close();
			}
			if( out != null){
				out.close();
			}
		}
	}
	
	public void createThumbnail2( FileModel model, int thumbSize) throws IOException, DAException{
		
		InputStream fis = null;  
        InputStream bis = null;  
        BufferedOutputStream out = null;
		try{
			fis = getFileInputStream( model.getPath()); 
	        bis = new BufferedInputStream( fis);  
	        Image sourceImage = (Image) ImageIO.read(bis);  
	
			int thumbWidth, thumbHeight;
			if( sourceImage.getWidth( null) > sourceImage.getHeight( null))
			{
				thumbWidth = thumbSize;
				float ratio = (float)sourceImage.getHeight( null) / (float)sourceImage.getWidth( null);
				thumbHeight = (int)((float)thumbSize * ratio);
			}
			else
			{
				thumbHeight = thumbSize;
				float ratio = (float)sourceImage.getWidth( null) / (float)sourceImage.getHeight( null);
				thumbWidth = (int)((float)thumbSize * ratio);
			}
			
			BufferedImage thumbImage = new BufferedImage(thumbWidth, thumbHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D  g2 = thumbImage.createGraphics();
			g2.setBackground( Color.WHITE);
			g2.drawImage( sourceImage, 0, 0, thumbWidth, thumbHeight, null);
			g2.dispose();
			
			// Thumbnail file name
	     	String fileName = getThumbnailFileName( model.getPath(), thumbSize);
	     	File temp = File.createTempFile( fileName, "_thumb");
	     	
			// create temp thumb image file
			out = new BufferedOutputStream( new FileOutputStream( temp));
	        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder( out);  
	        JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam( thumbImage);
	        param.setQuality( 0.75f, false);
	        encoder.setJPEGEncodeParam(param);  
	        encoder.encode(thumbImage);  
	        
	        ObjectMetadata meta = new ObjectMetadata();
			meta.setContentLength( temp.length());
			
	        s3client.putObject( new PutObjectRequest( configHandler.getProperty( "aws.s3.bucketname"), fileName, new FileInputStream( temp), meta));
	        
	        FileModel fileModel = new FileModel();
			fileModel.setPath( fileName);
			fileModel.setName( model.getName());
			fileModel.setFileType( model.getFileType());
			fileModel.setSize( (int)temp.length());
			fileModel.setRelationId( model.getId());
			fileModel.setRelationType( FileModel.RELATIONTYPE_THUMB);
			
			getFileDAO().create( fileModel);
			
		}finally{
			if( fis != null){
				fis.close();
			}
			if( bis != null){
				bis.close();
			}
			if( out != null){
				out.close();
			}
		}
	}
	
	public boolean delete( FileModel model) throws DAException{
		if( FileModel.FILE_TYPE_IMAGE.equals( model.getFileType())){
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_THUMB));;
			conditions.add( new SearchCondition( "relationId", model.getId()));;
			
			List<FileModel> thumbs = getFileDAO().search( conditions);
			if( thumbs != null){
				for( FileModel thumb : thumbs){
					s3client.deleteObject( configHandler.getProperty( "aws.s3.bucketname"), thumb.getPath());
					getFileDAO().delete( thumb.getId());
				}
			}
		}
		
		s3client.deleteObject( configHandler.getProperty( "aws.s3.bucketname"), model.getPath());
		
		return true;
	}
	
	@Override
	public InputStream getFileInputStream( String filePath) {
		
		try{
			S3Object object = s3client.getObject( new GetObjectRequest( configHandler.getProperty( "aws.s3.bucketname"), filePath));
			InputStream objectData = object.getObjectContent();
			
			return objectData;
		}catch( AmazonS3Exception e){
			e.printStackTrace();
			return null;
		}
	}
	
	public InputStream getThumbInputStream( String filePath, int size){
		String key = getThumbnailFileName( filePath, size);
		
		return getFileInputStream( key);
	}
}
