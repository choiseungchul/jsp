package wp.utils;

public class ShowMsg {
	/**
	 * 자바 스크립트 경고창 코드 반환 
	 * @param msg  			Alert창에 띄울 메세지 
	 * @return				자바스크립트코드
	 */
	public static String showAlert(String msg)
	{
		return "<script>alert('" + msg + "')</script>";
	}
	
	/**
	 * 자바 스크립트 경고창 및 페이지 이동 코드 반환 
	 * @param msg			Alert창에 띄울 메세지
	 * @param url			이동할 페이지 경로
	 * @param flag			iframe 에서 실행할 경우 와 그렇지 않은 경우  1 => iframe , 0 => 현재창
	 * @return				자바스크립트 코드
	 */
	public static String showAlertLoc(String msg, String url, int flag)
	{
		if ( flag == 0)
		return "<script>alert('" + msg + "'); location.href = '"+url+"';</script>";
		if ( flag == 1)
		return "<script>alert('" + msg + "'); parent.location.href = '"+url+"';</script>";
		return "";
	}
	
}
