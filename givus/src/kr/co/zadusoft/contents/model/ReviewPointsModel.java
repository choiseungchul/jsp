package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class ReviewPointsModel extends BaseModel {

	@DBField
	private Integer postingId;
	
	@DBField
	private String	gender;
	
	@DBField
	private Integer ageGroup;
	
	@DBField
	private Integer hospitalId;
	
	@DBField
	private Integer enoughDesc;
	
	@DBField
	private Integer considerNeeds;
	
	@DBField
	private Integer reaction;
	
	@DBField
	private Integer facilities;
	
	@DBField
	private Integer waitingTime;
	
	@DBField
	private Integer privacy;
	
	@DBField
	private Integer reliability;
	
	@DBField
	private Integer dealingWith;
	
	@DBField
	private Integer transportation;
	
	@DBField
	private Integer stress;
	
	@DBField
	private Integer afterSupport;
	
	@DBField
	private Integer amount;
	
	@DBField
	private Integer resultSatisfaction;
	

	public Integer getPostingId() {
		return postingId;
	}

	public void setPostingId(Integer postingId) {
		this.postingId = postingId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getAgeGroup() {
		return ageGroup;
	}

	public void setAgeGroup(Integer ageGroup) {
		this.ageGroup = ageGroup;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public Integer getEnoughDesc() {
		return enoughDesc;
	}

	public void setEnoughDesc(Integer enoughDesc) {
		this.enoughDesc = enoughDesc;
	}

	public Integer getConsiderNeeds() {
		return considerNeeds;
	}

	public void setConsiderNeeds(Integer considerNeeds) {
		this.considerNeeds = considerNeeds;
	}

	public Integer getReaction() {
		return reaction;
	}

	public void setReaction(Integer reaction) {
		this.reaction = reaction;
	}

	public Integer getFacilities() {
		return facilities;
	}

	public void setFacilities(Integer facilities) {
		this.facilities = facilities;
	}

	public Integer getWaitingTime() {
		return waitingTime;
	}

	public void setWaitingTime(Integer waitingTime) {
		this.waitingTime = waitingTime;
	}

	public Integer getPrivacy() {
		return privacy;
	}

	public void setPrivacy(Integer privacy) {
		this.privacy = privacy;
	}

	public Integer getReliability() {
		return reliability;
	}

	public void setReliability(Integer reliability) {
		this.reliability = reliability;
	}

	public Integer getDealingWith() {
		return dealingWith;
	}

	public void setDealingWith(Integer dealingWith) {
		this.dealingWith = dealingWith;
	}

	public Integer getTransportation() {
		return transportation;
	}

	public void setTransportation(Integer transportation) {
		this.transportation = transportation;
	}

	public Integer getStress() {
		return stress;
	}

	public void setStress(Integer stress) {
		this.stress = stress;
	}

	public Integer getAfterSupport() {
		return afterSupport;
	}

	public void setAfterSupport(Integer afterSupport) {
		this.afterSupport = afterSupport;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getResultSatisfaction() {
		return resultSatisfaction;
	}

	public void setResultSatisfaction(Integer resultSatisfaction) {
		this.resultSatisfaction = resultSatisfaction;
	}
	
	
}
