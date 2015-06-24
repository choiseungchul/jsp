/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.dao.FileDAO;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.util.FileUploadHandler;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import dynamic.ibatis.util.PlainSearchCondition;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.IDGenerator;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;

public class GivusImagesExcelLoader extends ExcelHandlerBase 
{
	final String SEMICOLON_DELEMETER = ";";
	final String FOLDER_PATH_DELEMETER = "/";
	final String FILE_THUMB_BEGINS = "thumb_";
	
	final int CELL_NO = 0;
	final int CELL_NAME = 1;
	final int CELL_HOMEPAGE = 2;
	// 병원상세설명은 무시
	final int CELL_FILENAME = 4;
	
	final String UPLOAD_SERVER_LOCAL = "L";
	final String UPLOAD_SERVER_AWS = "A";
	
	String imageRootPath = "D:/sProject/GIVUS/modeling/hospitaldata/hospitalimages";	
	String uploadServer = UPLOAD_SERVER_LOCAL;
	/**
	 * 업로드된 이미지가 저장되는 물리적 위치
	 */
	private String repository;
	
	private HospitalService hospitalService;
	private FileService fileService;

	public String getImageRootPath() {
		return imageRootPath;
	}

	public void setImageRootPath(String imageRootPath) {
		this.imageRootPath = imageRootPath;
	}

	public String getUploadServer() {
		return uploadServer;
	}

	public void setUploadServer(String uploadServer) {
		this.uploadServer = uploadServer;
	}

	public String getRepository() {
		return repository;
	}

	public void setRepository(String repository) {
		this.repository = repository;
	}
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	@Override
	public void handleRow(XSSFRow row, int rowNum) throws Exception {
		// TODO Auto-generated method stub
		if ( rowNum == 0 ) return;
		XSSFCell cell = row.getCell(CELL_NO);
		// 넘버링이 되어있지 않으면 DB에 입력할 데이터가 아님
		if ( getCellValue(cell) != null && XSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()){
			String name = String.valueOf( row.getCell(CELL_NAME));
			System.out.println( "name=" + name);
			
			if ( name!=null && !name.equals("")){
				//0. 병원이름의 업로드할 파일 폴더와 하위에 파일이 존재하는지 우선 확인
				StringBuffer imagesFilePath = new StringBuffer();
				imagesFilePath.append( imageRootPath).append( FOLDER_PATH_DELEMETER).append( name);
				
				System.out.println( "imagesFilePath =" + imagesFilePath.toString());
				File[] files = readFiles( imagesFilePath.toString());
				
				if ( files != null && files.length > 0 )
				{
					//1. 병원이름으로 id 가져오기
					HospitalModel hospitalmodel = (HospitalModel)hospitalService.get( new SearchCondition( "name", name));
					// 병원 정보가 없는 경우는 해당 병원명으로 업로드할 파일 존재하므로 병원 정보 생성
					if ( hospitalmodel == null || hospitalmodel.getId() == 0) {
						hospitalmodel = createHospital( row);
					}
					if ( hospitalmodel != null && hospitalmodel.getId() != 0) {
						for ( File file : files){
							//2. 병원 id를 이용해서 filemodel 셋팅하기
							FileModel model = existFile( file.getName(), hospitalmodel.getId());
							if ( file.getName().contains( FILE_THUMB_BEGINS)){
								System.out.println( "model =" + model);
							}
							//FileModel 
							model = setFileModel( row, hospitalmodel, file, model);
							String path = "";
							
							//3. aws 업로드인 경우는 filemodel을 생성후에 id를 이용해서 s3client.putObject 업로드,
							if (uploadServer.equals(UPLOAD_SERVER_AWS)){
								path = uploadFileToAWS(file, hospitalmodel.getId());
							}
							//4. 일반 업로드인경우는 fileuploadhandler.savefile한 후에 filemodel을 생성.
							else if ( uploadServer.equals(UPLOAD_SERVER_LOCAL)){
								path = uploadFile( file, hospitalmodel.getId());
							}
							
							model.setPath(path);
							if (model.getId() > 0){
								updateFile(model);
							}else{
								createFile(model);
							}
						}
					}
				}
				
			}
		}
	}
	
	/**
	 * 3. 이미지 파일 읽어오기
	 * @return
	 */
	private File[] readFiles( String imagesFilePath){
		// 폴더 체크
		File folder = new File( imagesFilePath);
		if ( folder.exists() && folder.isDirectory())
		{
			return folder.listFiles();
		}
		return null;
	}
	
	/**
	 * 업로드할 병원 이미지는 있는데 병원 정보가 없을경우 신규 생성
	 * @param row
	 * @return
	 * @throws DAException
	 */
	private HospitalModel createHospital( XSSFRow row) throws DAException{
		HospitalModel model = new HospitalModel();
		model.setName((String)getCellValue( row.getCell(CELL_NAME)));
		model.setHomepage((String)getCellValue( row.getCell(CELL_HOMEPAGE)));
		return (HospitalModel)hospitalService.create( model);
	}
	
