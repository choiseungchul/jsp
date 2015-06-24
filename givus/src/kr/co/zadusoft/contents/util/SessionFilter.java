package kr.co.zadusoft.contents.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;

import dynamic.util.StringUtil;
import dynamic.util.UserContext;
import dynamic.web.model.User;
import dynamic.web.util.SessionContext;

public class SessionFilter implements Filter
{
	@SuppressWarnings( "unused")
	private static boolean logging = true;
	
	private String[] exceptionUrls;
	
	public void init(FilterConfig config) throws ServletException
	{
		System.out.println( "Loading Filter [" + this.getClass().getName() + "].");
	}
	
	public void destroy()
	{
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
	{
		HttpServletRequest request = ( HttpServletRequest) servletRequest;
		HttpServletResponse response = ( HttpServletResponse) servletResponse;
		
		System.out.println("SessionContext.getLoginInfo()=" + SessionContext.getLoginInfo());
		if( SessionContext.getLoginInfo() == null)
		{
			
			SessionContext.setAnonymous();
			
			UserModel uModel = new UserModel();
			uModel.setId( 1);
			uModel.setNickname( "익명사용자");
			uModel.setAccount( "anonymous");
			
			SessionContext.setUserModel( uModel);
		}
		
		filterChain.doFilter( request, response);
	}
}
