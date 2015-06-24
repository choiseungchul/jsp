package wp.databean;

import java.util.HashMap;

public class BookMarkDTO {
	
	private String userid = null;
	private String name = null;
	private String url  = null;
	private String desc = null;
	private String alias = null;
	
	public void SetData(HashMap<String, String> data)
	{
		this.name 	= (data.get("name") != null ? data.get("name") 		: "");
		this.url    = (data.get("domain") != null ? data.get("domain") 	: "");
		this.desc   = (data.get("desc") != null ? data.get("desc")		: "");
		this.alias  = (data.get("alias") != null ? data.get("alias")	: "");
	}
	
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
}
