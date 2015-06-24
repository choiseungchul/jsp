/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import dynamic.ibatis.util.MybatisSqlMapGenerator;

public class ContentsMybatisMapGenerator {
	public static void main(String[] args) throws Exception{
		MybatisSqlMapGenerator gen = new MybatisSqlMapGenerator();
		gen.addClass( dynamic.web.model.ManagedBaseModel.class);
		gen.generator( "kr.co.zadusoft.contents.model.BoardModel");
		gen.generator( "kr.co.zadusoft.contents.model.CommentModel");
		gen.generator( "kr.co.zadusoft.contents.model.FileModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalModel");
		gen.generator( "kr.co.zadusoft.contents.model.KeywordModel");
		gen.generator( "kr.co.zadusoft.contents.model.MessageReceiveModel");
		gen.generator( "kr.co.zadusoft.contents.model.MessageSendModel");
		gen.generator( "kr.co.zadusoft.contents.model.MessageQueueModel");
		gen.generator( "kr.co.zadusoft.contents.model.OperationModel");
		gen.generator( "kr.co.zadusoft.contents.model.OperationPriceModel");
		gen.generator( "kr.co.zadusoft.contents.model.PostingModel");
		gen.generator( "kr.co.zadusoft.contents.model.RankingDataModel");
		gen.generator( "kr.co.zadusoft.contents.model.RankingModel");
		gen.generator( "kr.co.zadusoft.contents.model.UserModel");
		gen.generator( "kr.co.zadusoft.contents.model.CategoryModel");
		gen.generator( "kr.co.zadusoft.contents.model.ZipcodeModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalEventModel");
		gen.generator( "kr.co.zadusoft.contents.model.AdvertisementModel");
		
		gen = new MybatisSqlMapGenerator();
		gen.addClass( dynamic.web.model.BaseModel.class);
		gen.generator( "kr.co.zadusoft.contents.model.CodeModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalKeywordModel");
		gen.generator( "kr.co.zadusoft.contents.model.StatisticsModel");
		gen.generator( "kr.co.zadusoft.contents.model.UserHospitalViewModel");
		gen.generator( "kr.co.zadusoft.contents.model.UserKeywordModel");
		gen.generator( "kr.co.zadusoft.contents.model.PostingUserActionModel");
		gen.generator( "kr.co.zadusoft.contents.model.PostingCategoryModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalEvaluationModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalStatsModel");
		gen.generator( "kr.co.zadusoft.contents.model.MessageRelationModel");
		gen.generator( "kr.co.zadusoft.contents.model.ZipcodeZibunModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalEventUserActionModel");
		gen.generator( "kr.co.zadusoft.contents.model.HospitalEventViewModel");
		gen.generator( "kr.co.zadusoft.contents.model.AdsPositionModel");
		gen.generator( "kr.co.zadusoft.contents.model.ReviewPointsModel");
		gen.generator( "kr.co.zadusoft.contents.model.UserConnectHospitalModel");
		gen.generator( "kr.co.zadusoft.contents.model.RoleModel");
		gen.generator( "kr.co.zadusoft.contents.model.RoleUserModel");
		
	}
}
