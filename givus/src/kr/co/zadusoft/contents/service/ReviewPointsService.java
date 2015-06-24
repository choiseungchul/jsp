/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.ReviewPointsDAO;
import kr.co.zadusoft.contents.model.ReviewPointsModel;
import dynamic.web.service.BaseService;

public class ReviewPointsService extends BaseService{
	private ReviewPointsDAO reviewPointsDAO;

	public ReviewPointsDAO getReviewPointsDAO() {
		return reviewPointsDAO;
	}

	public void setReviewPointsDAO(ReviewPointsDAO reviewPointsDAO) {
		this.reviewPointsDAO = reviewPointsDAO;
		setBaseDAO( reviewPointsDAO);
	}
	
	public int getMean( ReviewPointsModel reviewPointModel){
		int mean = 0;
		if ( reviewPointModel != null){
			int total = getTotal( reviewPointModel);
					/*reviewPointModel.getEnoughDesc()
					+reviewPointModel.getConsiderNeeds()
					+reviewPointModel.getReaction()
					+reviewPointModel.getFacilities()
					+reviewPointModel.getWaitingTime()
					+reviewPointModel.getPrivacy()
					+reviewPointModel.getReliability()
					+reviewPointModel.getDealingWith()
					+reviewPointModel.getTransportation()
					+reviewPointModel.getStress()
					+reviewPointModel.getAfterSupport()
					+reviewPointModel.getAmount()
					+reviewPointModel.getResultSatisfaction();*/
			System.out.println( " total = " + total);
			double totaldouble = total * 100 / 12;
			if ( totaldouble > 400){
				mean = 5;
			} else if  ( totaldouble > 300){
				mean = 4;
			} else if  ( totaldouble > 200){
				mean = 3;
			} else if  ( totaldouble > 100){
				mean = 2;
			} else if  ( totaldouble > 0){
				mean = 1;
			}
			
			System.out.println( " totaldouble = " +  totaldouble);
			System.out.println( " mean = " +  mean);
		}
		return mean;
	}
	
	public int getTotal( ReviewPointsModel reviewPointModel){
		if ( reviewPointModel != null){
			int total = reviewPointModel.getEnoughDesc()
					+reviewPointModel.getConsiderNeeds()
					+reviewPointModel.getReaction()
					+reviewPointModel.getFacilities()
					+reviewPointModel.getWaitingTime()
					+reviewPointModel.getPrivacy()
					+reviewPointModel.getReliability()
					/*+reviewPointModel.getDealingWith()*/
					+reviewPointModel.getTransportation()
					+reviewPointModel.getStress()
					+reviewPointModel.getAfterSupport()
					+reviewPointModel.getAmount()
					+reviewPointModel.getResultSatisfaction();

			return total;
		}
		return 0;
	}
	public double getMeanDouble( ReviewPointsModel reviewPointModel){
		int total = getTotal( reviewPointModel);
		System.out.println( " total = " + total);
		double totaldouble = ( total == 0)? 0d : total * 100 / 12;

		System.out.println( " totaldouble = " +  totaldouble);
		return totaldouble;
	}
}
