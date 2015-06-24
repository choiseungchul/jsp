package wp.databean;

import java.util.HashMap;

/**
 * 사용자 정보를 담는 객체
 * @author akrey
 *
 */
public class UserDTO {
	
	private String userid = null;
	private String profile = null;
	private String desc = null;
	
	/**
	 * CLI 에서 출력된 데이터가 담긴 HashMap 객체를
	 * 현재 객체에 자바빈 형태로 저장한다. 
	 * @param data 		테이블데이터 
	 */
	public void SetData(HashMap<String, Object> data)
	{
		this.userid	 = (String) (data.get("userid") != null ? data.get("userid") : "" );
		this.profile = (String) (data.get("profile") != null ? data.get("profile") : "" );
		this.desc    = (String) (data.get("desc") != null ? data.get("desc") : "");
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

}
