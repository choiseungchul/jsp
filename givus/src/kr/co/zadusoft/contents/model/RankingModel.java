/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class RankingModel extends ManagedBaseModel{
	
	public static final String RANKING_TYPE_TOP_100 = "A";
	public static final String RANKING_TYPE_SEOUL_50 = "B";
	public static final String RANKING_TYPE_MAJOR_CITY_10 = "C";
	public static final String RANKING_TYPE_PART_10 = "D";
	
	@DBField
	private String rankingType;
	
	@DBField
	private Date startDate;
	
	@DBField
	private Date endDate;
	
	@DBField
	private String rankingLocationCode;
	
	@DBField
	private String rankingPartCode;
	
	public String getRankingType() {
		return rankingType;
	}

	public void setRankingType(String rankingType) {
		this.rankingType = rankingType;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getRankingLocationCode() {
		return rankingLocationCode;
	}

	public void setRankingLocationCode(String rankingLocationCode) {
		this.rankingLocationCode = rankingLocationCode;
	}

	public String getRankingPartCode() {
		return rankingPartCode;
	}

	public void setRankingPartCode(String rankingPartCode) {
		this.rankingPartCode = rankingPartCode;
	}

}
