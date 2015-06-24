/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.List;

import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.RankingDataModel;
import dynamic.ibatis.util.Parameter;
import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisManagedDAO;

public class RankingDataDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "rankingdata";
	}
	
	/**
	 * funcRankingDataList 에서 사용되는 메소드
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public List<RankingDataModel> searchRankingDataByRanking( Parameter param) throws DAException{
		return (List<RankingDataModel>)queryForList( "searchRankingDataByRanking", param);
	}
	
	/**
	 * funcRankingDataList 에서 사용되는 메소드
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public Integer countRankingDataByRanking( Parameter param) throws DAException{
		Integer count = (Integer)queryForObject( "countRankingDataByRanking", param); 
		return count == null ? 0 : count;
	}
}