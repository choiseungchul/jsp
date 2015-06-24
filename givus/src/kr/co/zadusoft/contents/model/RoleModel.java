package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class RoleModel extends BaseModel
{
	@DBField
	private String name;
	@DBField
	private String code;
	@DBField
	private String description;
	
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getCode()
	{
		return code;
	}
	public void setCode(String code)
	{
		this.code = code;
	}
	public String getDescription()
	{
		return description;
	}
	public void setDescription(String description)
	{
		this.description = description;
	}
}
