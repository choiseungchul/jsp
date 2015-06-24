/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.OperationPriceModel;
import kr.co.zadusoft.contents.service.CategoryService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.service.OperationPriceService;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.springframework.beans.factory.annotation.Autowired;

import dynamic.ibatis.util.SearchCondition;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;

public class GivusPriceExcelLoader extends ExcelHandlerBase
{
	final String BAR_DELEMETER = "|";
	final String relatedType = "operationprice";
	final int CELL_NO = 0;
	final int CELL_HOSPITAL_NAME = 1;
	final int CELL_HOMEPAGE = 2;
	final int CELL_TEL = 3;
	final int CELL_CITY = 4;
	final int CELL_GU = 5; 
	final int CELL_DONG = 6;
	final int CELL_EYE_MEMOL = 7;
	final int CELL_EYE_JEOLGAE = 8;
	final int CELL_EYE_YAPTUYIM = 9;
	final int CELL_EYE_DUITUYIM = 10;
	final int CELL_EYE_NUNME = 11;
	final int CELL_EYE_ANGUMHASU = 12;
	final int CELL_NOSE_GGUT = 13;
	final int CELL_NOSE_DAE = 14;
	final int CELL_NOSE_BOUL = 15;
	final int CELL_NOSE_MEBURI = 16;
	final int CELL_FACE_SAGAKTUK = 17;
	final int CELL_FACE_GANGDAE = 18;
	final int CELL_FACE_IMA = 19;
	final int CELL_BODY_BAE = 20;
	final int CELL_BODY_PAL = 21;
	final int CELL_BODY_HUBUKJI = 22;
	final int CELL_BODY_IMA = 23;
	final int CELL_BODY_HIPUP = 24;
	final int CELL_BREAST_KOJEL = 25;
	final int CELL_BREAST_MULBANGUL = 26;
	final int CELL_TOXIN_NUN = 27;
	final int CELL_TOXIN_PALZA = 28;
	final int CELL_TOXIN_IMA = 29;
	final int CELL_FILLER_KO = 30;
	final int CELL_FILLER_BOUL = 31;
	final int CELL_FILLER_IMA = 32;
	final int CELL_FILLER_TUK = 33;
	final int CELL_FILLER_PALZA = 34;
	
	HashMap< Integer, CategoryModel> map = new HashMap< Integer, CategoryModel>();
	
	@Autowired
	private OperationPriceService operationPriceService;

	@Autowired
	private HospitalService hospitalService;
	
	private CategoryService categoryService;
		
	private List<CodeModel> codemodels;
	
	private List<CategoryModel> categorymodels;
	
	public OperationPriceService getOperationPriceService() {
		return operationPriceService;
	}
	
	public void setOperationPriceService(OperationPriceService operationPrice) {
		this.operationPriceService = operationPrice;
	}

	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	public List<CodeModel> getCodemodels() {
		return codemodels;
	}

	public void setCodemodels(List<CodeModel> codemodels) {
		this.codemodels = codemodels;
	}
	
	
	public List<CategoryModel> getCategorymodels() {
		return categorymodels;
	}

	public void setCategorymodels(List<CategoryModel> categorymodels) {
		this.categorymodels = categorymodels;
	}

