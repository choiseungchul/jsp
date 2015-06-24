package kr.co.zadusoft.givus.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.UserService;
import kr.co.zadusoft.givus.util.GivusUserContext;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.HttpServiceContext;
import dynamic.util.HttpServletRequestHelper;
import dynamic.util.SecurityUtil;
import dynamic.util.StringUtil;
import dynamic.util.UserContext;
import dynamic.web.controller.BaseController;
import dynamic.web.controller.LoginController;
import dynamic.web.controller.LoginException;
import dynamic.web.dao.DAException;
import dynamic.web.dao.UserDAO;
import kr.co.zadusoft.contents.model.RoleModel;
import kr.co.zadusoft.contents.service.RoleService;
import dynamic.web.resource.Constants;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;
import dynamic.web.util.SessionContext.LoginInfo;
import dynamic.web.view.Dispatcher;

public class GivusLoginController extends BaseController{ 

	private String loginSuccessPage;
	private String loginPagePath;
	private RoleService roleService;
	
	public RoleService getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	
	protected UserService userService;
	
//	private GivusRoleService roleService;

	public String getLoginSuccessPage() {
		return loginSuccessPage;
	}

	public void setLoginSuccessPage(String loginSuccessPage) {
		this.loginSuccessPage = loginSuccessPage;
	}
	
	public String getLoginPagePath() {
		return loginPagePath;
	}

	public void setLoginPagePath(String loginPagePath) {
		this.loginPagePath = loginPagePath;
	}


	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}


	public Parameter buildParameter( HttpServletRequest request)
	{
		Parameter param = new Parameter();
		HttpServletRequestHelper requestHelper = new HttpServletRequestHelper( request);
		param.setAccount( requestHelper.getParameter(Constants.ACCOUNT));
		param.setPassword( requestHelper.getParameter(Constants.PASSWORD));
		
		return param;
	}

	
	@Override
	public ModelAndView handle(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Parameter param = buildParameter(request);	
		
		try
		{
			doLogin( param);
			
			ModelAndView mav = new ModelAndView( "redirect:/___/p/main");
			return mav;
		}
		catch( LoginException e)
		{
			// UrlBasedViewResolver 를 피하는 방법
			request.setAttribute("errormessage", e.getMessage());
			request.setAttribute("account", param.getAccount());
			//RequestDispatcher rd = request.getRequestDispatcher( "/login.jsp");
			request.setAttribute("exception", e);
//			request.setAttribute("exception.message", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher( "/WEB-INF/jsp/givus/givus_error.jsp");
			rd.forward(request, response);
			
			return null;
		}
	}
	
	@Override
	public Dispatcher getDispatcher( HttpServletRequest request, HttpServletResponse response, Parameter param) throws Exception
	{
		return null;
	}
	
	protected void doLogin( Parameter param) throws LoginException, DAException, ServletException //, GivusAuthorityException
	{
		if( StringUtil.isNull(param.getAccount()))
		{
			throw new LoginException( MessageHandler.getMessage("login.error.userid.null"));
		}
		
		boolean isValid = checkPassword( param.getAccount(), param.getPassword());
		if( !isValid){
			throw new LoginException( MessageHandler.getMessage("login.error.password.wrong"));
		}

		
		// UserModel, 사용자 정보를 설정한다.
		UserModel userModel = userService.getByAccount(param.getAccount());
		
		if( userModel.getUserStatus().equals(UserModel.USER_USERSTATUS_DELETE)){
			throw new LoginException( MessageHandler.getMessage("login.error.user.deleted"));
		}
		if( userModel.getUserStatus().equals(UserModel.USER_USERSTATUS_LOCK)){
			throw new LoginException( MessageHandler.getMessage("login.error.user.locked"));
		}
		if( userModel.getUserStatus().equals(UserModel.USER_USERSTATUS_WITHDRAW_WAITING)){
			throw new LoginException( MessageHandler.getMessage("login.error.user.withdraw.waiting"));
		}
		
		// 세션세팅
		GivusUserContext.setUserModel(userModel);
		SessionContext.setUserModel(userModel);
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.setAccount( userModel.getAccount());
		loginInfo.setLoginDate( new Date());
		
		SessionContext.setLoginInfo(loginInfo);
		
		// TODO: 역할 세팅
		List<RoleModel> roleModels = roleService.getRoleByAccount( userModel.getAccount());
		GivusUserContext.setGivusRoles( roleModels);
		
		// UserModel 정보를 갱신한다.
		userModel.setLastLoginDate( new Date());
		userModel.setLoginCount( (userModel.getLoginCount() == null ? 0 : userModel.getLoginCount()) + 1);
		userService.update( userModel);
	}
	
	protected boolean checkPassword( String account, String password) throws DAException{
		return userService.checkPassword( account, password);
	}

	
	protected void setLoginStatus( UserModel userModel)  throws LoginException, DAException{
		// 세션세팅
		GivusUserContext.setUserModel(userModel);
		SessionContext.setUserModel(userModel);
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.setAccount( userModel.getAccount());
		loginInfo.setLoginDate( new Date());
		
		SessionContext.setLoginInfo(loginInfo);
		// TODO: 역할 세팅
		List<RoleModel> roleModels = roleService.getRoleByAccount( userModel.getAccount());
		GivusUserContext.setGivusRoles( roleModels);
		
		// UserModel 정보를 갱신한다.
		userModel.setLastLoginDate( new Date());
		userModel.setLoginCount( (userModel.getLoginCount() == null ? 0 : userModel.getLoginCount()) + 1);
		userService.update( userModel);
	}
}
