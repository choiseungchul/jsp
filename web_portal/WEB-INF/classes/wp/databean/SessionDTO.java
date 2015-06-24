package wp.databean;



public class SessionDTO {
	
	private int idx = -1;
	private String sid = null;
	private String uid = null;
	private long cdate = 0L;
	private long udate = 0L;
	private String purl = null;
	private String client_port = null;
	private String client_addr = null;
	
	public String getClient_port() {
		return client_port;
	}
	public void setClient_port(String client_port) {
		this.client_port = client_port;
	}
	public String getClient_addr() {
		return client_addr;
	}
	public void setClient_addr(String client_addr) {
		this.client_addr = client_addr;
	}
	
	public long getCdate() {
		return cdate;
	}
	public void setCdate(long cdate) {
		this.cdate = cdate;
	}
	public long getUdate() {
		return udate;
	}
	public void setUdate(long udate) {
		this.udate = udate;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getPurl() {
		return purl;
	}
	public void setPurl(String purl) {
		this.purl = purl;
	}
}
