package kr.co.zadusoft.givus.service;

import java.util.List;

import kr.co.zadusoft.contents.service.UserService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dynamic.ibatis.util.SearchCondition;
import dynamic.sjax.SjaxCallable;
import dynamic.util.HttpServiceContext;

public class SjaxService {

	@SjaxCallable
	public boolean checkNickname( String nickname) throws Exception
	{
		UserService userService = (UserService)HttpServiceContext.getBean("userService");
		boolean isDuplicated = userService.checkNickname(nickname);

		return isDuplicated;

	}
}
