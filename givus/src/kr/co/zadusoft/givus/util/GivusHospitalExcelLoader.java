/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.Date;
import java.util.List;

import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.HospitalStatsModel;
import kr.co.zadusoft.contents.service.CodeService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.service.HospitalStatsService;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dynamic.ibatis.util.DBField;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class GivusHospitalExcelLoader extends ExcelHandlerBase
{
	final String COMMA_DELEMETER = ",";
	final int CELL_NO = 0;
	final int CELL_NAME = 1;
	final int CELL_HOMEPAGE = 2;
	final int CELL_TEL = 3;
	final int CELL_CITY = 4;
	final int CELL_GU = 5;
	final int CELL_DONG = 6;
	final int CELL_DETAIL_ADDRESS = 7;
	final int CELL_INTRODUCTION = 8;
	final int CELL_MOST_OPERATION_1 = 9;
	final int CELL_MOST_OPERATION_2 = 10;
	final int CELL_PATIENT_ROOM = 11;
	final int CELL_RECOVERY_ROOM = 12;
	final int CELL_INTERPRETER = 13;
	final int CELL_PICKUP_SERVICE = 14;
	final int CELL_SPECIALIST = 15;
	final int CELL_ANESTHETIC = 16;
	final int CELL_SCALE = 17;
	final int CELL_COUNSEL_COUNT = 18;
	final int CELL_REVIEW_PIC_COUNT = 19;
	final int CELL_FOREIGNER_REGISTER = 20;
	final int CELL_POSSIBLE_SURGERY = 21;
	final int CELL_HOURS = 22;
	final int CELL_FAX = 23;
	
	@Autowired
	private HospitalService hospitalService;
	
	private CodeService codeService;
	
	private List<CodeModel> codemodels;
	
	private HospitalStatsService hospitalStatsService;
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public CodeService getCodeService() {
		return codeService;
	}

	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	public List<CodeModel> getCodemodels() {
		return codemodels;
	}

	public void setCodemodels(List<CodeModel> codemodels) {
		this.codemodels = codemodels;
	}

	public HospitalStatsService getHospitalStatsService() {
		return hospitalStatsService;
	}

	public void setHospitalStatsService(HospitalStatsService hospitalStatsService) {
		this.hospitalStatsService = hospitalStatsService;
	}

	@Override
	public void handleRow(XSSFRow row, int count) throws DAException {
		if( count == 0) return;
		XSSFCell cell = row.getCell( CELL_NO);
		String no = String.valueOf( getCellValue( cell));
		// 넘버링이 되어있지 않으면 DB에 입력할 데이터가 아님
		if ( getCellValue( cell) != null && ( XSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()))
		{
			String name = String.valueOf( row.getCell( CELL_NAME));
			
			HospitalModel model = existHospital( name);
			HospitalStatsModel statsmodel;
			// 8. 이미 있는 데이터인 경우 업데이트, 새로운 데이터인 경우 생성, 키값은 병원명
			if ( model != null) {
				statsmodel = (HospitalStatsModel)hospitalStatsService.get( new SearchCondition( "hospitalId", model.getId()));
				if ( statsmodel == null) { statsmodel = new HospitalStatsModel();}
				statsmodel = setHospitalStatsModel( row, statsmodel);
				model = setHospitalModel( row, model, statsmodel);
				model.setUpdateDate( new Date());
				updateHospitalInfo( model);
			}
			else {
				statsmodel = new HospitalStatsModel();
				model = setHospitalModel( row, new HospitalModel(), statsmodel);
				model.setName(name);
				model = createHospitalInfo( model);
			}
			// 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
			statsmodel.setHospitalId( model.getId());
			if ( statsmodel.getId() == 0){
				createHospitalStats( statsmodel);
			}
			else{
				updateHospitalStats(statsmodel);
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
		return (HospitalModel)hospitalService.get( new SearchCondition( "name", name) );
	}
	
	
	private HospitalStatsModel setHospitalStatsModel( XSSFRow row, HospitalStatsModel statsmodel){
		String specialist =  String.valueOf( row.getCell( CELL_SPECIALIST));
		String datas[] = StringUtil.splitString( specialist, COMMA_DELEMETER, false);
		
		for ( String data :datas){
			if ( data.contains("(구)")) {
				String temp[] = StringUtil.splitString( data, "명(구)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setOralDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(치)")) {
				String temp[] = StringUtil.splitString( data, "명(치)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setDentalDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(유)")) {
				String temp[] = StringUtil.splitString( data, "명(유)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setBreastDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(교)")) {
				String temp[] = StringUtil.splitString( data, "명(교)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setOrthodonticDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(이)")) {
				String temp[] = StringUtil.splitString( data, "명(이)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setOtolaryngologyDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(외)")) {
				String temp[] = StringUtil.splitString( data, "명(외)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setSurgeryDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(성)")) {
				String temp[] = StringUtil.splitString( data, "명(성)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setPlasticSurgeryDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(마)")) {
				String temp[] = StringUtil.splitString( data, "명(마)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setAnestheticDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(가)")) {
				String temp[] = StringUtil.splitString( data, "명(가)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setFamilyMedicineDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(일)")) {
				String temp[] = StringUtil.splitString( data, "명(일)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setGeneralDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(임)")) {
				String temp[] = StringUtil.splitString( data, "명(임)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setClinicalDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(비)")) {
				String temp[] = StringUtil.splitString( data, "명(비)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setObesityDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(피)")) {
				String temp[] = StringUtil.splitString( data, "명(피)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setDermatologistDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(보)")) {
				String temp[] = StringUtil.splitString( data, "명(보)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setProstheticDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(임플)")) {
				String temp[] = StringUtil.splitString( data, "명(임플)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setImplantsDoctorCount(Integer.parseInt( temp[0]));
			}
			if ( data.contains("(산)")) {
				String temp[] = StringUtil.splitString( data, "명(산)", false);
				if ( StringUtils.isNumeric(temp[0]))
					statsmodel.setObstetricsDoctorCount( Integer.parseInt( temp[0]));
			}
		}
		
		statsmodel.setTotalDoctorsCount();
		return statsmodel;
	}
	
	private HospitalModel setHospitalModel( XSSFRow row, HospitalModel model, HospitalStatsModel statsmodel){
		model.setTel( String.valueOf( row.getCell( CELL_TEL)));
		
		StringBuffer address = new StringBuffer();
		address.append( String.valueOf( row.getCell( CELL_CITY))).append(" ")
			.append( String.valueOf( row.getCell( CELL_GU))).append(" ")
			.append( String.valueOf( row.getCell( CELL_DONG))).append(" ")
			.append( String.valueOf( row.getCell( CELL_DETAIL_ADDRESS)));
		
		model.setAddress(address.toString());
		for ( CodeModel codemodel : codemodels){
			if ( ( String.valueOf( row.getCell( CELL_CITY))).contains(codemodel.getName())){
				model.setLocationCode( codemodel.getCode());
			}
		}
		
		String homepage = String.valueOf( row.getCell( CELL_HOMEPAGE));
		if ( homepage!= null && !homepage.contains( "http://")){
			homepage = new StringBuffer().append("http://").append(homepage).toString();
		}
		
		model.setIntroduction( String.valueOf( row.getCell( CELL_INTRODUCTION)));
		model.setHomepage( homepage);
		model.setPatientRoom( String.valueOf( row.getCell( CELL_PATIENT_ROOM)));
		model.setRecoveryRoom( String.valueOf( row.getCell( CELL_RECOVERY_ROOM)));
		model.setInterpreter( String.valueOf( row.getCell( CELL_INTERPRETER)));
		model.setPickupService( String.valueOf( row.getCell( CELL_PICKUP_SERVICE)));
		model.setMostOperation1( String.valueOf( row.getCell( CELL_MOST_OPERATION_1)));
		model.setMostOperation2( String.valueOf( row.getCell( CELL_MOST_OPERATION_2)));
		model.setScale( String.valueOf( row.getCell( CELL_SCALE)));
		
		System.out.println("model="+ model);
		XSSFCell cell_counselCount = row.getCell( CELL_COUNSEL_COUNT);

		int counselCount = ( cell_counselCount != null && XSSFCell.CELL_TYPE_NUMERIC == cell_counselCount.getCellType() && XSSFCell.CELL_TYPE_ERROR != cell_counselCount.getCellType()) ?  (int)cell_counselCount.getNumericCellValue(): 0;

		model.setCounselCount( counselCount);
		
		XSSFCell cell_reviewPicCount = row.getCell( CELL_REVIEW_PIC_COUNT);
		int reviewPicCount = ( cell_reviewPicCount != null && XSSFCell.CELL_TYPE_NUMERIC == cell_reviewPicCount.getCellType() ) ? (int)cell_reviewPicCount.getNumericCellValue() :0;

		model.setReviewPicCount(reviewPicCount);
		
		model.setForeignerReg( String.valueOf( row.getCell( CELL_FOREIGNER_REGISTER)));
		model.setPossibleSurgery( (String)getCellValue( row.getCell( CELL_POSSIBLE_SURGERY)));
		model.setHours( String.valueOf( row.getCell( CELL_HOURS)));
		model.setFax( String.valueOf( row.getCell( CELL_FAX)));
		
		// 전문의 수, 마취의수 추가
		
		model.setAnestheticCount(statsmodel.getAnestheticDoctorCount());
		model.setSpecialistCount(statsmodel.getTotalDoctorsCount());
		
		return model;
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
	 * 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
	 * @param model
	 * @throws DAException
	 */
	private void updateHospitalStats( HospitalStatsModel model) throws DAException{
		hospitalStatsService.update(model);
	}
	/**
	 * 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
	 * @param model
	 * @return
	 * @throws DAException
	 */
	private HospitalStatsModel createHospitalStats( HospitalStatsModel model) throws DAException{
		return (HospitalStatsModel)hospitalStatsService.create(model);
	}
}
