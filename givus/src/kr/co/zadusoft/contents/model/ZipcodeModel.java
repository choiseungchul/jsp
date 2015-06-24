/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.web.model.ManagedBaseModel;
import dynamic.ibatis.util.DBField;

public class ZipcodeModel extends ManagedBaseModel {

	@DBField
	private String postalCode;
	@DBField 
	private String  postalNo;
	@DBField 
	private String  city;
	@DBField	
	private String  siGunGu;
	@DBField	
	private String  eupMyun;
	@DBField	
	private String  roadName;
	@DBField	
	private String  basement;
	@DBField	
	private Integer  buildingNo;
	@DBField	
	private Integer  buildingSubNo;
	@DBField	
	private String  buildingMngNo;
	@DBField	
	private String  buildingName;
	@DBField	
	private String  buildingName2;
	@DBField	
	private String  dongCode;
	@DBField	
	private String  dongName;
	@DBField	
	private String  ri;
	@DBField	
	private String  san;
	@DBField	
	private Integer  zibunNo;
	@DBField	
	private Integer  zibunSubNo;
	@DBField	
	private String  eupMyungNo;
	
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getPostalNo() {
		return postalNo;
	}
	public void setPostalNo(String postalNo) {
		this.postalNo = postalNo;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getSiGunGu() {
		return siGunGu;
	}
	public void setSiGunGu(String siGunGu) {
		this.siGunGu = siGunGu;
	}
	public String getEupMyun() {
		return eupMyun;
	}
	public void setEupMyun(String eupMyun) {
		this.eupMyun = eupMyun;
	}
	public String getRoadName() {
		return roadName;
	}
	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	public String getBasement() {
		return basement;
	}
	public void setBasement(String basement) {
		this.basement = basement;
	}
	public Integer getBuildingNo() {
		return buildingNo;
	}
	public void setBuildingNo(Integer buildingNo) {
		this.buildingNo = buildingNo;
	}
	public Integer getBuildingSubNo() {
		return buildingSubNo;
	}
	public void setBuildingSubNo(Integer buildingSubNo) {
		this.buildingSubNo = buildingSubNo;
	}
	public String getBuildingMngNo() {
		return buildingMngNo;
	}
	public void setBuildingMngNo(String buildingMngNo) {
		this.buildingMngNo = buildingMngNo;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getBuildingName2() {
		return buildingName2;
	}
	public void setBuildingName2(String buildingName2) {
		this.buildingName2 = buildingName2;
	}
	public String getDongCode() {
		return dongCode;
	}
	public void setDongCode(String dongCode) {
		this.dongCode = dongCode;
	}
	public String getDongName() {
		return dongName;
	}
	public void setDongName(String dongName) {
		this.dongName = dongName;
	}
	public String getRi() {
		return ri;
	}
	public void setRi(String ri) {
		this.ri = ri;
	}
	public String getSan() {
		return san;
	}
	public void setSan(String san) {
		this.san = san;
	}
	public Integer getZibunNo() {
		return zibunNo;
	}
	public void setZibunNo(Integer zibunNo) {
		this.zibunNo = zibunNo;
	}
	public Integer getZibunSubNo() {
		return zibunSubNo;
	}
	public void setZibunSubNo(Integer zibunSubNo) {
		this.zibunSubNo = zibunSubNo;
	}
	public String getEupMyungNo() {
		return eupMyungNo;
	}
	public void setEupMyungNo(String eupMyungNo) {
		this.eupMyungNo = eupMyungNo;
	}	
}
