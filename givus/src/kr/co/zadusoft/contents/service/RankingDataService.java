/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.List;

import kr.co.zadusoft.contents.dao.RankingDataDAO;
import kr.co.zadusoft.contents.model.RankingDataModel;
import kr.co.zadusoft.contents.util.ContentsParameter;
import dynamic.ibatis.util.Parameter;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class RankingDataService extends BaseService{
	private RankingDataDAO rankingDataDAO;

	public RankingDataDAO getRankingDataDAO() {
		return rankingDataDAO;
	}

	public void setRankingDataDAO(RankingDataDAO rankingDataDAO) {
		this.rankingDataDAO = rankingDataDAO;
		setBaseDAO( rankingDataDAO);
	}
	
	/**
	 * funcRankingDataList 에서 사용되는 메소드
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public List<RankingDataModel> searchRankingDataByRanking( ContentsParameter param) throws DAException{
		return rankingDataDAO.searchRankingDataByRanking( param);
	}
	
	/**
	 * funcRankingDataList 에서 사용되는 메소드
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public int countRankingDataByRanking( ContentsParameter param) throws DAException{
		return rankingDataDAO.countRankingDataByRanking( param);
	}
}
