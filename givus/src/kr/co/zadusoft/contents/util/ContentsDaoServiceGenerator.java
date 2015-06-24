/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import dynamic.web.util.MybatisDAOServiceGenerator;

public class ContentsDaoServiceGenerator {
	public static void main(String[] args) throws Exception{
		MybatisDAOServiceGenerator generator = new MybatisDAOServiceGenerator();
		generator.setDaoPackageName( "kr.co.zadusoft.contents.dao");
		generator.setServicePackageName( "kr.co.zadusoft.contents.service");
		generator.addModel( "kr.co.zadusoft.contents.model.BoardModel");
		generator.addModel( "kr.co.zadusoft.contents.model.CodeModel");
		generator.addModel( "kr.co.zadusoft.contents.model.CommentModel");
		generator.addModel( "kr.co.zadusoft.contents.model.FileModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalKeywordModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalModel");
		generator.addModel( "kr.co.zadusoft.contents.model.KeywordModel");
		generator.addModel( "kr.co.zadusoft.contents.model.MessageReceiveModel");
		generator.addModel( "kr.co.zadusoft.contents.model.MessageSendModel");
		generator.addModel( "kr.co.zadusoft.contents.model.MessageQueueModel");
		generator.addModel( "kr.co.zadusoft.contents.model.OperationModel");
		generator.addModel( "kr.co.zadusoft.contents.model.OperationPriceModel");
		generator.addModel( "kr.co.zadusoft.contents.model.PostingModel");
		generator.addModel( "kr.co.zadusoft.contents.model.RankingDataModel");
		generator.addModel( "kr.co.zadusoft.contents.model.RankingModel");
		generator.addModel( "kr.co.zadusoft.contents.model.StatisticsModel");
		generator.addModel( "kr.co.zadusoft.contents.model.UserHospitalViewModel");
		generator.addModel( "kr.co.zadusoft.contents.model.UserKeywordModel");
		generator.addModel( "kr.co.zadusoft.contents.model.UserModel");
		generator.addModel( "kr.co.zadusoft.contents.model.PostingUserActionModel");
		generator.addModel( "kr.co.zadusoft.contents.model.PostingCategoryModel");
		generator.addModel( "kr.co.zadusoft.contents.model.CategoryModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalEvaluationModel");
		generator.addModel( "kr.co.zadusoft.contents.model.ZipcodeModel");
		generator.addModel( "kr.co.zadusoft.contents.model.MessageRelationModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalStatsModel");
		generator.addModel( "kr.co.zadusoft.contents.model.ZipcodeZibunModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalEventModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalEventViewModel");
		generator.addModel( "kr.co.zadusoft.contents.model.HospitalEventUserActionModel");
		generator.addModel( "kr.co.zadusoft.contents.model.AdvertisementModel");
		generator.addModel( "kr.co.zadusoft.contents.model.AdsPositionModel");
		generator.addModel( "kr.co.zadusoft.contents.model.ReviewPointsModel");
		generator.addModel( "kr.co.zadusoft.contents.model.UserConnectHospitalModel");
		generator.addModel( "kr.co.zadusoft.contents.model.RoleModel");
		generator.addModel( "kr.co.zadusoft.contents.model.RoleUserModel");
		
		
		generator.generate();
		
	}
}
