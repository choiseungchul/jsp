/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.model.UserModel;
import dynamic.util.UserContext;
import dynamic.web.model.RoleModel;
import dynamic.web.resource.Constants;

public class GivusUserContext extends UserContext {
	private final static String KEY_GIVUS_USER = "UserContext_User_Givus";
	private final static String KEY_GIVUS_ROLE = "UserContext_Role_Givus";
	
	public static UserModel getUserModel()
	{
		return (UserModel)getContextObject( KEY_GIVUS_USER);
	}
	
	public static void setUserModel( UserModel userModel)
	{
		setContextObject(KEY_GIVUS_USER, userModel);
	}
	
	public static void setAnonymousUser()
	{
		UserModel userModel = new UserModel();
		userModel.setAccount("anonymous");
		userModel.setName("anonymous");
		setUserModel(userModel);
	}
	
	public static void setSystemUser()
	{
		UserModel userModel = new UserModel();
		userModel.setAccount("system");
		userModel.setName("system");
		setUserModel(userModel);
	}
	
	
	public static List<RoleModel> getRoles()
	{
		return (List<RoleModel>)getContextObject( KEY_GIVUS_ROLE);
	}
	
	public static List< kr.co.zadusoft.contents.model.RoleModel> getGivusRoles()
	{
		List<RoleModel> models = (List<RoleModel>)getRoles(); 
		List< kr.co.zadusoft.contents.model.RoleModel> givusmodels = new ArrayList< kr.co.zadusoft.contents.model.RoleModel>();
		for ( RoleModel model : models){
			kr.co.zadusoft.contents.model.RoleModel givusmodel = new kr.co.zadusoft.contents.model.RoleModel();
			givusmodel.setId( model.getId());
			givusmodel.setCode( model.getCode());
			givusmodel.setName( model.getName());
			givusmodel.setDescription( model.getDescription());
			givusmodels.add( givusmodel);
		}
		
		return givusmodels;
	}
	
	public static void setRoles( List<RoleModel> roles)
	{
		setContextObject( KEY_GIVUS_ROLE, roles);
	}
	
	public static void setGivusRoles( List<kr.co.zadusoft.contents.model.RoleModel> roles)
	{
		List<RoleModel> models = new ArrayList< RoleModel>();
		
		for ( kr.co.zadusoft.contents.model.RoleModel role : roles){
			RoleModel model = new RoleModel();
			model.setId( role.getId());
			model.setCode( role.getCode());
			model.setName( role.getName());
			model.setDescription( role.getDescription());
			models.add( model);
		}
		
		setRoles( models);
	}

}
