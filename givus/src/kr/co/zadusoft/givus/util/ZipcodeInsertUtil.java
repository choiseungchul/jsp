/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.List;

import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.ZipcodeModel;
import kr.co.zadusoft.contents.service.ZipcodeService;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dynamic.web.dao.DAException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:WebContent/WEB-INF/config/database-config-test.xml", "file:WebContent/WEB-INF/config/database-beans.xml"})
public class ZipcodeInsertUtil extends SpringDBUnitTestBase{

	@Autowired
	private ZipcodeService zipcodeService;
	public ZipcodeService getZipcodeService() {
		return zipcodeService;
	}

	public void setZipcodeService(ZipcodeService zipcodeService) {
		this.zipcodeService = zipcodeService;
	}
	
	@Test
	public void test() throws Exception{
		
	}
	
	@Test
	public void testInsert() throws DAException{
		ZipcodeModel model = (ZipcodeModel)zipcodeService.get(1);
		if( model != null){
			System.out.println( model.getName());
			zipcodeService.create( model);
		}
	}
	
	@Test
	public void testSample() throws Exception {
		List<ZipcodeModel> models = zipcodeService.getAll();
		if( models != null){
			for( ZipcodeModel model : models){
				System.out.println( model.getName());
			}
		}
	}
}
