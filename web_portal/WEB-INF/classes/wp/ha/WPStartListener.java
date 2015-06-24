package wp.ha;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import wp.manager.SessionDAO;
import wp.utils.Property;

/**
 * Tomcat 서버 구동시 세션정보를 동기화 및 설정을 불러오는 클래스
 * @author akrey
 *
 */
public class WPStartListener implements ServletContextListener { 

	public WPStartListener() { 
	} 
	
	/**
	 * 웹 서버 구동시에 실행되는 클래스 <br>
	 * common.properties 파일 경로를 지정해주고 
	 * 다른 웹포탈 서버의 세션 정보를 불러온다. 
	 */
	public void contextInitialized( 
	  ServletContextEvent sce) { 
	   System.out.println("LifeCycleServletContextListener: contextInitialized");
	   
	   String path = sce.getServletContext().getRealPath("/");
//	   System.out.println(path);
	   
	   Property.init(path);
	   
	   System.out.println("common.properties path : " + Property.getpath());
	   
	   // 다른 장비의 DB , 메모리에 할당된 세션 가져온다
	   WPInitialize.init();
	} 
	
	public void contextDestroyed( 
	  ServletContextEvent sce) { 
	   System.out.println( 
	     "LifeCycleServletContextListener: contextDestroyed"); 
	   
	   // 서버가 다운될때 모든 DB 세션정보삭제
	   SessionDAO.getInstance().removeAll();
	} 
} 


