package kr.co.zadusoft.contents.view;

import java.util.ArrayList;
import java.util.List;

import org.springframework.validation.Errors;

import dynamic.ibatis.util.SearchCondition;
import dynamic.util.StringUtil;
import dynamic.web.view.ValidatorSimple;

public class GivusValidatorSimple extends ValidatorSimple {
	
/*	private static final String MSG_ISNULL = "validator.null";
	private static final String MSG_ISNOTUNIQUE = "validator.notunique";
	private static final String MSG_ISNOTANUMBER = "validator.isnotanumber";*/
	private static final String MSG_ISSAMEVALUE = "validator.issamevalue";
	
/*	protected String notnull;
	protected String unique;
	protected String number;*/
	protected String samevalue;
	
/*	protected String[] notnulls;
	protected String[] uniques;
	protected String[] numbers;*/
	protected String[] samevalues;
	
	protected List<SearchCondition> uniqueConditions = new ArrayList<SearchCondition>();
	
	public void init()
	{
		/*notnulls = StringUtil.splitString(notnull, ",");
		uniques = StringUtil.splitString(unique, ",");
		numbers = StringUtil.splitString(number, ",");*/
		super.init();
		samevalues = StringUtil.splitString(samevalue, ",");
	}
	
	public boolean supports(Class clazz)
	{
		return super.supports(clazz);
	}

	public void validate(Object target, Errors errors)
	{
		super.validate(target, errors);
		try
		{
			checkSameValue(target, errors);
		}
		catch( Exception e)
		{
			e.printStackTrace();
		}
	}
	
	protected void checkSameValue( Object target, Errors errors) throws Exception
	{
		if( samevalues == null) return;
		Object compareValue = null;
		for( String field : samevalues)
		{
			Object value = errors.getFieldValue(field);
			if( StringUtil.isNotNull(String.valueOf( value)))
			{
				if ( compareValue != null && !compareValue.equals("")){
					if( !value.equals( compareValue))
					{
						errors.rejectValue( field, null, null, getMsgProperties().getProperty( MSG_ISSAMEVALUE));
					}
				}
				compareValue = value;
			}
		}
	}

	public String getSamevalue() {
		return samevalue;
	}

	public void setSamevalue(String samevalue) {
		this.samevalue = samevalue;
	}

	public String[] getSamevalues() {
		return samevalues;
	}

	public void setSamevalues(String[] samevalues) {
		this.samevalues = samevalues;
	}
	
	
}
