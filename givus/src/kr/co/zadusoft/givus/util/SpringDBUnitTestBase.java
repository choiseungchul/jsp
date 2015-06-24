/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;


import java.util.List;

import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.PostingService;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dynamic.util.HttpServiceContext;
import dynamic.web.util.SessionContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class SpringDBUnitTestBase {

	/**
	 * postingService bean 을 얻는 방법
	 */
	@Autowired
	private PostingService postingService;
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}

	@Before
	public void init() throws Exception{
		System.out.println( "init()");
		MockHttpServletRequest request = new MockHttpServletRequest();
		// request.addParameter("bbsIdx", "1");
		MockHttpServletResponse response = new MockHttpServletResponse();
        
		HttpServiceContext.init( request, response);
		SessionContext.setAnonymous();
	}

	//@Test
	public void testSample() throws Exception {
		List<PostingModel> models = postingService.getAll();
		if( models != null){
			for( PostingModel model : models){
				System.out.println( model.getSubject());
			}
		}
	}
	
	//@Test
	public void xtestInsert() throws Exception {
		PostingModel model = (PostingModel)postingService.get(1);
		System.out.println( model.getSubject());
		if( model != null){
			postingService.update(model);
			insert(model);
		}
	}
	
	public void insert(PostingModel model) throws Exception {
		model = (PostingModel)postingService.get(1);
		System.out.println( model.getSubject());
		if( model != null){
			postingService.update(model);
		}
	}
}
