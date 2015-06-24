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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

import org.springframework.web.multipart.MultipartFile;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleOp;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import kr.co.zadusoft.contents.dao.FileDAO;
import kr.co.zadusoft.contents.model.FileModel;

import dynamic.ibatis.util.SearchCondition;
import dynamic.util.IDGenerator;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;

public class FileUploadHandler {
	
	/**
	 * 업로드된 이미지가 저장되는 물리적 위치
	 */
	private String repository;
	
	private FileDAO fileDAO;
	
	public String getRepository() {
		return repository;
	}

	public void setRepository(String repository) {
		this.repository = repository;
	}

	public FileDAO getFileDAO() {
		return fileDAO;
	}

	public void setFileDAO(FileDAO fileDAO) {
		this.fileDAO = fileDAO;
	}

	/**
	 * 물리적 파일을 업로드 디렉토리에 저장하고 관련정보를 디비에 기록한다.
	 * @param fileName
	 * @param image
	 * @param thumbnailSize
	 * @return
	 * @throws Exception
	 */
	public String saveFile( MultipartFile file) throws Exception
	{
		// 파일을 저장한다.
		String savedFileName = generateFileName( file.getOriginalFilename());
		
		String path = getRepository() + "/" + savedFileName;
		FileOutputStream fos = null;
		try{
			fos = new FileOutputStream( new File( path));
			fos.write( file.getBytes());
		}finally{
			if( fos != null){
				fos.close();
				fos = null;
			}
		}
		
		return path;
	}
	
	/**
	 * size 크기의 썸네일 이미지를 생성한다.
	 * @param source
	 * @param thumbSize 생성되는 썸네일 이미지의 크기 
	 * @throws IOException
	 */
	public void createThumbnail( FileModel model, int thumbSize) throws IOException, DAException{
		
		FileInputStream fis = null;  
        InputStream bis = null;  
        BufferedOutputStream out = null;
		try{
			fis = new FileInputStream( model.getPath()); 
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
	     	File file = new File( fileName);
	     	
	     	// create temp thumb image file
	     	ImageIO.write( rescaledImage, "jpg", file);
	        
	        FileModel fileModel = new FileModel();
			fileModel.setPath( fileName);
			fileModel.setName( model.getName());
			fileModel.setFileType( model.getFileType());
			fileModel.setSize( (int)file.length());
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
	
	public boolean exist( String filePath){
		File file = new File( filePath);
		return file.exists();
	}
	
	public boolean thumbExist( String filePath, int size){
		File file = new File( getThumbnailFileName( filePath, size));
		return file.exists();
	}
	
	public boolean delete( FileModel model) throws DAException{
		File file = new File( model.getPath());
		
		if( file.exists()){
			
			if( FileModel.FILE_TYPE_IMAGE.equals( model.getFileType())){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_THUMB));;
				conditions.add( new SearchCondition( "relationId", model.getId()));;
				
				List<FileModel> thumbs = fileDAO.search( conditions);
				if( thumbs != null){
					for( FileModel thumb : thumbs){
						File _file = new File( thumb.getPath());
						if( _file != null && _file.exists()){
							_file.delete();
						}
						fileDAO.delete( thumb.getId());
					}
				}
			}
			
			return file.delete();
		}
		
		return false;
	}
	
	public InputStream getFileInputStream( String filePath) {
		
		File file = new File( filePath);
		FileInputStream fis = null;
		if( file.exists()){
			try{
				fis = new FileInputStream( file);
			}catch( FileNotFoundException e){
				e.printStackTrace();
				
				return null;
			}
		}
		
		return fis;
	}
	
	public InputStream getThumbInputStream( String filePath, int size){
		File file = new File( getThumbnailFileName( filePath, size));
		FileInputStream fis = null;
		if( file.exists()){
			try{
				fis = new FileInputStream( file);
			}catch( FileNotFoundException e){
				e.printStackTrace();
			}
		}
		
		return fis;
	}
	
	/**
	 * 정해진 규칙에 따라 썸네일 파일 이름을 가져온다. 생성되는 모든 썸네일 해당 규칙에 맞추어서 생성된다.
	 * [fileName]_[size].[ext]
	 * @param fileName
	 * @param thumbSize
	 * @return
	 */
	protected String getThumbnailFileName( String fileName, int thumbSize){
		// Thumbnail file name
		fileName = StringUtil.addFileNameSuffix( fileName, "_" + thumbSize);
		
		return fileName;
	}
	
	protected String generateFileName( String fileName)
	{
		return String.valueOf( IDGenerator.generateID()) + "." + StringUtil.getFileExt(fileName);
	}
}
