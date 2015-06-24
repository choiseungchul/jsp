package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class ZipcodeZibunModel  extends ManagedBaseModel 
{
	//우편번호	일련번호	시도	시군구	읍면동	리	도서	산번지	시작번지주	시작번지부	끝번지주	끝번지부	아파트/건물명	동범위시작	동범위끝	변경일	주소
	@DBField private String postalCode;
	@DBField private String postalNo;
	@DBField private String city;
	@DBField private String siGunGu;
	@DBField private String eupMyunDong;
	@DBField private String ri;
	@DBField private String doSeo;
	@DBField private String san;
	@DBField private String zibunStartNo;
	@DBField private String zibunStartSubNo;
	@DBField private String zibunEndNo;
	@DBField private String zibunEndSubNo;
	@DBField private String buildingName;
	@DBField private String dongRangeStart;
	@DBField private String dongRangeEnd;
	@DBField private String fullAddress;
	
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getPostalNo() {
		return postalNo;
	}
	public void setPostalNo(String postalNo) {
		this.postalNo = postalNo;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getSiGunGu() {
		return siGunGu;
	}
	public void setSiGunGu(String siGunGu) {
		this.siGunGu = siGunGu;
	}
	public String getEupMyunDong() {
		return eupMyunDong;
	}
	public void setEupMyunDong(String eupMyunDong) {
		this.eupMyunDong = eupMyunDong;
	}
	public String getRi() {
		return ri;
	}
	public void setRi(String ri) {
		this.ri = ri;
	}
	public String getDoSeo() {
		return doSeo;
	}
	public void setDoSeo(String doSeo) {
		this.doSeo = doSeo;
	}
	public String getSan() {
		return san;
	}
	public void setSan(String san) {
		this.san = san;
	}
	public String getZibunStartNo() {
		return zibunStartNo;
	}
	public void setZibunStartNo(String zibunStartNo) {
		this.zibunStartNo = zibunStartNo;
	}
	public String getZibunStartSubNo() {
		return zibunStartSubNo;
	}
	public void setZibunStartSubNo(String zibunStartSubNo) {
		this.zibunStartSubNo = zibunStartSubNo;
	}
	public String getZibunEndNo() {
		return zibunEndNo;
	}
	public void setZibunEndNo(String zibunEndNo) {
		this.zibunEndNo = zibunEndNo;
	}
	public String getZibunEndSubNo() {
		return zibunEndSubNo;
	}
	public void setZibunEndSubNo(String zibunEndSubNo) {
		this.zibunEndSubNo = zibunEndSubNo;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public String getDongRangeStart() {
		return dongRangeStart;
	}
	public void setDongRangeStart(String dongRangeStart) {
		this.dongRangeStart = dongRangeStart;
	}
	public String getDongRangeEnd() {
		return dongRangeEnd;
	}
	public void setDongRangeEnd(String dongRangeEnd) {
		this.dongRangeEnd = dongRangeEnd;
	}
	public String getFullAddress() {
		return fullAddress;
	}
	public void setFullAddress(String fullAddress) {
		this.fullAddress = fullAddress;
	}
}
