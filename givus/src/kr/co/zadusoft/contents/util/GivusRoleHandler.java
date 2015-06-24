package kr.co.zadusoft.contents.util;

import java.util.List;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.givus.util.GivusUserContext;
import dynamic.util.RoleHandler;
import dynamic.util.StringUtil;
import dynamic.util.UserContext;
import dynamic.web.model.RoleModel;
import dynamic.web.model.User;

public class GivusRoleHandler extends RoleHandler {

	private static final String SYSTEM_MANAGER = "systemManager";
	
	/**
	 * Check User's role
	 * @param roleName
	 * @return
	 */
	@Override
	public boolean checkUserRole( String roleName){
		
		// 권한 설정이 되어 있지 않은 경우에는 무조건 통과한다.
		if( StringUtil.isNull(roleName)) return true;
		
		// system 계정일 경우에는 모든권한을 통과한다.
		if( checkSystemManager()) return true;

		List<RoleModel> roles = GivusUserContext.getRoles();
		if( roles == null) return false;
		
		for( RoleModel role : roles)
		{
			if( roleName.indexOf(role.getCode()) != -1)
			{
				return true;
			}
		}
		
		return false;
	}
	@Override
	public boolean checkSystemManager(){
		UserModel user = GivusUserContext.getUserModel();
		
		if( user != null){
		
			if( "system".equals( user.getAccount()))
				return true;
			
			String roleStr = SYSTEM_MANAGER;
			if( StringUtil.isNull(roleStr)) return true;
			
			List<RoleModel> roles = GivusUserContext.getRoles();
			if( roles == null) return false;
			
			for( RoleModel role : roles)
			{
				if( roleStr.indexOf(role.getCode()) != -1)
				{
					return true;
				}
			}
		}
		
		return false;
	}
}
