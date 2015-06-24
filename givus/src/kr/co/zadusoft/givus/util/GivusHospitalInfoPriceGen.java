/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.io.File;
import java.util.List;

import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.service.CategoryService;
import kr.co.zadusoft.contents.service.CodeService;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.service.HospitalStatsService;
import kr.co.zadusoft.contents.service.OperationPriceService;
import kr.co.zadusoft.contents.util.FileUploadHandler;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dynamic.ibatis.util.SearchCondition;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class GivusHospitalInfoPriceGen extends SpringDBUnitTestBase
{
	private String filePath = "D:/";
	
	Logger logger = LogManager.getLogger( GivusHospitalInfoPriceGen.class);
	
	private GivusHospitalExcelLoader hospitalExcelLoader;
	
	private GivusPriceExcelLoader priceExcelLoader;
	
	private GivusRankingExcelLoader rankingExcelLoader;
	
	private GivusPartialRankingExcelLoader partialRankingExcelLoader;
	
	private GivusImagesExcelLoader imagesExcelLoader;
	
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private HospitalStatsService hospitalStatsService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private OperationPriceService operationPriceService;
	@Autowired
	private FileService fileService;


	public GivusHospitalExcelLoader getHospitalExcelLoader() {
		return hospitalExcelLoader;
	}
	
	public void setHospitalExcelLoader(GivusHospitalExcelLoader hospitalExcelLoader) {
		this.hospitalExcelLoader = hospitalExcelLoader;
	}
	
	public GivusPriceExcelLoader getPriceExcelLoader() {
		return priceExcelLoader;
	}

	public void setPriceExcelLoader(GivusPriceExcelLoader priceExcelLoader) {
		this.priceExcelLoader = priceExcelLoader;
	}
	
	public GivusRankingExcelLoader getRankingExcelLoader() {
		return rankingExcelLoader;
	}

	public void setRankingExcelLoader(GivusRankingExcelLoader rankingExcelLoader) {
		this.rankingExcelLoader = rankingExcelLoader;
	}
	
	public GivusPartialRankingExcelLoader getPartialRankingExcelLoader() {
		return partialRankingExcelLoader;
	}

	public void setPartialRankingExcelLoader(
			GivusPartialRankingExcelLoader partialRankingExcelLoader) {
		this.partialRankingExcelLoader = partialRankingExcelLoader;
	}

	public GivusImagesExcelLoader getImagesExcelLoader() {
		return imagesExcelLoader;
	}

	public void setImagesExcelLoader(GivusImagesExcelLoader imagesExcelLoader) {
		this.imagesExcelLoader = imagesExcelLoader;
	}
	

	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public HospitalStatsService getHospitalStatsService() {
		return hospitalStatsService;
	}

	public void setHospitalStatsService(HospitalStatsService hospitalStatsService) {
		this.hospitalStatsService = hospitalStatsService;
	}
	
	public CodeService getCodeService() {
		return codeService;
	}
	
	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	public OperationPriceService getOperationPriceService() {
		return operationPriceService;
	}
	
	public void setOperationPriceService(OperationPriceService operationPriceService) {
		this.operationPriceService = operationPriceService;
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	@Test
	public void test(){
		run();
	}
	
	public static void main( String[] args)
	{
		new GivusHospitalInfoPriceGen().run();
	}
	
	private void run(){
		System.out.println("### 병원정보 및 수술가격 업데이트를 시작합니다. ###");
		//1. 필요한 인자들의 기본값 세팅
		initialize();
		try{
			//2. 읽어들일 파일 폴더 설정
			generator();		
		} catch( Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 1. 필요한 인자들의 기본값 세팅
	 */
	private void initialize(){
		filePath = "D:/sProject/GIVUS/modeling/hospitaldata";
		setHospitalExcelLoader( new GivusHospitalExcelLoader());
		setPriceExcelLoader( new GivusPriceExcelLoader());
		setRankingExcelLoader( new GivusRankingExcelLoader());
		setPartialRankingExcelLoader( new GivusPartialRankingExcelLoader());
		setImagesExcelLoader( new GivusImagesExcelLoader());
	}
	
	/**
	 * 2. 읽어들일 파일 폴더 설정
	 */
	private void generator() throws Exception{
		// 3. 파일 읽어오기(병원정보, 수술가격)
		File files[] = readFiles();
		if ( files != null ){
			for (File file : files){
				System.out.println(file.getName());
				
				// 4. 병원정보 
				if(file.getName().contains("병원정보") || (file.getName().contains("병원 정보"))){
					setHospitalInfoData( file);
				}
//				// 5. 성형가격 설정
//				//System.out.println(file.getName().contains("수술가격"));
//				if(file.getName().contains("수술가격") || file.getName().contains("수술 가격")){
//					setOperationPriceData( file);
//				}
				// 6. 랭킹 점수 설정
//				if(file.getName().contains("랭킹순위") || file.getName().contains("랭킹 순위")){
//					//6.1 성형외과 종합 랭킹순위
//					if ( file.getName().contains("성형외과")){ 
//						setHospitalRanking( file);
//					}
////					//6.2 성형외과 부위별 랭킹순위
////					if ( file.getName().contains("부위별")){ 
////						setHospitalPartialRanking( file);
////					}
//				}
//				// 7. 병원 이미지 파일 업로드
//				if(file.getName().contains("병원") && file.getName().contains("소개") && file.getName().contains("파일업로드")){
//					setHospitalImages( file);
//				}
			}
		}
	}
	/**
	 * 3. 파일 읽어오기(병원정보, 수술가격)
	 * @return
	 */
	private File[] readFiles(){
		// 폴더 체크
		File folder = new File( filePath);
		if ( folder.exists() && folder.isDirectory())
		{
			return folder.listFiles();
		}
		return null;
	}
	/**
	 * 4. 병원정보 입력
	 * @param file
	 */
	private void setHospitalInfoData( File file) throws Exception{
		System.out.println("### 병원정보 생성 및 업데이트를 시작합니다. ###");
		// 파일명 확인
		hospitalExcelLoader.setFilePath( file.getAbsolutePath());
		hospitalExcelLoader.setHospitalService( this.hospitalService);
		hospitalExcelLoader.setHospitalStatsService( this.hospitalStatsService);
		hospitalExcelLoader.setCodeService( this.codeService);
		List<CodeModel> codemodels = (List<CodeModel>)hospitalExcelLoader.getCodeService().search( new SearchCondition( "category", "L"));
		
		hospitalExcelLoader.setCodemodels(codemodels); 
		//6. excel 파일 읽기
		//7. excel 파일 파싱
		hospitalExcelLoader.start();
		System.out.println("### 병원정보 생성 및 업데이트를 종료합니다. ###");
	}
	
	/**
	 * 5. 수술가격 입력
	 * @param file
	 */
	private void setOperationPriceData( File file) throws Exception{
		System.out.println("### 수술가격 생성 및 업데이트를 시작합니다. ###");
		// 파일명 확인
		//System.out.println(file.getAbsolutePath());
		priceExcelLoader.setFilePath( file.getAbsolutePath());
		priceExcelLoader.setHospitalService( this.hospitalService);
		priceExcelLoader.setOperationPriceService( this.operationPriceService);
		priceExcelLoader.setCategoryService(this.categoryService);
		List<CodeModel> codemodels = (List<CodeModel>)codeService.search( new SearchCondition( "category", "L"));
		priceExcelLoader.setCodemodels(codemodels); 
		List<CategoryModel> categorymodels = (List<CategoryModel>)categoryService.search( new SearchCondition( "relatedType", "operationPrice"));
		priceExcelLoader.setCategorymodels(categorymodels);
		//6. excel 파일 읽기
		//7. excel 파일 파싱
		priceExcelLoader.start();
		System.out.println("### 수술가격 생성 및 업데이트를 종료합니다. ###");
	}
	
	/**
	 *  6. 랭킹 점수 설정
	 * @param file
	 * @throws Exception
	 */
	private void setHospitalRanking( File file) throws Exception{
		System.out.println("### 랭킹 관련 점수 생성 및 업데이트를 시작합니다. ###");
		// 파일명 확인
		System.out.println(file.getAbsolutePath());
		rankingExcelLoader.setFilePath( file.getAbsolutePath());
		rankingExcelLoader.setHospitalService( this.hospitalService);
		
		rankingExcelLoader.start();
		System.out.println("### 랭킹 관련 점수 생성 및 업데이트를 종료합니다. ###");
	}
	
	/**
	 *  6.2 부위별 랭킹 점수 설정
	 * @param file
	 * @throws Exception
	 */
	private void setHospitalPartialRanking( File file) throws Exception{
		System.out.println("### 부위별 랭킹 관련 점수 생성 및 업데이트를 시작합니다. ###");
		// 파일명 확인
		System.out.println(file.getAbsolutePath());
		partialRankingExcelLoader.setFilePath( file.getAbsolutePath());
		partialRankingExcelLoader.setHospitalService( this.hospitalService);
		
		partialRankingExcelLoader.start();
		System.out.println("### 부위별 랭킹 관련 점수 생성 및 업데이트를 종료합니다. ###");
	}
	
	/**
	 * 7. 병원 이미지 파일 업로드 
	 * @param file
	 * @throws Exception
	 */
	private void setHospitalImages( File file) throws Exception{
		System.out.println("### 병원 이미지 파일 업로드를 시작합니다. ###");
		// 파일명 확인
		System.out.println(file.getAbsolutePath());
		imagesExcelLoader.setFilePath( file.getAbsolutePath());
		imagesExcelLoader.setHospitalService( this.hospitalService);
//		imagesExcelLoader.setUploadServer( imagesExcelLoader.UPLOAD_SERVER_AWS);
		imagesExcelLoader.setUploadServer( imagesExcelLoader.UPLOAD_SERVER_LOCAL);
		imagesExcelLoader.setRepository( "D:/givus_repository");
		imagesExcelLoader.setImageRootPath("D:/sProject/GIVUS/modeling/hospitaldata/hospitalimages");
		imagesExcelLoader.setFileService( this.fileService);
		
		imagesExcelLoader.start();
		System.out.println("### 병원 이미지 파일 업로드를 종료합니다. ###");
	}
}
