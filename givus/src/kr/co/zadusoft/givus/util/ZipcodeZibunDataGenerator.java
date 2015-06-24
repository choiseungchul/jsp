/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.model.ZipcodeModel;
import kr.co.zadusoft.contents.model.ZipcodeZibunModel;
import kr.co.zadusoft.contents.service.ZipcodeZibunService;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dynamic.ibatis.util.SearchCondition;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class ZipcodeZibunDataGenerator extends SpringDBUnitTestBase 
{
	public static final String ZIPCODE_ZIBUN_DATA_DELEMETER_COMMA = ",";
	final int CELL_POSTAL_CODE = 0;
	final int CELL_POSTAL_NO = 1;
	final int CELL_CITY = 2;
	final int CELL_SI_GUN_GU = 3;
	final int CELL_EUP_MYUN_DONG = 4;
	final int CELL_RI = 5;
	final int CELL_DOSEO = 6;
	final int CELL_SAN = 7;
	final int CELL_ZIBUN_START_NO = 8;
	final int CELL_ZIBUN_START_SUBNO = 9;
	final int CELL_ZIBUN_END_NO = 10;
	final int CELL_ZIBUN_END_SUBNO = 11;
	final int CELL_BUILDING_NAME = 12;
	final int CELL_DONG_RANGE_START = 13;
	final int CELL_DONG_RANGE_END = 14;
	// 변경일 = 15; <-- 필요없는 데이터라 제외함
	final int CELL_FULL_ADDRESS = 16;
	
	private String filePath = "D:/";
	Logger logger = LogManager.getLogger( ZipcodeZibunDataGenerator.class);
	private int fileCount = 0;
	private int dataCount = 0;
	private int totalDataCount = 0;
	
	@Autowired
	private ZipcodeZibunService zipcodeZibunService;
	
	public ZipcodeZibunService getZipcodeZibunService() {
		return zipcodeZibunService;
	}

	public void setZipcodeZibunService(ZipcodeZibunService zipcodeZibunService) {
		this.zipcodeZibunService = zipcodeZibunService;
	}

	@Test
	public void test(){
		run();
	}
	
	public static void main( String[] args)
	{
		new ZipcodeZibunDataGenerator().run();
	}
	
	private void run(){
		logger.info("### 우편변호 - 지번 데이터 Generator를 시작합니다. ###");
		//1. 필요한 인자들의 기본값 세팅
		initialize();
		try{
			//2. 읽어들일 파일 폴더 설정
			generator();
			StringBuffer message = new StringBuffer();
			message.append("총 [").append( fileCount).append( "] 개의 파일로부터 [")
				.append( totalDataCount).append("] 개의 데이터를 생성하였습니다.\n");

			logger.info( message.toString());
		} catch( Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 1. 필요한 인자들의 기본값 세팅
	 */
	private void initialize(){
		filePath = "D:/sProject/GIVUS/modeling/addressdata_before";
//		setZipcodeExcelLoader( new ZipcodeZibunExcelLoader());
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
				
				// 4. 우편번호_지번 엑셀 
				if(file.getName().contains("우편번호")){
					setZipcodeZibunData( file);
				}
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
	 * 4. 우편번호 입력
	 * @param file
	 */
	private void setZipcodeZibunData( File file) throws Exception{
		logger.info("### 우편변호 - 지번 데이터를 생성합니다. ###");
		
		if ( file.isFile())	{
			fileCount += 1;
			dataCount = 0;
			StringBuffer message = new StringBuffer();
			message.append("[").append( fileCount).append( "] 번째 파일 [").append( file.getName()).append("]의 데이터 삽입 작업을 시작합니다.");
			logger.info( message.toString());
			setDataFromFile( file);
			totalDataCount += dataCount;			
		}
		logger.info("### 우편변호 - 지번 데이터를 생성을 완료했습니다. ###");
	}
	
	/**
	 *  6. 파일의 값 파싱후 dto에 담기
	 *  7. dto를 dao를 통해 db insert
	 * @param file
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	private void setDataFromFile( File file) throws IOException, FileNotFoundException, DAException, Exception{

		BufferedReader br = new BufferedReader( new FileReader( file.getAbsoluteFile()));
		String line = "";

		ZipcodeZibunModel zipcodemodel = new ZipcodeZibunModel();
		while ( ( line = br.readLine()) != null){
			String datas[] = StringUtil.splitString( line, ZIPCODE_ZIBUN_DATA_DELEMETER_COMMA, true);
//			int datalength = 0;
			if (datas != null && datas.length > 1){
				System.out.println("datas[CELL_NAME]" + datas[CELL_POSTAL_CODE]);
				if ( !datas[0].equalsIgnoreCase("우편번호")){
					// 6. 파일의 값 파싱후 dto에 담기
					if ( !datas[0].equalsIgnoreCase(""))
					{
						zipcodemodel.setPostalCode( datas[CELL_POSTAL_CODE]);
						zipcodemodel.setPostalNo( datas[CELL_POSTAL_NO]);
						zipcodemodel.setCity( datas[CELL_CITY]);
						zipcodemodel.setSiGunGu( datas[CELL_SI_GUN_GU]);
						zipcodemodel.setEupMyunDong( datas[CELL_EUP_MYUN_DONG]);
						zipcodemodel.setRi( datas[CELL_RI]);
						zipcodemodel.setDoSeo( datas[CELL_DOSEO]);
						zipcodemodel.setSan( datas[CELL_SAN]);
						zipcodemodel.setZibunStartNo( datas[CELL_ZIBUN_START_NO]);
						zipcodemodel.setZibunStartSubNo( datas[CELL_ZIBUN_START_SUBNO]);
						zipcodemodel.setZibunEndNo( datas[CELL_ZIBUN_END_NO]);
						zipcodemodel.setZibunEndSubNo( datas[CELL_ZIBUN_END_SUBNO]);
						zipcodemodel.setBuildingName( datas[CELL_BUILDING_NAME]);
						zipcodemodel.setDongRangeStart( datas[CELL_DONG_RANGE_START]);
						zipcodemodel.setDongRangeEnd( datas[CELL_DONG_RANGE_END]);
						zipcodemodel.setFullAddress( datas[CELL_FULL_ADDRESS]);
						
						// 7. dto를 dao를 통해 db insert
						insertZipcodeZibun( zipcodemodel);
						dataCount += 1;
					}
				}
			}
		}
		br.close();
	}
	
	/**
	 * 7. dto를 dao를 통해 db insert
	 * @param model
	 * @throws DAException
	 */
	public void insertZipcodeZibun( ZipcodeZibunModel model) throws DAException{
		zipcodeZibunService.create( model);
	}
}
