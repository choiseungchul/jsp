package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class UserConnectHospitalModel extends BaseModel {

	/**W=대기, A=승인, R=반려, C=취소*/
	public static final String USERCONHOSPITAL_STATUS_WAIT = "W";
	public static final String USERCONHOSPITAL_STATUS_APPROVAL = "A";
	public static final String USERCONHOSPITAL_STATUS_REJECT = "R";
	public static final String USERCONHOSPITAL_STATUS_CANCEL = "C";
	
	@DBField 	
	private Integer hospitalId;
	
	@DBField 	
	private Integer userId;
	
	@DBField 	
	private Date requestDate;
	
	@DBField 	
	private Date approvalDate;
	
	@DBField 	
	private String approver;
	
	@DBField 	
	private String status;
	
	@DBField 	
	private String description;

	public Integer getHospitalId() {
		return hospitalId;
	}
	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	public Date getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getApprover() {
		return approver;
	}
	public void setApprover(String approver) {
		this.approver = approver;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	
}
