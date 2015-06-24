package kr.co.zadusoft.givus.util;

import java.util.Date;

import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.service.HospitalService;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;

import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;

public class GivusPartialRankingExcelLoader extends ExcelHandlerBase {
	
	final int CELL_NAME = 0;
	final int CELL_EYE_POINT = 1;
	final int CELL_NOSE_POINT = 2;
	final int CELL_FACE_POINT = 3;
	final int CELL_BREAST_POINT = 4;
	final int CELL_BODY_POINT = 5;
	final int CELL_PETIT_POINT = 6;

	
	private HospitalService hospitalService;
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	@Override
	public void handleRow(XSSFRow row, int rowNum) throws Exception {
		// TODO Auto-generated method stub
		if( rowNum == 0) return;
		
		XSSFCell cellName = row.getCell( CELL_NAME);
		
		// 넘버링이 되어있지 않으면 DB에 입력할 데이터가 아님, 병원명이 0이거나 공백이면 없는 값
		if (  ( XSSFCell.CELL_TYPE_STRING == cellName.getCellType() || ( XSSFCell.CELL_TYPE_FORMULA == cellName.getCellType() && (cellName.getCachedFormulaResultType()!=0) ))
				&& ( !cellName.equals(""))&& ( !cellName.equals("병원명")))
		{
			//String name = String.valueOf( row.getCell( CELL_NAME));
			String name = (String)getCellValue( row.getCell( CELL_NAME));
//			String name = row.getCell( CELL_NAME)).getNumericCellValue()
			HospitalModel model = existHospital( name);
			
			if ( model != null ) {
				model = setHospitalInfo( model, row);
				model.setUpdateDate( new Date());
				updateHospitalInfo(model);
				
			}
		}
	}
	
	/**
	 * 엑셀의 병원랭킹 점수를 model에 세팅
	 * @param model
	 * @param row
	 * @return
	 */
	private HospitalModel setHospitalInfo( HospitalModel model, XSSFRow row){
		
		//String name = (String)getCellValue( row.getCell( CELL_NAME));
		float eyePoint = ( row.getCell( CELL_EYE_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_EYE_POINT)).getNumericCellValue()));
		float nosePoint = ( row.getCell( CELL_NOSE_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_NOSE_POINT)).getNumericCellValue()));
		float facePoint = ( row.getCell( CELL_FACE_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_FACE_POINT)).getNumericCellValue()));
		float breastPoint = ( row.getCell( CELL_BREAST_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_BREAST_POINT)).getNumericCellValue()));
		float bodyPoint = ( row.getCell( CELL_BODY_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_BODY_POINT)).getNumericCellValue()));
		float petitPoint = ( row.getCell( CELL_PETIT_POINT)==null)? 0 : Float.parseFloat( String.valueOf( ( row.getCell( CELL_PETIT_POINT)).getNumericCellValue()));
		
		//model.setName(name);
		if ( eyePoint != 0) model.setEyePoint(eyePoint);
		if ( nosePoint != 0) model.setNosePoint(nosePoint);
		if ( facePoint != 0) model.setFacePoint(facePoint);
		if ( breastPoint != 0) model.setBreastPoint(breastPoint);
		if ( bodyPoint != 0) model.setBodyPoint(bodyPoint);
		if ( petitPoint != 0) model.setPetitPoint(petitPoint);
		
		
		
		return model;
	}
	/**
	 * 엑셀의 병원명을 DB값과 비교
	 * @param name
	 * @return 
	 * @throws Exception
	 */
	public HospitalModel existHospital( String name) throws DAException{
		System.out.println("name=" + name);
		return (HospitalModel)hospitalService.get( new SearchCondition( "name", name) );
	}
	
	/**
	 * 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
	 * @param model
	 * @throws DAException
	 */
	private void updateHospitalInfo( HospitalModel model) throws DAException{
		hospitalService.update(model);
	}
}
