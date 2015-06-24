package wp.databean;

import java.util.HashMap;

public class ProfileDTO {
	
//	use(Y/N)^domain_name^alias^bookmark^description
	private boolean flag = false;
	private String domain = null;
	private String alias = null;
	private String bookmark = null;
	private String desc = null;
	private String protocol = null;
	
	/**
	 * CLI 에서 출력된 데이터가 담긴 HashMap 객체를
	 * 현재 객체에 자바빈 형태로 저장한다. 
	 * @param data 		테이블데이터 
	 */
	public void SetData(HashMap<String, String> data)
	{
		this.domain		 = (data.get("domain") != null ? data.get("domain") : "" );
		this.protocol 	 = (data.get("domain") != null ? data.get("protocol") : "" );
		this.alias		 = (data.get("alias") != null ? data.get("alias") : "" );
		this.bookmark	 = (data.get("bookmark") != null ? data.get("bookmark") : "" );
		this.desc   	 = (data.get("desc") != null ? data.get("desc") : "");
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getBookmark() {
		return bookmark;
	}

	public void setBookmark(String bookmark) {
		this.bookmark = bookmark;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
}
