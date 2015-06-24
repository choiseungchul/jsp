/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class UserModel extends ManagedBaseModel{
	
	public static final String USER_TYPE_GENERAL = "G";
	public static final String USER_TYPE_HOSPITAL = "H";
	public static final String USER_TYPE_MANAGER = "M";
	
	public static final String USER_GENDER_MALE = "M";
	public static final String USER_GENDER_FEMALE = "F";
	
	/*public static final String USER_ADDRESSTYPE_HOUSE = "H";
	public static final String USER_ADDRESSTYPE_OFFICE = "O";*/
	public static final String USER_USERSTATUS_LOCK = "L";
	public static final String USER_USERSTATUS_ACTIVATE = "A";
	// 탈퇴처리 승인완료
	public static final String USER_USERSTATUS_DELETE = "D";
	// 탈퇴처리 승인대기
	public static final String USER_USERSTATUS_WITHDRAW_WAITING = "W";
	
	@DBField
	private String account;
	
	@DBField
	private String password;
	
	@DBField
	private String userType;
	
	@DBField
	private String email;
	
	@DBField
	private String tel;
	
	@DBField
	private String mobile;
	
	@DBField
	private String address;
	
	@DBField
	private String postalCode;
	
	@DBField
	private String addressType;
	
	@DBField
	private Integer loginCount;
	
	@DBField
	private Date lastLoginDate;
	
	@DBField
	private Date lastPasswordChangeDate;
	
	@DBField
	private String isSubscribe;
	
	@DBField
	private String gender;
	
	@DBField
	private String nickname;
	
	@DBField
	private String registrationNo;
	
	@DBField
	private String birthday;
	
	@DBField
	private String userStatus;
	
	@DBField
	private Integer hospitalId;

//	private String tel1;
//	private String tel2;
//	private String tel3;
//	private String mobile1;
//	private String mobile2;
//	private String mobile3;
//	private String address1;
//	private String address2;
//	private String postalCode1;
//	private String postalCode2;
	private String password1;
	//private String email;
	private String email2;
	private String email3;
	
	private String isFbUser;
	private String facebookId;
	private String ageGroup;
	
	private String hospitalAccepted;
	
	
	
	public String getHospitalAccepted() {
		return hospitalAccepted;
	}

	public void setHospitalAccepted(String hospitalAccepted) {
		this.hospitalAccepted = hospitalAccepted;
	}

	public String getAgeGroup() {
		return ageGroup;
	}

	public void setAgeGroup(String ageGroup) {
		this.ageGroup = ageGroup;
	}

	public String getFacebookId() {
		return facebookId;
	}

	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}
	
	public String getIsFbUser() {
		return isFbUser;
	}

	public void setIsFbUser(String isFbUser) {
		this.isFbUser = isFbUser;
	}
	
	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getAddressType() {
		return addressType;
	}

	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}

	public Integer getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(Integer loginCount) {
		this.loginCount = loginCount;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getLastPasswordChangeDate() {
		return lastPasswordChangeDate;
	}

	public void setLastPasswordChangeDate(Date lastPasswordChangeDate) {
		this.lastPasswordChangeDate = lastPasswordChangeDate;
	}

	public String getIsSubscribe() {
		return isSubscribe;
	}

	public void setIsSubscribe(String isSubscribe) {
		this.isSubscribe = isSubscribe;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getRegistrationNo() {
		return registrationNo;
	}

	public void setRegistrationNo(String registrationNo) {
		this.registrationNo = registrationNo;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getPassword1() {
		return password1;
	}

	public void setPassword1(String password1) {
		this.password1 = password1;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getEmail3() {
		return email3;
	}

	public void setEmail3(String email3) {
		this.email3 = email3;
	}
	
	
}
