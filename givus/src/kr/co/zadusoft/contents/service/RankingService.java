/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.dao.RankingDAO;
import kr.co.zadusoft.contents.model.RankingModel;
import dynamic.ibatis.util.PlainSearchCondition;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class RankingService extends BaseService{
	private RankingDAO rankingDAO;

	public RankingDAO getRankingDAO() {
		return rankingDAO;
	}

	public void setRankingDAO(RankingDAO rankingDAO) {
		this.rankingDAO = rankingDAO;
		setBaseDAO( rankingDAO);
	}
	
	/**
	 * 가장 최근 랭킹을 가져온다.
	 * @param rankingType
	 * @return
	 * @throws DAException
	 */
	public RankingModel getRecentRanking( String rankingType) throws DAException{
		return getRecentRanking( rankingType, null); 
	}
	
	public RankingModel getRecentRanking( String rankingType, String rankingLocationCode) throws DAException{
		//return rankingDAO.getRecentRanking( rankingType, rankingLocationCode);
		return getRecentRanking( rankingType, rankingLocationCode, null);
	}
	
	public RankingModel getRecentRanking( String rankingType, String rankingLocationCode, String rankingPartCode) throws DAException{
		if ( rankingPartCode != null ){
			return rankingDAO.getRecentRankingByPart( rankingType, rankingPartCode);
		}else{
			return rankingDAO.getRecentRanking( rankingType, rankingLocationCode);
		}
	}
}
