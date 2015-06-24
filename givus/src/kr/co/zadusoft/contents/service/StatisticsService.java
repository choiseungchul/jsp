/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.StatisticsDAO;
import dynamic.web.service.BaseService;

public class StatisticsService extends BaseService{
	private StatisticsDAO statisticsDAO;

	public StatisticsDAO getStatisticsDAO() {
		return statisticsDAO;
	}

	public void setStatisticsDAO(StatisticsDAO statisticsDAO) {
		this.statisticsDAO = statisticsDAO;
		setBaseDAO( statisticsDAO);
	}
}
