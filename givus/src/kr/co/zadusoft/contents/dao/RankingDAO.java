/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.Map;

import kr.co.zadusoft.contents.model.RankingModel;
import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisManagedDAO;

public class RankingDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "ranking";
	}
	
	public RankingModel getRecentRanking( String rankingType, String rankingLocationCode) throws DAException{
		Map<String, String> param = new HashMap<String, String>();
		param.put( "rankingType", rankingType);
		param.put( "rankingLocationCode", rankingLocationCode);
		return (RankingModel)queryForObject( "getRecentRanking", param);
	}
	
	public RankingModel getRecentRankingByPart( String rankingType, String rankingPartCode) throws DAException{
		Map<String, String> param = new HashMap<String, String>();
		param.put( "rankingType", rankingType);
		param.put( "rankingPartCode", rankingPartCode);
		return (RankingModel)queryForObject( "getRecentRankingByPart", param);
	}
}