package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class HospitalStatsModel extends BaseModel {

	@DBField
	private Integer hospitalId;
	@DBField
	private Integer oralDoctorCount;
	@DBField
	private Integer dentalDoctorCount;
	@DBField
	private Integer breastDoctorCount;
	@DBField
	private Integer orthodonticDoctorCount;
	@DBField
	private Integer otolaryngologyDoctorCount;
	@DBField
	private Integer surgeryDoctorCount;
	@DBField
	private Integer plasticSurgeryDoctorCount;
	@DBField
	private Integer anestheticDoctorCount;
	@DBField
	private Integer familyMedicineDoctorCount;
	@DBField
	private Integer generalDoctorCount;
	@DBField
	private Integer clinicalDoctorCount;
	@DBField
	private Integer obesityDoctorCount;
	@DBField
	private Integer dermatologistDoctorCount;
	@DBField
	private Integer prostheticDoctorCount;
	@DBField
	private Integer implantsDoctorCount;
	@DBField
	private Integer obstetricsDoctorCount;
	
	private Integer totalDoctorsCount;
	public Integer getHospitalId() {
		return hospitalId;
	}
	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}
	public Integer getOralDoctorCount() {
		return oralDoctorCount;
	}
	public void setOralDoctorCount(Integer oralDoctorCount) {
		this.oralDoctorCount = oralDoctorCount;
	}
	public Integer getDentalDoctorCount() {
		return dentalDoctorCount;
	}
	public void setDentalDoctorCount(Integer dentalDoctorCount) {
		this.dentalDoctorCount = dentalDoctorCount;
	}
	public Integer getBreastDoctorCount() {
		return breastDoctorCount;
	}
	public void setBreastDoctorCount(Integer breastDoctorCount) {
		this.breastDoctorCount = breastDoctorCount;
	}
	public Integer getOrthodonticDoctorCount() {
		return orthodonticDoctorCount;
	}
	public void setOrthodonticDoctorCount(Integer orthodonticDoctorCount) {
		this.orthodonticDoctorCount = orthodonticDoctorCount;
	}
	public Integer getOtolaryngologyDoctorCount() {
		return otolaryngologyDoctorCount;
	}
	public void setOtolaryngologyDoctorCount(Integer otolaryngologyDoctorCount) {
		this.otolaryngologyDoctorCount = otolaryngologyDoctorCount;
	}
	public Integer getSurgeryDoctorCount() {
		return surgeryDoctorCount;
	}
	public Integer getPlasticSurgeryDoctorCount() {
		return plasticSurgeryDoctorCount;
	}
	public void setPlasticSurgeryDoctorCount(Integer plasticSurgeryDoctorCount) {
		this.plasticSurgeryDoctorCount = plasticSurgeryDoctorCount;
	}
	public void setSurgeryDoctorCount(Integer surgeryDoctorCount) {
		this.surgeryDoctorCount = surgeryDoctorCount;
	}
	public Integer getAnestheticDoctorCount() {
		return anestheticDoctorCount;
	}
	public void setAnestheticDoctorCount(Integer anestheticDoctorCount) {
		this.anestheticDoctorCount = anestheticDoctorCount;
	}
	public Integer getFamilyMedicineDoctorCount() {
		return familyMedicineDoctorCount;
	}
	public void setFamilyMedicineDoctorCount(Integer familyMedicineDoctorCount) {
		this.familyMedicineDoctorCount = familyMedicineDoctorCount;
	}
	public Integer getGeneralDoctorCount() {
		return generalDoctorCount;
	}
	public void setGeneralDoctorCount(Integer generalDoctorCount) {
		this.generalDoctorCount = generalDoctorCount;
	}
	public Integer getClinicalDoctorCount() {
		return clinicalDoctorCount;
	}
	public void setClinicalDoctorCount(Integer clinicalDoctorCount) {
		this.clinicalDoctorCount = clinicalDoctorCount;
	}
	public Integer getObesityDoctorCount() {
		return obesityDoctorCount;
	}
	public void setObesityDoctorCount(Integer obesityDoctorCount) {
		this.obesityDoctorCount = obesityDoctorCount;
	}
	public Integer getDermatologistDoctorCount() {
		return dermatologistDoctorCount;
	}
	public void setDermatologistDoctorCount(Integer dermatologistDoctorCount) {
		this.dermatologistDoctorCount = dermatologistDoctorCount;
	}
	public Integer getProstheticDoctorCount() {
		return prostheticDoctorCount;
	}
	public void setProstheticDoctorCount(Integer prostheticDoctorCount) {
		this.prostheticDoctorCount = prostheticDoctorCount;
	}
	public Integer getImplantsDoctorCount() {
		return implantsDoctorCount;
	}
	public void setImplantsDoctorCount(Integer implantsDoctorCount) {
		this.implantsDoctorCount = implantsDoctorCount;
	}
	public Integer getObstetricsDoctorCount() {
		return obstetricsDoctorCount;
	}
	public void setObstetricsDoctorCount(Integer obstetricsDoctorCount) {
		this.obstetricsDoctorCount = obstetricsDoctorCount;
	}
	
	public Integer getTotalDoctorsCount() {
		return totalDoctorsCount;
	}
	public void setTotalDoctorsCount(Integer totalDoctorsCount) {
		this.totalDoctorsCount = totalDoctorsCount;
	}
	public void setTotalDoctorsCount() {
		Integer totalDoctorsCount = 0;
		if ( oralDoctorCount != null) totalDoctorsCount += oralDoctorCount;
		if ( dentalDoctorCount != null) totalDoctorsCount += dentalDoctorCount;
		if ( breastDoctorCount != null) totalDoctorsCount += breastDoctorCount;
		if ( orthodonticDoctorCount != null) totalDoctorsCount += orthodonticDoctorCount;
		if ( otolaryngologyDoctorCount != null) totalDoctorsCount += otolaryngologyDoctorCount;
		if ( surgeryDoctorCount != null) totalDoctorsCount += surgeryDoctorCount;
		if ( plasticSurgeryDoctorCount != null) totalDoctorsCount += plasticSurgeryDoctorCount;
		if ( anestheticDoctorCount != null) totalDoctorsCount += anestheticDoctorCount;
		if ( familyMedicineDoctorCount != null) totalDoctorsCount += familyMedicineDoctorCount;
		if ( generalDoctorCount != null) totalDoctorsCount += generalDoctorCount;
		if ( clinicalDoctorCount != null) totalDoctorsCount += clinicalDoctorCount;
		if ( obesityDoctorCount != null) totalDoctorsCount += obesityDoctorCount;
		if ( dermatologistDoctorCount != null) totalDoctorsCount += dermatologistDoctorCount;
		if ( prostheticDoctorCount != null) totalDoctorsCount += prostheticDoctorCount;
		if ( implantsDoctorCount != null) totalDoctorsCount += implantsDoctorCount;
		if ( obstetricsDoctorCount != null) totalDoctorsCount += obstetricsDoctorCount;
		this.totalDoctorsCount = totalDoctorsCount;
	}	
}
