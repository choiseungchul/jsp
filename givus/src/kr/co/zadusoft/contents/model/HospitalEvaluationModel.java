/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.util.NumberUtil;
import dynamic.web.model.BaseModel;

public class HospitalEvaluationModel extends BaseModel{
	
	@DBField
	private Integer hospitalId;
	
	@DBField
	private Integer point1 = 0;
	
	@DBField
	private Integer point2 = 0;
	
	@DBField
	private Integer point3 = 0;
	
	@DBField
	private Integer point4 = 0;
	
	@DBField
	private Integer point5 = 0;
	
	@DBField
	private Integer manCount = 0;
	
	@DBField
	private Integer womanCount = 0;
	
	@DBField
	private Integer generation10 = 0;
	
	@DBField
	private Integer generation20 = 0;
	
	@DBField
	private Integer generation30 = 0;
	
	@DBField
	private Integer generation40 = 0;

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public Integer getPoint1() {
		return point1;
	}

	public void setPoint1(Integer point1) {
		this.point1 = point1;
	}

	public Integer getPoint2() {
		return point2;
	}

	public void setPoint2(Integer point2) {
		this.point2 = point2;
	}

	public Integer getPoint3() {
		return point3;
	}

	public void setPoint3(Integer point3) {
		this.point3 = point3;
	}

	public Integer getPoint4() {
		return point4;
	}

	public void setPoint4(Integer point4) {
		this.point4 = point4;
	}

	public Integer getPoint5() {
		return point5;
	}

	public void setPoint5(Integer point5) {
		this.point5 = point5;
	}

	public Integer getManCount() {
		return manCount;
	}

	public void setManCount(Integer manCount) {
		this.manCount = manCount;
	}

	public Integer getWomanCount() {
		return womanCount;
	}

	public void setWomanCount(Integer womanCount) {
		this.womanCount = womanCount;
	}

	public Integer getGeneration10() {
		return generation10;
	}

	public void setGeneration10(Integer generation10) {
		this.generation10 = generation10;
	}

	public Integer getGeneration20() {
		return generation20;
	}

	public void setGeneration20(Integer generation20) {
		this.generation20 = generation20;
	}

	public Integer getGeneration30() {
		return generation30;
	}

	public void setGeneration30(Integer generation30) {
		this.generation30 = generation30;
	}

	public Integer getGeneration40() {
		return generation40;
	}

	public void setGeneration40(Integer generation40) {
		this.generation40 = generation40;
	}
	
	public void prepareStats(){
		int sumEvaluationCount = getPoint1() + getPoint2() + getPoint3() + getPoint4() + getPoint5();
		int sumPeopleCount = getManCount() + getWomanCount();
		int sumGenerationCount = getGeneration10() + getGeneration20() + getGeneration30() + getGeneration40();
		float avgPoint = (float)( getPoint1() + (2 * getPoint2()) + (3 * getPoint3()) + (4 * getPoint4()) + (5 * getPoint5())) / (float)sumEvaluationCount;
		int percentageMan = (int)( ( (float)getManCount() / (float)sumPeopleCount ) * 100 );
		int percentageWoman = (int)( ( (float)getWomanCount() / (float)sumPeopleCount ) * 100 );
		int percentage10G  = (int)( ( (float)getGeneration10() / (float)sumGenerationCount ) * 100 );
		int percentage20G  = (int)( ( (float)getGeneration20() / (float)sumGenerationCount ) * 100 );
		int percentage30G  = (int)( ( (float)getGeneration30() / (float)sumGenerationCount ) * 100 );
		int percentage40G  = (int)( ( (float)getGeneration40() / (float)sumGenerationCount ) * 100 );
		
		
		addRenderedData( "avgPoint", String.valueOf( NumberUtil.formatNumber( avgPoint, "0.00")));
		addRenderedData( "totalCount", String.valueOf( sumEvaluationCount));
		addRenderedData( "percentageMan", String.valueOf( percentageMan));
		addRenderedData( "percentageWoman", String.valueOf( percentageWoman));
		addRenderedData( "percentage10G", String.valueOf( percentage10G));
		addRenderedData( "percentage20G", String.valueOf( percentage20G));
		addRenderedData( "percentage30G", String.valueOf( percentage30G));
		addRenderedData( "percentage40G", String.valueOf( percentage40G));
	}
}
