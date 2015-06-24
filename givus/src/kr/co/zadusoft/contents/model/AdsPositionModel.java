package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class AdsPositionModel extends BaseModel {

	@DBField
	private String name;
	
	@DBField
	private Integer width;
	
	@DBField
	private Integer height;
	
	@DBField
	private Integer unitCost;
	
	@DBField
	private String description;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getWidth() {
		return width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
