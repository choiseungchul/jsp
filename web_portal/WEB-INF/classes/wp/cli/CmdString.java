package wp.cli;


/**
 *  CLI 인터페이스 명령어 저장 클래스
 * 
 *  s_default_bmk	= 기본 북마크리스트 <br>
 *  s_user_bmk   	= 사용자 북마크리스트<br>
 *  add_bmk			= 사용자 북마크 추가<br>
 *  modify_bmk		= 사용자 북마크 수정<br>
 *  delete_bmk 		= 사용자 북마크 삭제<br>
 *  update_user_pass= 사용자 패스워드 확인<br>
 *  user_profile	= 프로파일의 접근 가능 URL<br>
 *  user_list		= 사용자 목록<br>
 *  checkpass		= 사용자 비밀번호 확인<br>
 *  ch_user_pass	= 사용자 비밀번호 변경<br>
 *  logout_prc		= 로그아웃 신호 보내기<br>
 */
public class CmdString {
	
	//arg0 사용자 아이디
	public static final String s_default_bmk 	= "show sslvpn predefined-bookmark-list %s";// 기본 북마크리스트
	//arg0 사용자 아이디  								
	public static final String s_user_bmk 		= "show sslvpn user-bookmark-list %s";		// 사용자 북마크리스트
	//arg0 사용자 아이디 : arg1 북마크 이름 : arg2  URL : arg3 설명 
	public static final String add_bmk 			= "sslvpn user-bookmark %s^%s^%s^%s";		// 사용자 북마크 추가
	//arg0 사용자 아이디 : arg1 (인덱스 번호 또는 식별자) : arg2 URL 정보
	public static final String modify_bmk 		= "sslvpn user-bookmark %s^%s modify %s^%s^%s";	// 사용자 북마크 수정
	//arg0 사용자 이이디 : arg1 (인덱스 번호 또는 식별자)
	public static final String delete_bmk 		= "no sslvpn user-bookmark %s^%s";			// 사용자 북마크 삭제
	//arg0 사용자 아디디 : arg1 사용자 비밀번호
	public static final String update_user_pass = "sslvpn check-passwd %s^%s";				// 사용자 패스워드 확인
	//arg0 프로파일 명 
	public static final String user_profile 	= "show sslvpn access-service-list %s";		// 프로파일의 접근 가능 URL
	//
	public static final String user_list 		= "show sslvpn user-list";					// 사용자 목록
	//arg0 사용자 아이디 : arg1 비밀번호
	public static final String checkpass		= "sslvpn check-passwd %s^%s";				// 사용자 비밀번호 확인
	//arg0 사용자 아이디 : arg1 사용자 아이디 : arg2 비밀번호 : arg3 프로파일명 : arg4 설명
	public static final String ch_user_pass		= "sslvpn user %s modify %s^%s^%s^%s";		// 사용자 비밀번호 변경
	//
	public static final String logout_prc 		= "sslvpn_cli -i %s";					// 로그아웃 신호 보내기
	//
	public static final String common_cfg		= "";							// 인증방식을 불러오기 위한 기본설정 불러오기 
	//arg0 사용자 아이디 : arg1 사용자 비밀번호
	public static final String user				= "sslvpn user-passwd %s^%s";	// 사용자 비밀번호 변경
	//
	public static final String login_page		= "show sslvpn login-page";		// 로그인 페이지 설정 가져오기

	////////// 테스트용 명령어 /////////
	//arg0 사용자 아이디 : arg1 사용자 비밀번호 : arg2 프로파일명 : arg3 설명
	public static final String add_user			= "sslvpn user %s^%s^%s^%s";	// 사용자 추가
	//
	public static final String apply_user		= "sslvpn user apply";			// 사용자 적용
	//arg0 도메인 : arg1 Alias : arg2 북마크 : arg3 설명
	public static final String add_srv_domain	= "sslvpn service-domain %s^%s^%s^%s^%s";		// 서비스 도메인 등록
	//
	public static final String apply_srv		= "sslvpn service-domain apply";			// 서비스 도메인 적용
	//
	public static final String s_domain			= "show sslvpn service-domain-list";		// 서비스 도메인 목록 불러오기
	//arg0 프로파일명 : arg1 설명
	public static final String add_profile		= "sslvpn profile %s^%s";			// 프로파일 등록
	//arg0 프로파일명 : arg1 프로파일명 : arg2 설명
	public static final String mod_profile		= "sslvpn profile %s modify %s^%s";	// 프로파일 변경
	//arg0 프로파일명 : arg1 Y/N (가능여부) : arg2 도메인명
	public static final String add_acc_srv		= "sslvpn access-service %s^%s";	// 프로파일에 사용가능 서비스도메인 등록
	//
	public static final String apply_profile	= "sslvpn profile apply";			// 프로파일 적용
	
	public static final String delete_srv_dm	= "no sslvpn service-domain %s";	// 서비스도메인 삭제
	
	public static final String s_profile		= "show sslvpn profile-list";		// 프로파일 목록 출력
}
