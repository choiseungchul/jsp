/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import dynamic.util.StringUtil;
import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderDate;

/**
 * 1일 이내는 HH:SS
 * 1년 이내는 MM-dd
 * 그 이후는 yyyy-MM-dd
 * 의 포맷으로 표시한다.
 * @author kidong
 *
 */
public class RenderDate2 extends RenderDate{
	
	public static final String HHmm = "HH:mm";
	public static final String MMdd = "MM-dd";
	public static final String yyyyMMdd = "yyyy-MM-dd";
	
	public static final SimpleDateFormat SDF_HHmm = new SimpleDateFormat( HHmm);
	public static final SimpleDateFormat SDF_MMdd = new SimpleDateFormat( MMdd);
	public static final SimpleDateFormat SDF_yyyyMMdd = new SimpleDateFormat( yyyyMMdd);
	
	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		Date vDate = (Date)value;
		
		String today = SDF_yyyyMMdd.format( new Date());
		String dateStr = SDF_yyyyMMdd.format( vDate);
		if( today.equals( dateStr)){
			return SDF_HHmm.format( vDate);
		}else{
			String[] arrToday = StringUtil.separate( today, "-");
			String[] arrDateStr = StringUtil.separate( dateStr, "-");
			
			if( arrToday[0].equals( arrDateStr[0])){
				return SDF_MMdd.format( vDate);
			}else{
				return dateStr;
			}
		}
	}
}
