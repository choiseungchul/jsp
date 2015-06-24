/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class RankingDataModel extends ManagedBaseModel{

	@DBField
	private Integer ranking;
	
	@DBField
	private String grade;
	
	@DBField
	private Double totalPoint;
	
	@DBField
	private Double expertPoint;
	
	@DBField
	private Double safePoint;
	
	@DBField
	private Double satisfyPoint;
	
	@DBField
	private Double sizePoint;
	
	@DBField
	private Double convinientPoint;
	
	@DBField
	private Integer hospitalId;
	
	@DBField
	private Integer rankingId;
	
	@DBField
	private Integer rankingChange;
	
	/**부위별 점수*/
	@DBField
	private Double eyePoint;
	@DBField
	private Double nosePoint;
	@DBField
	private Double facePoint;
	@DBField
	private Double breastPoint;
	@DBField
	private Double bodyPoint;
	@DBField
	private Double petitPoint;

	private HospitalModel hospitalModel;
	
	private String hospitalName;
	
	public Integer getRanking() {
		return ranking;
	}

	public void setRanking(Integer ranking) {
		this.ranking = ranking;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public Double getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(Double totalPoint) {
		this.totalPoint = totalPoint;
	}

	public Double getExpertPoint() {
		return expertPoint;
	}

	public void setExpertPoint(Double expertPoint) {
		this.expertPoint = expertPoint;
	}

	public Double getSafePoint() {
		return safePoint;
	}

	public void setSafePoint(Double safePoint) {
		this.safePoint = safePoint;
	}

	public Double getSatisfyPoint() {
		return satisfyPoint;
	}

	public void setSatisfyPoint(Double satisfyPoint) {
		this.satisfyPoint = satisfyPoint;
	}

	public Double getSizePoint() {
		return sizePoint;
	}

	public void setSizePoint(Double sizePoint) {
		this.sizePoint = sizePoint;
	}

	public Double getConvinientPoint() {
		return convinientPoint;
	}

	public void setConvinientPoint(Double convinientPoint) {
		this.convinientPoint = convinientPoint;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public Integer getRankingId() {
		return rankingId;
	}

	public void setRankingId(Integer rankingId) {
		this.rankingId = rankingId;
	}

	public HospitalModel getHospitalModel() {
		return hospitalModel;
	}

	public Double getEyePoint() {
		return eyePoint;
	}

	public void setEyePoint(Double eyePoint) {
		this.eyePoint = eyePoint;
	}

	public Double getNosePoint() {
		return nosePoint;
	}

	public void setNosePoint(Double nosePoint) {
		this.nosePoint = nosePoint;
	}

	public Double getFacePoint() {
		return facePoint;
	}

	public void setFacePoint(Double facePoint) {
		this.facePoint = facePoint;
	}

	public Double getBreastPoint() {
		return breastPoint;
	}

	public void setBreastPoint(Double breastPoint) {
		this.breastPoint = breastPoint;
	}

	public Double getBodyPoint() {
		return bodyPoint;
	}

	public void setBodyPoint(Double bodyPoint) {
		this.bodyPoint = bodyPoint;
	}

	public Double getPetitPoint() {
		return petitPoint;
	}

	public void setPetitPoint(Double petitPoint) {
		this.petitPoint = petitPoint;
	}

	public void setHospitalModel(HospitalModel hospitalModel) {
		this.hospitalModel = hospitalModel;
	}

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public Integer getRankingChange() {
		return rankingChange;
	}

	public void setRankingChange(Integer rankingChange) {
		this.rankingChange = rankingChange;
	}
}
