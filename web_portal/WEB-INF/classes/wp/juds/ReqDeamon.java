package wp.juds;

import wp.utils.Property;

/**
 * 
 * @author akrey
 *
 */
public class ReqDeamon extends Connector{

	private int sockfd = -1;
	
	// 로그인 인증 데이터 결과 빈
	private int authResult = -1;
	private String profileId = null;
	private String authMsg = null;
	
	// 로그아웃 인증 데이터 결과 빈
	private int relResult = -1;
	private String relMsg = null;
	
	/**
	 * ReqDeamon 객체가 생성될때 인증데몬 소켓을 연결한다.
	 */
	public ReqDeamon()
	{
		sockfd = super.createSocket(Property.getProperty("wp.udssocketpath"));
		super.connectSocket(sockfd , Property.getProperty("wp.udssocketpath"));
	}
	
	/**
	 * 인증데몬으로 로그인 인증 요청 및 로그아웃시 정보 전송
	 * @param userid			사용자 아이디
	 * @param userpass			사용자 비밀번호
	 * @param sessionid			세션 아이디
	 * @param clientIP			클라이언트 아이피
	 * @param flag				로그인/로그아웃 구분   1 = 로그인 , 2 = 로그아웃
	 * @return					인증모듈에서 반환된 값
	 */
	public void requestAuth(String userid ,String userpass ,
			String sessionid , String clientIP , int flag )
	{
		if ( flag == 1 ) // 로그인
		{
			String[] arg = new String[5];
			arg[0] = String.valueOf(flag);
			//arg[1] = String.valueOf(authmode); // 인증모드는 관리자 GUI에서 설정되었기 때문에 삭제
			arg[1] = userid;
			arg[2] = userpass;
			arg[3] = sessionid;
			arg[4] = clientIP;
			
			String req = this.makeAuthString(arg);
			
			super.write(sockfd, req, 1024);
			this.resultParser(super.readData(sockfd, 128), flag);
			super.dclose(sockfd);
			
		}
		else if (flag == 0) // 로그아웃
		{
			String[] arg = new String[4];
			arg[0] = String.valueOf(flag);
			// 세션 아이디 대신 사용자 아이디
			arg[1] = userid;
			// 클라이언트 아이피가 필요함
			arg[2] = clientIP;
			arg[3] = sessionid;
			
			String req = this.makeAuthString(arg);
			
			super.write(sockfd, req, 1024);
			this.resultParser(super.readData(sockfd, 128), flag);
			super.dclose(sockfd);
		}
		
	}
	
	
	/**
	 * 인증 결과값을 현 객체에 담는다
	 * @param returnData		데몬에서 인증결과로 받은 문자열값
	 * @param flag				로그인/로그아웃 구분    1 = 로그인 , 0 = 로그아웃
	 */
	private void resultParser(String returnData , int flag)
	{
		if (flag == 1)
		{
			String[] data = returnData.split("::");
			if (data.length == 3)
			{
				// 1 => 성공 
				this.authResult = Integer.parseInt(data[0]);
				this.profileId  = data[1];
				this.authMsg 	= data[2];
			}else{
				System.out.println("잘못된 인증결과값 :" + returnData);
			}
		}else if ( flag == 0 )
		{
			String[] data = returnData.split("::");
			if (data.length == 2)
			{
				this.relResult = Integer.parseInt(data[0]);
				this.relMsg    = data[1];
			}else{
				System.out.println("잘못된 인증결과값 :" + returnData);
			}
		}
	}
	
	/**
	 * 인증 데몬으로 인증 요청할 파라미터 생성
	 * @param arg		 인증요청에 필요한 문자열 배열
	 * @return			 인증요청을 위한 문자열 반환
	 */
	private String makeAuthString(String[] arg)
	{
		StringBuilder str = new StringBuilder();
		
		for ( int i = 0 ; i < arg.length ; i++)
		{
			if ( i != (arg.length - 1) )
			str.append(arg[i] + "::");
			else str.append(arg[i]);
		}
		
		return str.toString();
	}

	public int getAuthResult() {
		return authResult;
	}

	public String getProfileId() {
		return profileId;
	}

	public String getAuthMsg() {
		return authMsg;
	}

	public int getRelResult() {
		return relResult;
	}

	public String getRelMsg() {
		return relMsg;
	}
}
