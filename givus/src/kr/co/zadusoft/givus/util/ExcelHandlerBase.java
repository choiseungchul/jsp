/**
 * Copyright (c) 2011, SIN SHIN CHEMICAL IND. CO. LTD
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import dynamic.util.StringUtil;
import dynamic.web.model.User;

public abstract class ExcelHandlerBase
{
	Logger logger = LogManager.getLogger( ExcelHandlerBase.class);
	
	/**
	 * EXCEL 파일의 위치
	 */
	private String filePath;
	
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	/**
	 * Excel 파일을 읽어들여서 각 행을 처리하도록 하는 handleRow 메소드를 호출한다.
	 * @throws Exception
	 */
	public void start() throws Exception{
		setUserContext();
		
		if( logger.isDebugEnabled()){
			logger.debug( "Load File : " + filePath + " ...");
		}
		
		InputStream inputStream = new FileInputStream( filePath);
		XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
		XSSFSheet sheet = workbook.getSheetAt( 0);
		int rows = sheet.getPhysicalNumberOfRows();
		
		if( logger.isDebugEnabled()){
			logger.debug( "Start Handle Data");
		}
		
		for( int i=0; i<rows; i++) // rows
		{
			if( logger.isDebugEnabled()){
				logger.debug( i + ".ROW");
			}
			
			XSSFRow row = sheet.getRow( i);
			handleRow( row, i);
		}
		
		postProcess();
	}
	
	/**
	 * Excel 파일의 각 ROW 를 처리하는 메소드
	 * @param row
	 * @param rowNum 엑셀 파일에서 행 넘버 0 부터 시작한다.
	 * @throws Exception
	 */
	public abstract void handleRow( XSSFRow row, int rowNum) throws Exception;
	
	public void postProcess() throws Exception{
		
	}
	
	protected void setUserContext() throws Exception{
		if( dynamic.util.UserContext.getUser() == null){
			User user = new User();
			user.setAccount( "system");
			dynamic.util.UserContext.setUser( user);
		}
	}
	
	/**
	 * CELL 의 값을 읽어온다.
	 * @param cell
	 * @return
	 */
	protected Object getCellValue( XSSFCell cell){
		if( cell == null) return null;
		if( XSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()){
			long value = (long)cell.getNumericCellValue();
			return new Long( value);
		}else if( XSSFCell.CELL_TYPE_STRING == cell.getCellType()){
			String value = cell.getStringCellValue();
			return value != null ? StringUtil.replace( value, " ", "").trim() : value;
		}
		String data = cell.getStringCellValue();
		return StringUtil.isNotNull( data) ? data.trim() : null; 
	}
}