	@Override
	public void handleRow(XSSFRow row, int count) throws Exception {
		if( count == 0) return;
		XSSFCell cell = row.getCell( CELL_NO);
		String no = String.valueOf( getCellValue( cell));
		
		if ( getCellValue( cell) != null ){
			
			// 넘버링이 되어있지 않으면 operationPrice에 입력할 데이터가 아님
			if (  XSSFCell.CELL_TYPE_NUMERIC == cell.getCellType()) {
				String name = String.valueOf( row.getCell( CELL_HOSPITAL_NAME));
				
				HospitalModel hospitalmodel = existHospital( name);
				// 새로운 병원 데이터인 경우 병원정보부터 신규 생성후 아이디 이용, 키값은 병원명
				if ( hospitalmodel == null && name!= null && !name.equals("")){
					hospitalmodel = createHospital( row);
				}
 
				// 이미 있는 데이터인 경우 아이디 이용, 
				if ( hospitalmodel != null){
					OperationPriceModel pricemodel = new OperationPriceModel();
					XSSFCell priceCell;
					for( int i = CELL_EYE_MEMOL;  i <= CELL_FILLER_PALZA;i++){
						
						List<SearchCondition> conditions = new ArrayList<SearchCondition>();
						conditions.add( new SearchCondition( "hospitalId", hospitalmodel.getId()));

						conditions.add( new SearchCondition( "categoryId", map.get(i).getId()));
						pricemodel = (OperationPriceModel)operationPriceService.get( conditions);
						
						if ( pricemodel == null ) { 
							pricemodel = new OperationPriceModel();
						}
						pricemodel.setHospitalId( hospitalmodel.getId());
						pricemodel.setCategoryId( map.get(i).getId());
						pricemodel.setName( map.get(i).getName());
						
						priceCell = row.getCell( i);
						if ( XSSFCell.CELL_TYPE_NUMERIC == priceCell.getCellType())	{
							if ( getCellValue( cell) != null ) {
								long pricelong = (Long)getCellValue(priceCell);
								int price = (int)pricelong;
								
								pricemodel.setPrice( price * 10000);
							}else { 
								pricemodel.setPrice(0);
							}
						}else {
							pricemodel.setDescription(String.valueOf(priceCell));
						}
						
						// pricemodel이 hospitalId와 categoryid로 검색해 있으면 update, 없으면 create
						if( pricemodel.getId()>0){
							pricemodel.setUpdateDate( new Date());
							operationPriceService.update( pricemodel);
						} else {
							operationPriceService.create( pricemodel);
						}
					}
				}
					
				
			}
			// 카테고리 설정 - 처음 한번만 함
			// 선작업으로 카테고리 값 세팅 nodepath설정을 위함
			else if (  XSSFCell.CELL_TYPE_STRING == cell.getCellType() && no.equalsIgnoreCase("no")) {
				// 해당 카테고리가 존재하는지 체크
				if ( categorymodels != null && categorymodels.size()==(CELL_FILLER_PALZA-CELL_EYE_MEMOL)){
					
				}// else 
				if ( categorymodels.size() == 0){
					createCategories( row );
					categorymodels = (List<CategoryModel>)categoryService.search( new SearchCondition( "relatedType", "operationPrice"));
				}
				setMappingCellNCategory( row);
			}
		}
		// 엑셀의 병원명을 DB값과 비교후 없으면 삽입(insert), 있으면 수정(update)
		
		//6. excel 파일 읽기
		//7. excel 파일 파싱
		//8. 이미 있는 데이터인 경우 업데이트, 새로운 데이터인 경우 생성, 키값은 병원명	
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
	/**
	 * 없는 병원 정보를 새로 생성하기 위한 model 값 세팅
	 * @param row
	 * @return
	 * @throws DAException
	 */
	public HospitalModel createHospital( XSSFRow row) throws DAException{
		HospitalModel model = new HospitalModel();
		model.setName( String.valueOf( row.getCell( CELL_HOSPITAL_NAME)));
		model.setTel( String.valueOf( row.getCell( CELL_TEL)));
		
		StringBuffer address = new StringBuffer();
		address.append( String.valueOf( row.getCell( CELL_CITY))).append(" ")
			.append( String.valueOf( row.getCell( CELL_GU))).append(" ")
			.append( String.valueOf( row.getCell( CELL_DONG)));
		
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
		
		model.setHomepage( homepage);
		
		return createHospitalInfo( model);
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
	 * 시술부위 카테고리가 전무할 경우 생성
	 * @param row
	 * @throws DAException
	 */
	public void createCategories( XSSFRow row) throws DAException{
		//categorymodels.add(e)
		CategoryModel model = new CategoryModel();
		
		model.setRelatedType( relatedType);
		
		// root 생성
		model.setIsRootCategory( "Y");
		model.setName("시술항목");
		
		model = createCategory( model);
		StringBuffer nodePath = new StringBuffer();
		nodePath.append( model.getId()).append( BAR_DELEMETER);
		String rootNodePath = nodePath.toString();
		model.setNodePath(rootNodePath);
		updateCategory( model);
		//categorymodels.add( model);
		//상위카테고리 우선 생성 : 눈,코,안면윤곽...
		String mainCategories[] = StringUtil.splitString("눈|코|안면윤곽|체형|가슴확대|톡신|필러", BAR_DELEMETER);

		model.setRelatedType( relatedType);
		model.setIsRootCategory( "N");
		
		int sortOrder = 0;
		int rootId = model.getId();
		
		for ( String mainCategory : mainCategories){
			CategoryModel mainmodel = new CategoryModel();
			nodePath.delete(0, nodePath.length());
			mainmodel.setName(mainCategory);
			mainmodel.setSortOrder(sortOrder);
			sortOrder++;
			mainmodel.setParentId(rootId);
			mainmodel.setRelatedType( relatedType);
			nodePath.append( rootNodePath).append( mainmodel.getParentId()).append( BAR_DELEMETER);
			mainmodel.setNodePath( nodePath.toString());
			
			mainmodel = createCategory( mainmodel);
			categorymodels.add( mainmodel);
		}
		
		for ( CategoryModel mainmodel : categorymodels){
			
			if ( mainmodel.getName().equals("눈")){
				for ( int i = CELL_EYE_MEMOL; i <= CELL_EYE_ANGUMHASU; i++){
					if ( i == CELL_EYE_MEMOL) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("코")){
				for ( int i = CELL_NOSE_GGUT; i <= CELL_NOSE_MEBURI; i++){
					if ( i == CELL_NOSE_GGUT) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("안면윤곽")){
				for ( int i = CELL_FACE_SAGAKTUK; i <= CELL_FACE_IMA; i++){
					if ( i == CELL_FACE_SAGAKTUK) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("체형")){
				for ( int i = CELL_BODY_BAE; i <= CELL_BODY_HIPUP; i++){
					if ( i == CELL_BODY_BAE) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("가슴확대")){
				for ( int i = CELL_BREAST_KOJEL; i <= CELL_BREAST_MULBANGUL; i++){
					if ( i == CELL_BREAST_KOJEL) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("톡신")){
				for ( int i = CELL_TOXIN_NUN; i <= CELL_TOXIN_IMA; i++){
					if ( i == CELL_TOXIN_NUN) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
			else if ( mainmodel.getName().equals("필러")){
				for ( int i = CELL_FILLER_KO; i <= CELL_FILLER_PALZA; i++){
					if ( i == CELL_FILLER_KO) sortOrder = 0;
					setSubModel( i, row, new CategoryModel(), mainmodel, sortOrder);
					sortOrder++;
				}
			}
		}
		
		//return categorymodels;
	}
	
	private CategoryModel createCategory( CategoryModel model) throws DAException{
		return (CategoryModel)categoryService.create(model);
	}
	
	private void updateCategory( CategoryModel model) throws DAException{
		categoryService.update( model);
	}
	
	/**
	 * category가 없어 데이터를 신규 생성시에 model생성
	 * @param cellNo
	 * @param row
	 * @param submodel
	 * @param mainmodel
	 * @param sortOrder
	 * @return
	 * @throws DAException
	 */
	private CategoryModel setSubModel( int cellNo, XSSFRow row, CategoryModel submodel, CategoryModel mainmodel, int sortOrder)throws DAException{

		StringBuffer nodePath = new StringBuffer();
		submodel.setName(String.valueOf( row.getCell(cellNo)));
		submodel.setSortOrder(sortOrder);
		submodel.setParentId( mainmodel.getId());
		submodel.setRelatedType( relatedType);
		nodePath.append( mainmodel.getNodePath()).append( submodel.getParentId()).append( BAR_DELEMETER);
		submodel.setNodePath( nodePath.toString());
		submodel = createCategory( submodel);

//		categorymodels.add( submodel);
		return submodel;
	}
	
	/**
	 * 카테고리를 hashmap으로 cell번호와 매핑
	 * @param row
	 */
	private void setMappingCellNCategory( XSSFRow row){
		
		for ( CategoryModel categorymodel : categorymodels) {
			// 세부 시술항목만 매핑
			if( categorymodel.getNodePath().length() > 5){ 
			
				if ( categorymodel.getName().equals("매몰법")){map.put( CELL_EYE_MEMOL, categorymodel);}
				else if ( categorymodel.getName().equals("절개법")){map.put( CELL_EYE_JEOLGAE, categorymodel);}
				else if ( categorymodel.getName().equals("앞트임")){map.put( CELL_EYE_YAPTUYIM, categorymodel);}
				else if ( categorymodel.getName().equals("뒤트임")){map.put( CELL_EYE_DUITUYIM, categorymodel);}
				else if ( categorymodel.getName().equals("눈매교정")){map.put( CELL_EYE_NUNME, categorymodel);}
				
				// 시술명이 엑셀에서 엔터처리로 인식 안되는 문제로 contains로 변경
				else if ( categorymodel.getName().contains("안검하수") &&  categorymodel.getName().contains("교정술")){map.put( CELL_EYE_ANGUMHASU, categorymodel);}
				else if ( categorymodel.getName().equals("안검하수교정술")){map.put( CELL_EYE_ANGUMHASU, categorymodel);}
				else if ( categorymodel.getName().equals("코끝")){map.put( CELL_NOSE_GGUT, categorymodel);}
				else if ( categorymodel.getName().equals("코대")){map.put( CELL_NOSE_DAE, categorymodel);}
				else if ( categorymodel.getName().equals("코볼")){map.put( CELL_NOSE_BOUL, categorymodel);}
				else if ( categorymodel.getName().equals("매부리코")){map.put( CELL_NOSE_MEBURI, categorymodel);}
				
				else if ( categorymodel.getName().equals("사각턱")){map.put( CELL_FACE_SAGAKTUK, categorymodel);}
				else if ( categorymodel.getName().equals("광대")){map.put( CELL_FACE_GANGDAE, categorymodel);}
				else if ( categorymodel.getName().equals("이마확대")){map.put( CELL_FACE_IMA, categorymodel);}
				else if ( categorymodel.getName().contains("지방흡입") && categorymodel.getName().contains("(복부)")){map.put( CELL_BODY_BAE, categorymodel);}
				else if ( categorymodel.getName().contains("지방흡입") && categorymodel.getName().contains("(팔뚝)")){map.put( CELL_BODY_PAL, categorymodel);}
				
				else if ( categorymodel.getName().contains("지방흡입") && categorymodel.getName().contains("(허벅지)")){map.put( CELL_BODY_HUBUKJI, categorymodel);}
				else if ( categorymodel.getName().contains("지방삽입") && categorymodel.getName().contains("(이마)")){map.put( CELL_BODY_IMA, categorymodel);}
				else if ( categorymodel.getName().contains("지방삽입") && categorymodel.getName().contains("(힙업)")){map.put( CELL_BODY_HIPUP, categorymodel);}
				else if ( categorymodel.getName().equals("코젤")){map.put( CELL_BREAST_KOJEL, categorymodel);}
				else if ( categorymodel.getName().equals("물방울")){map.put( CELL_BREAST_MULBANGUL, categorymodel);}
				
				else if ( categorymodel.getName().equals("눈")){map.put( CELL_TOXIN_NUN, categorymodel);}
				else if ( categorymodel.getName().equals("팔자")){
					for ( CategoryModel model : categorymodels){
						if ( ( model.getId() == categorymodel.getParentId()) &&  model.getName().equals("톡신")){
							map.put( CELL_TOXIN_PALZA, categorymodel);
						}
						if ( ( model.getId() == categorymodel.getParentId()) &&  model.getName().equals("필러")){
							map.put( CELL_FILLER_PALZA, categorymodel);
						}
					}
				}
				else if ( categorymodel.getName().equals("이마")){
					for ( CategoryModel model : categorymodels){
						if ( ( model.getId() == categorymodel.getParentId()) &&  model.getName().equals("톡신")){
							map.put( CELL_TOXIN_IMA, categorymodel);
						}
						if ( ( model.getId() == categorymodel.getParentId()) &&  model.getName().equals("필러")){
							map.put( CELL_FILLER_IMA, categorymodel);
						}
					}
				}
				else if ( categorymodel.getName().equals("코")){map.put( CELL_FILLER_KO, categorymodel);}
				else if ( categorymodel.getName().equals("볼")){map.put( CELL_FILLER_BOUL, categorymodel);}
				else if ( categorymodel.getName().equals("턱")){map.put(  CELL_FILLER_TUK, categorymodel);}

			}
		}
	}
}
