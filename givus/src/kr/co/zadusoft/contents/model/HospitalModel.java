/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class HospitalModel extends ManagedBaseModel{
	
	@DBField
	private String tel;
	
	@DBField
	private String address;
	
	@DBField
	private String locationCode;
	
	@DBField
	private String introduction;
	
	@DBField
	private String recommendNote;
	
	@DBField
	private Integer specialistCount;
	
	@DBField
	private Integer anestheticCount;
	
	@DBField
	private Integer annualOperationCount;
	
	@DBField
	private Float totalPoint;
	
	@DBField
	private Float expertPoint;
	
	@DBField
	private Float safePoint;
	
	@DBField
	private Float satisfyPoint;
	
	@DBField
	private Float sizePoint;
	
	@DBField
	private Float convenientPoint;
	
	@DBField
	private Integer postOperationBoardId;

	@DBField
	private Date establishDate;
	
	@DBField
	private String homepage;
	
	@DBField
	private String grade;
	
	@DBField
	private String patientRoom;
	
	@DBField
	private String recoveryRoom;
	
	@DBField
	private String interpreter;
	
	@DBField
	private String pickupService;
	
	@DBField
	private String mostOperation1;
	
	@DBField
	private String mostOperation2;
	
	@DBField
	private Integer viewCount;
	
	/** 병원크기 */
	@DBField
	private String scale; 
	
	/** 온라인상담수 */
	@DBField
	private Integer counselCount; 

	/** 전후사진수 */
	@DBField
	private Integer reviewPicCount;
	
	/** 외국인 유치 등록여부 */
	@DBField
	private String foreignerReg;
	
	/** 가능수술 */
	@DBField
	private String possibleSurgery;
	
	/** 진료시간 */
	@DBField
	private String hours;
	
	/** 팩스 */
	@DBField
	private String fax;
	
	@DBField	
	private Integer ranking;
	
	/**부위별 점수*/
	@DBField
	private Float eyePoint;
	@DBField
	private Float nosePoint;
	@DBField
	private Float facePoint;
	@DBField
	private Float breastPoint;
	@DBField
	private Float bodyPoint;
	@DBField
	private Float petitPoint;
	
	private Integer thumbFileId;
	
	private HospitalStatsModel hospitalStatsModel;

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLocationCode() {
		return locationCode;
	}

	public void setLocationCode(String locationCode) {
		this.locationCode = locationCode;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getRecommendNote() {
		return recommendNote;
	}

	public void setRecommendNote(String recommendNote) {
		this.recommendNote = recommendNote;
	}

	public Integer getSpecialistCount() {
		return specialistCount;
	}

	public void setSpecialistCount(Integer specialistCount) {
		this.specialistCount = specialistCount;
	}

	public Integer getAnestheticCount() {
		return anestheticCount;
	}

	public void setAnestheticCount(Integer anestheticCount) {
		this.anestheticCount = anestheticCount;
	}

	public Integer getAnnualOperationCount() {
		return annualOperationCount;
	}

	public void setAnnualOperationCount(Integer annualOperationCount) {
		this.annualOperationCount = annualOperationCount;
	}

	public Float getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(Float totalPoint) {
		this.totalPoint = totalPoint;
	}

	public Float getExpertPoint() {
		return expertPoint;
	}

	public void setExpertPoint(Float expertPoint) {
		this.expertPoint = expertPoint;
	}

	public Float getSafePoint() {
		return safePoint;
	}

	public void setSafePoint(Float safePoint) {
		this.safePoint = safePoint;
	}

	public Float getSatisfyPoint() {
		return satisfyPoint;
	}

	public void setSatisfyPoint(Float satisfyPoint) {
		this.satisfyPoint = satisfyPoint;
	}

	public Float getSizePoint() {
		return sizePoint;
	}

	public void setSizePoint(Float sizePoint) {
		this.sizePoint = sizePoint;
	}

	public Float getConvenientPoint() {
		return convenientPoint;
	}

	public void setConvenientPoint(Float convenientPoint) {
		this.convenientPoint = convenientPoint;
	}

	public Integer getPostOperationBoardId() {
		return postOperationBoardId;
	}

	public void setPostOperationBoardId(Integer postOperationBoardId) {
		this.postOperationBoardId = postOperationBoardId;
	}

	public Date getEstablishDate() {
		return establishDate;
	}

	public void setEstablishDate(Date establishDate) {
		this.establishDate = establishDate;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getPatientRoom() {
		return patientRoom;
	}

	public void setPatientRoom(String patientRoom) {
		this.patientRoom = patientRoom;
	}

	public String getRecoveryRoom() {
		return recoveryRoom;
	}

	public void setRecoveryRoom(String recoveryRoom) {
		this.recoveryRoom = recoveryRoom;
	}

	public String getInterpreter() {
		return interpreter;
	}

	public void setInterpreter(String interpreter) {
		this.interpreter = interpreter;
	}

	public String getPickupService() {
		return pickupService;
	}

	public void setPickupService(String pickupService) {
		this.pickupService = pickupService;
	}

	public String getMostOperation1() {
		return mostOperation1;
	}

	public void setMostOperation1(String mostOperation1) {
		this.mostOperation1 = mostOperation1;
	}

	public String getMostOperation2() {
		return mostOperation2;
	}

	public void setMostOperation2(String mostOperation2) {
		this.mostOperation2 = mostOperation2;
	}

	public Integer getRanking() {
		return ranking;
	}

	public void setRanking(Integer ranking) {
		this.ranking = ranking;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public String getScale() {
		return scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public Integer getCounselCount() {
		return counselCount;
	}

	public void setCounselCount(Integer counselCount) {
		this.counselCount = counselCount;
	}

	public Integer getReviewPicCount() {
		return reviewPicCount;
	}

	public void setReviewPicCount(Integer reviewPicCount) {
		this.reviewPicCount = reviewPicCount;
	}

	public String getForeignerReg() {
		return foreignerReg;
	}

	public void setForeignerReg(String foreignerReg) {
		this.foreignerReg = foreignerReg;
	}

	public String getPossibleSurgery() {
		return possibleSurgery;
	}

	public void setPossibleSurgery(String possibleSurgery) {
		this.possibleSurgery = possibleSurgery;
	}

	public String getHours() {
		return hours;
	}

	public void setHours(String hours) {
		this.hours = hours;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public Float getEyePoint() {
		return eyePoint;
	}

	public void setEyePoint(Float eyePoint) {
		this.eyePoint = eyePoint;
	}

	public Float getNosePoint() {
		return nosePoint;
	}

	public void setNosePoint(Float nosePoint) {
		this.nosePoint = nosePoint;
	}

	public Float getFacePoint() {
		return facePoint;
	}

	public void setFacePoint(Float facePoint) {
		this.facePoint = facePoint;
	}

	public Float getBreastPoint() {
		return breastPoint;
	}

	public void setBreastPoint(Float breastPoint) {
		this.breastPoint = breastPoint;
	}

	public Float getBodyPoint() {
		return bodyPoint;
	}

	public void setBodyPoint(Float bodyPoint) {
		this.bodyPoint = bodyPoint;
	}

	public Float getPetitPoint() {
		return petitPoint;
	}

	public void setPetitPoint(Float petitPoint) {
		this.petitPoint = petitPoint;
	}

	public Integer getThumbFileId() {
		return thumbFileId;
	}

	public void setThumbFileId(Integer thumbFileId) {
		this.thumbFileId = thumbFileId;
	}

	public HospitalStatsModel getHospitalStatsModel() {
		return hospitalStatsModel;
	}

	public void setHospitalStatsModel(HospitalStatsModel hospitalStatsModel) {
		this.hospitalStatsModel = hospitalStatsModel;
	}

}
