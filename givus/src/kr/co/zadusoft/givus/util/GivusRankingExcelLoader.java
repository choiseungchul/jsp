/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.Date;

import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.service.HospitalService;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;

import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;

public class GivusRankingExcelLoader extends ExcelHandlerBase {

	final int CELL_NO = 0;
	final int CELL_NAME = 1;
	final int CELL_TOTAL = 2;
	final int CELL_EXPERT = 3;
	final int CELL_SAFE = 4;
	final int CELL_SATISFY = 5;
	final int CELL_SIZE = 6;
	final int CELL_CONVENIENT = 7;
	final int CELL_GRADE = 8;
	
	private HospitalService hospitalService;
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	@Override
	public void handleRow(XSSFRow row, int count) throws DAException {
		// TODO Auto-generated method stub
		if( count == 0) return;
		XSSFCell cell = row.getCell( CELL_NO);
		//String no = String.valueOf( getCellValue( cell));
		XSSFCell cellName = row.getCell( CELL_NAME);

		// 넘버링이 되어있지 않으면 DB에 입력할 데이터가 아님, 병원명이 0이거나 공백이면 없는 값
		if ( getCellValue( cell) != null && ( XSSFCell.CELL_TYPE_NUMERIC == cell.getCellType())
				&& ( XSSFCell.CELL_TYPE_STRING == cellName.getCellType() || ( XSSFCell.CELL_TYPE_FORMULA == cellName.getCellType() && (cellName.getCachedFormulaResultType()!=0) ))
				&& ( !cellName.equals("")))
		{
			//String name = String.valueOf( row.getCell( CELL_NAME));
			String name = (String)getCellValue( row.getCell( CELL_NAME));
//			String name = row.getCell( CELL_NAME)).getNumericCellValue()
			
			HospitalModel model = existHospital( name);
			
			if ( model != null ) {
				model = setHospitalInfo( model, row);
				model.setUpdateDate( new Date());
				updateHospitalInfo(model);
				
			}else {
//				model = new HospitalModel();
				model = setHospitalInfo( new HospitalModel(), row);
				createHospitalInfo(model);
			}
		}
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
	/**
	 * 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
	 * @param model
	 * @return
	 * @throws DAException
	 */
	private HospitalModel createHospitalInfo( HospitalModel model) throws DAException{
		return (HospitalModel)hospitalService.create(model);
	}
	
	/**
	 * 엑셀의 병원랭킹 점수를 model에 세팅
	 * @param model
	 * @param row
	 * @return
	 */
	private HospitalModel setHospitalInfo( HospitalModel model, XSSFRow row){
		
		String name = (String)getCellValue( row.getCell( CELL_NAME));
		float totalPoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_TOTAL)).getNumericCellValue()));
		float expertPoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_EXPERT)).getNumericCellValue()));
		float safePoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_SAFE)).getNumericCellValue()));
		float satisfyPoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_SATISFY)).getNumericCellValue()));
		float sizePoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_SIZE)).getNumericCellValue()));
		float convenientPoint = Float.parseFloat( String.valueOf( ( row.getCell( CELL_CONVENIENT)).getNumericCellValue()));
		
		
		model.setName(name);
		model.setTotalPoint(totalPoint);
		model.setExpertPoint(expertPoint);
		model.setSafePoint(safePoint);
		model.setSatisfyPoint(satisfyPoint);
		model.setSizePoint(sizePoint);
		model.setConvenientPoint(convenientPoint);
		model.setGrade((String)getCellValue( row.getCell( CELL_GRADE)));
		
		return model;
	}
}
