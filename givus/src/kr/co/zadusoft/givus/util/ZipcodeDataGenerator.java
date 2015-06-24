/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Date;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;
import kr.co.zadusoft.contents.model.ZipcodeModel;
import kr.co.zadusoft.contents.service.ZipcodeService;

@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class ZipcodeDataGenerator extends SpringDBUnitTestBase
{
	public static final String ZIPCODE_DATA_DELEMETER = "|";
	
	Logger logger = LogManager.getLogger( ZipcodeDataGenerator.class);

	
	private String filePath = "D:\\";
	
	private int fileCount = 0;
	private int dataCount = 0;
	private int totalDataCount = 0;

	@Autowired
	private ZipcodeService zipcodeService;
	public ZipcodeService getZipcodeService() {
		return zipcodeService;
	}

	public void setZipcodeService(ZipcodeService zipcodeService) {
		this.zipcodeService = zipcodeService;
	}
	public static void main( String[] args)
	{
		new ZipcodeDataGenerator().run();
	}
	
	@Test
	public void testRun() throws Exception {
		run();
	}
	
	private void run(){
		
		initialize();
		try{
			generator();
			StringBuffer message = new StringBuffer();
			message.append("총 [").append( fileCount).append( "] 개의 파일로부터 [")
				.append( totalDataCount).append("] 개의 데이터를 생성하였습니다.\n");

			logger.info( message.toString());
		}
		catch( FileNotFoundException e){
			e.printStackTrace();
		}catch( IOException e){
			e.printStackTrace();
		}catch ( DAException e){
			e.printStackTrace();
		}catch ( Exception e){
			e.printStackTrace();
		}
		// 7. 끝
	}
	
	/**
	 * 1. 필요한 인자들의 기본값 세팅
	 */
	private void initialize(){
		
		// set filePath
		filePath = "D:\\sProject\\GIVUS\\modeling\\addressdata";
		//filePath = "file:WebContent/modeling/addressdata";
		
	}
	
	/**
	 * 2. 데이터 생성하기
	 */
	private void generator() throws IOException, FileNotFoundException, DAException, Exception{
		
		File files[] = readFiles();

		if ( files != null ){
			for (File file : files){

//				System.out.println(file.getName());
				setZipcodeData( file);
				StringBuffer message = new StringBuffer();
				//message.delete(0, message.length());
				message.append("[").append( fileCount).append( "] 번째 파일 [").append( file.getName()).append("]에서 [")
					.append( dataCount).append("] 개의 데이터를 생성하였습니다.\n");

				logger.info( message.toString());
			}
		}
	}
	/**
	 * 3. 파일 읽어오기(서울,경상도,경기도...)
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
	 * 4. 파일이 끝다면 다음 파일을 읽어 5,6,7 반복
	 */
	private void setZipcodeData( File file) throws IOException, FileNotFoundException, DAException, Exception{
		// 5. 해당 파일의 끝까지 6,7를 반복
		if ( file.isFile())	{
			fileCount += 1;
			dataCount = 0;
			StringBuffer message = new StringBuffer();
			message.append("[").append( fileCount).append( "] 번째 파일 [").append( file.getName()).append("]의 데이터 삽입 작업을 시작합니다.");
			logger.info( message.toString());
			setDataFromFile( file);
			totalDataCount += dataCount;			
		}
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
		int postalNo = 0; int city = 0;int siGunGu = 0; int eupMyun = 0; int roadName = 0; int basement = 0; int buildingNo = 0; int buildingSubNo = 0; int buildingMngNo = 0; 
		int buildingName = 0; int buildingName2 = 0; int dongCode = 0; int dongName = 0; int ri = 0; int san = 0; int zibunNo = 0; int zibunSubNo = 0; int eupMyungNo = 0;
		
		//ArrayList<ZipcodeModel> zipcodemodels = new ArrayList<ZipcodeModel>();
		ZipcodeModel zipcodemodel = new ZipcodeModel();
		while ( ( line = br.readLine()) != null){
			String datas[] = StringUtil.splitString( line, ZIPCODE_DATA_DELEMETER, true);
			int datalength = 0;
			if (datas.length > 1){
				if ( datas[0].equalsIgnoreCase("우편번호")){
					for ( String data : datas){
						// data 열 번호 저장
						if ( data.equalsIgnoreCase("우편일련번호")){ postalNo = datalength; 
						} else if ( data.equalsIgnoreCase("시도")){ city = datalength;
						} else if ( data.equalsIgnoreCase("시군구")){ siGunGu = datalength;
						} else if ( data.equalsIgnoreCase("읍면")){ eupMyun = datalength;
						} else if ( data.equalsIgnoreCase("도로명")){ roadName = datalength;
						} else if ( data.equalsIgnoreCase("지하여부")){ basement = datalength;
						} else if ( data.equalsIgnoreCase("건물번호본번")){ buildingNo = datalength;
						} else if ( data.equalsIgnoreCase("건물번호부번")){ buildingSubNo = datalength;
						} else if ( data.equalsIgnoreCase("건물관리번호")){ buildingMngNo = datalength;
						} else if ( data.equalsIgnoreCase("시군구용건물명")){ buildingName = datalength;
						} else if ( data.equalsIgnoreCase("다량배달처명")){ buildingName2 = datalength;
						} else if ( data.equalsIgnoreCase("법정동코드")){ dongCode = datalength;
						} else if ( data.equalsIgnoreCase("법정동명")){ dongName = datalength;
						} else if ( data.equalsIgnoreCase("리")){ ri = datalength;
						} else if ( data.equalsIgnoreCase("산여부")){ san = datalength;
						} else if ( data.equalsIgnoreCase("지번본번")){ zibunNo = datalength;
						} else if ( data.equalsIgnoreCase("지번부번")){ zibunSubNo = datalength;
						} else if ( data.equalsIgnoreCase("읍면동일련번호")){ eupMyungNo = datalength;}
						datalength++;
					}
				}
				else{
					// 6. 파일의 값 파싱후 dto에 담기
					if ( !datas[0].equalsIgnoreCase(""))
					{
						zipcodemodel.setName( datas[0]);
						zipcodemodel.setPostalCode( datas[0]);
						zipcodemodel.setPostalNo( datas[postalNo]);
						zipcodemodel.setCity(datas[city]);
						zipcodemodel.setSiGunGu( datas[siGunGu]);
						zipcodemodel.setEupMyun( datas[eupMyun]);
						zipcodemodel.setRoadName( datas[roadName]);
						zipcodemodel.setBasement( datas[basement]);
						zipcodemodel.setBuildingNo( ( datas[buildingNo] != null &&  datas[buildingNo].equals("")) ? Integer.parseInt( datas[buildingNo]) : 0);
						zipcodemodel.setBuildingSubNo( ( datas[buildingSubNo] != null && datas[buildingSubNo].equals("")) ? Integer.parseInt( datas[buildingSubNo]) : 0 );
						zipcodemodel.setBuildingMngNo( datas[buildingMngNo]);
						zipcodemodel.setBuildingName( datas[buildingName]);
						zipcodemodel.setBuildingName2( datas[buildingName2]);
						zipcodemodel.setDongCode( datas[dongCode]);
						zipcodemodel.setRi( datas[ri]);
						zipcodemodel.setSan( datas[san]);
						zipcodemodel.setZibunNo( ( datas[zibunNo] != null &&  datas[zibunNo].equals("")) ? Integer.parseInt( datas[zibunNo]) : 0);
						zipcodemodel.setZibunSubNo( ( datas[zibunSubNo] != null &&  datas[zibunSubNo].equals("")) ? Integer.parseInt( datas[zibunSubNo]) : 0);
						zipcodemodel.setEupMyungNo( datas[eupMyungNo]);
						
						zipcodemodel.setCreator("anonymous");
						zipcodemodel.setCreateDate( new Date());
						
						// 7. dto를 dao를 통해 db insert
						insertZipcode( zipcodemodel);
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
	public void insertZipcode( ZipcodeModel model) throws DAException{
		zipcodeService.create( model);
	}
}