	/**
	 * FileModel을 셋팅후 반환
	 * @param row
	 * @param hospitalmodel
	 * @param file
	 * @return
	 */
	private FileModel setFileModel( XSSFRow row, HospitalModel hospitalmodel, File file, FileModel model){
		//FileModel model = new FileModel();
		if ( model == null) model = new FileModel();
		model.setName( file.getName());
		model.setFileType( checkFileType( file.getName()));
		model.setSize( (int)file.length());
		model.setRelationId( hospitalmodel.getId());
		
		if ( file.getName().contains( FILE_THUMB_BEGINS)) { // 가격비교와 순위 목록에 표현되는 이미지
			model.setRelationType( FileModel.RELATIONTYPE_HOSPITAL);
		}
		else{
			model.setRelationType( FileModel.RELATIONTYPE_HOSPITAL_GALLERY);
		}
		
		return model;
	}
	
	/**
	 * 파일 확장자를 통해 파일 타입을 설정
	 * @param fileName
	 * @return
	 */
	protected String checkFileType( String fileName){
		String ext = StringUtil.getFileExt(fileName);
		String fileType = FileModel.fileTypes.get( ext.toLowerCase());
		if( fileType == null){
			return FileModel.FILE_TYPE_ETC;
		}
		
		return fileType;
	}
	
	/**
	 * 해당 병원의 이미지 파일명을 DB값과 비교
	 * @param name
	 * @return 
	 * @throws DAException
	 */
	private FileModel existFile( String fileName, int hospitalId) throws DAException{
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "relationId", hospitalId));
		
		//병원 대표이미지는 1개만 등록 허용
		if ( fileName.contains( FILE_THUMB_BEGINS)){
			conditions.add( new PlainSearchCondition( " name like 'thumb_%' "));
			conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL));
		}else{
			conditions.add( new SearchCondition( "name", fileName));
			conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL_GALLERY));
		}
		
		return (FileModel)fileService.get(conditions);
	}
	
	/**
	 * 파일 정보 update
	 * @param model
	 * @throws DAException
	 */
	private void updateFile( FileModel model) throws DAException{
		fileService.update(model);
	}
	
	/**
	 * 파일 정보 create
	 * @param model
	 * @return FileModel
	 * @throws DAException
	 */
	private FileModel createFile( FileModel model) throws DAException{
		return (FileModel) fileService.create( model);
	}
	
	/**
	 * 물리적 파일을 업로드
	 * @param file
	 * @param id
	 * @return path
	 * @throws Exception
	 */
	private String uploadFile( File file, int id) throws Exception{
		return saveFile( file);
	}
	
	/**
	 * 물리적 파일을 업로드 디렉토리에 저장하고 관련정보를 디비에 기록한다.
	 * @param fileName
	 * @param image
	 * @param thumbnailSize
	 * @return path
	 * @throws Exception
	 */
	public String saveFile( File file) throws Exception
	{
		// 파일을 저장한다.
		String savedFileName = generateFileName( file.getName());
		
		String path = repository + "/" + savedFileName;

		
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try{
			bis = new BufferedInputStream(new FileInputStream(file));
            bos = new BufferedOutputStream( new FileOutputStream( new File( path)));
            
            int i = 0;
            while((i=bis.read())!= -1){
            	// 1바이트씩 출력버퍼에 담는다.
            	bos.write(i);
            }

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(bis != null) try{bis.close();}catch(IOException e){}
			if(bos != null) try{bos.close();}catch(IOException e){}
		}
		
		return path;
	}
	/**
	 * 물리적 파일 업로드시 유니크 파일명 생성
	 * @param fileName
	 * @return
	 */
	protected String generateFileName( String fileName)
	{
		return String.valueOf( IDGenerator.generateID()) + "." + StringUtil.getFileExt(fileName);
	}
	
	/**
	 * AWS 서버에 파일 업로드
	 * @param file
	 * @param id
	 * @return
	 */
	private String uploadFileToAWS( File file, int id){
		/*
		 * 		
		String key = generateFileName( file.getOriginalFilename());
		
		ObjectMetadata meta = new ObjectMetadata();
		meta.setContentLength( file.getSize());
		s3client.putObject(new PutObjectRequest( configHandler.getProperty( "aws.s3.bucketname"), key, file.getInputStream(), meta));
		
		return key;
		 */
		// upload
//		String sampleFile = "g:/temp/lottoinfo.txt";
//		File file = new File( sampleFile);
		String key = generateFileName( file.getName());
		
		AWSCredentials myCredentials = new BasicAWSCredentials( "AKIAJKNQAKPZ3KTLPG6A", "lgoEBjEWsr0wqOIKA1jEJfzHrOtLWhTjrON4turL");
		AmazonS3 s3client = new AmazonS3Client( myCredentials);
		s3client.putObject(new PutObjectRequest( "givus-uploaded-files", key, file));
		
		return key;
	}

}
