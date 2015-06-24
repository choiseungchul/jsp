/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.job;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.PostingService;
import kr.co.zadusoft.contents.util.RSSReader;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.sun.syndication.feed.synd.SyndEntry;

import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;
import dynamic.web.util.ConfigHandler;

public class RSSMigrationJob extends QuartzJobBean{
	
	Logger logger = Logger.getLogger( RSSMigrationJob.class);
	
	List<String[]> rssMappingInfos = new ArrayList<String[]>();
	
	@Autowired
	private PostingService postingService;
	
	@Autowired
	private ConfigHandler configHandler;
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}
	
	public ConfigHandler getConfigHandler() {
		return configHandler;
	}

	public void setConfigHandler(ConfigHandler configHandler) {
		this.configHandler = configHandler;
	}

	public RSSMigrationJob(){
		SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
		
		String migrationInfo = configHandler.getProperty( "posting.rssmigration");
		String[] migrationInfos = StringUtil.separate( migrationInfo, ",");
		for( String info : migrationInfos){
			String[] infos = StringUtil.separate( info, "|");
			rssMappingInfos.add( infos);
		}
	}
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		
		RSSReader reader = new RSSReader();
		if( !rssMappingInfos.isEmpty()){
			for( String[] infos : rssMappingInfos){
				
//				System.out.println(infos[0]);
				
				try{
					String rssUrl = infos[0];
					Integer boardId = Integer.parseInt( infos[1]);
					Integer postingCategoryId = null;
					if( infos.length == 3){
						postingCategoryId = Integer.parseInt( infos[2]);
					}
					
					List entries = reader.readRSS( rssUrl);
					
					// 우선 해당 글이 이관 되었는지 체크한다.
					// PostingModel.customField1 에는 rss 의 Link 가 저장된다. 해당 link 가 존재하는지 체크
					for (int i = 0; i < entries.size(); i++) {
				        SyndEntry entry = (SyndEntry) entries.get(i);
				        List<SearchCondition> conditions = new ArrayList<SearchCondition>();
						conditions.add( new SearchCondition( "boardId", boardId));
						conditions.add( new SearchCondition( "referenceURL", entry.getLink()));
				        boolean exist = postingService.exist( conditions);
				        // 존재하지 않으면 이관을 시작한다.
				        if( !exist){
				        	PostingModel model = new PostingModel();
				        	model.setCreator( "anonymous");
				        	model.setCreateDate( entry.getPublishedDate());
				        	model.setPostingType( PostingModel.POSTING_TYPE_RSS);
				        	model.setBoardId( boardId);
				        	model.setSubject( entry.getTitle());
				        	model.setContents( entry.getDescription().getValue());
				        	model.setCategoryId( postingCategoryId);
				        	model.setReferenceURL( entry.getLink());
				        	model.setCustomField1( entry.getAuthor()); // customField1 에는 작성자가 들어간다.
				        	model.setCustomField2(entry.getAuthor());
				        	
				        	postingService.create( model);
				        }
					}
				}catch( Exception e){
					e.printStackTrace();
				}
				
			}
		}else{
			logger.error("rssMappingInfos empty!!");
		}
	}
}
