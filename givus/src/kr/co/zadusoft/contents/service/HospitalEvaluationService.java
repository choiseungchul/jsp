/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.HospitalEvaluationDAO;
import kr.co.zadusoft.contents.model.HospitalEvaluationModel;
import kr.co.zadusoft.contents.model.ReviewPointsModel;
import kr.co.zadusoft.contents.model.UserModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class HospitalEvaluationService extends BaseService{
	private HospitalEvaluationDAO hospitalEvaluationDAO;
	
	private ReviewPointsService reviewPointsService;

	public ReviewPointsService getReviewPointsService() {
		return reviewPointsService;
	}

	public void setReviewPointsService(ReviewPointsService reviewPointsService) {
		this.reviewPointsService = reviewPointsService;
	}

	public HospitalEvaluationDAO getHospitalEvaluationDAO() {
		return hospitalEvaluationDAO;
	}

	public void setHospitalEvaluationDAO(HospitalEvaluationDAO hospitalEvaluationDAO) {
		this.hospitalEvaluationDAO = hospitalEvaluationDAO;
		setBaseDAO( hospitalEvaluationDAO);
	}
	
	
	public HospitalEvaluationModel setHospitalEvaluationWithReviewPoints( ReviewPointsModel reviewPointModel) throws DAException{
		HospitalEvaluationModel hospitalEvaluationModel = (HospitalEvaluationModel) get( new SearchCondition( "hospitalId", reviewPointModel.getHospitalId()));
		
		if ( hospitalEvaluationModel == null){
			hospitalEvaluationModel = new HospitalEvaluationModel();
			hospitalEvaluationModel.setHospitalId( reviewPointModel.getHospitalId());
		}
		//평균값 계산하기
		int mean = reviewPointsService.getMean( reviewPointModel);
		
		System.out.println( "mean =" + mean);
		if ( mean > 4){
			if ( hospitalEvaluationModel.getPoint5() == null ) hospitalEvaluationModel.setPoint5(0);
			hospitalEvaluationModel.setPoint5( hospitalEvaluationModel.getPoint5() + 1);
		}else if ( mean > 3){
			if ( hospitalEvaluationModel.getPoint4() == null ) hospitalEvaluationModel.setPoint4(0);
			hospitalEvaluationModel.setPoint4( hospitalEvaluationModel.getPoint4() + 1);
		}else if ( mean > 2){
			if ( hospitalEvaluationModel.getPoint3() == null ) hospitalEvaluationModel.setPoint3(0);
			hospitalEvaluationModel.setPoint3( hospitalEvaluationModel.getPoint3() + 1);
		}else if ( mean > 1){
			if ( hospitalEvaluationModel.getPoint2() == null ) hospitalEvaluationModel.setPoint2(0);
			hospitalEvaluationModel.setPoint2( hospitalEvaluationModel.getPoint2() + 1);
		}else{
			if ( hospitalEvaluationModel.getPoint1() == null ) hospitalEvaluationModel.setPoint1(0);
			hospitalEvaluationModel.setPoint1( hospitalEvaluationModel.getPoint1() + 1);
		}
		
		// 로그인하지 않으면 남성으로 체크됨
		if (reviewPointModel.getGender().equals(UserModel.USER_GENDER_FEMALE)){
			if ( hospitalEvaluationModel.getWomanCount() == null ) hospitalEvaluationModel.setWomanCount(0);
			hospitalEvaluationModel.setWomanCount(hospitalEvaluationModel.getWomanCount() + 1);
		}else{
			if ( hospitalEvaluationModel.getManCount() == null ) hospitalEvaluationModel.setManCount(0);
			hospitalEvaluationModel.setManCount(hospitalEvaluationModel.getManCount() + 1);
		}
		
		if (reviewPointModel.getAgeGroup() == 10){
			if ( hospitalEvaluationModel.getGeneration10() == null ) hospitalEvaluationModel.setGeneration10(0);
			hospitalEvaluationModel.setGeneration10(hospitalEvaluationModel.getGeneration10() + 1);
		} else if (reviewPointModel.getAgeGroup() == 20){
			if ( hospitalEvaluationModel.getGeneration20() == null ) hospitalEvaluationModel.setGeneration20(0);
			hospitalEvaluationModel.setGeneration20(hospitalEvaluationModel.getGeneration20() + 1);
		} else if (reviewPointModel.getAgeGroup() == 30){
			if ( hospitalEvaluationModel.getGeneration30() == null ) hospitalEvaluationModel.setGeneration30(0);
			hospitalEvaluationModel.setGeneration30(hospitalEvaluationModel.getGeneration30() + 1);
		} else if (reviewPointModel.getAgeGroup() >= 40){
			if ( hospitalEvaluationModel.getGeneration40() == null ) hospitalEvaluationModel.setGeneration40(0);
			hospitalEvaluationModel.setGeneration40(hospitalEvaluationModel.getGeneration40() + 1);
		}
		
		return hospitalEvaluationModel;
	}
}
