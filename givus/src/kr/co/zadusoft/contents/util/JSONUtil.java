/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.lang.reflect.Method;
import java.util.Iterator;

import kr.co.zadusoft.contents.model.CategoryModel;

import org.json.simple.JSONObject;
import org.junit.Test;

import dynamic.util.StringUtil;
import dynamic.web.util.MethodCache;
import dynamic.web.util.ObjectUtil;

public class JSONUtil {
	public static Object convert( JSONObject json, Object target) throws ClassNotFoundException, Exception{
		Iterator itKeys = json.keySet().iterator();
		while( itKeys.hasNext()){
			String key = (String)itKeys.next();
			
			Object value = json.get(key);
			if( value != null && !value.equals( "")){
			
				Method getMethod = MethodCache.searchMethod( target.getClass().getName(), "get" + StringUtil.capitalize( key));
				Class returnType = getMethod.getReturnType();
				
				if( returnType.getName().equals( "int") || returnType.equals( Integer.class)){
					value = Integer.parseInt( String.valueOf(json.get( key)));
				}else if( returnType.equals( String.class)){
					value = String.valueOf(json.get( key));
				}
				else if(returnType.getName().equals( "long") || returnType.equals( Long.class)){
					value = Long.parseLong( String.valueOf(json.get( key)));
				}else if(returnType.getName().equals( "float") || returnType.equals( Float.class)){
					value = Float.parseFloat( String.valueOf(json.get( key)));
				}else if(returnType.getName().equals( "double") || returnType.equals( Double.class)){
					value = Double.parseDouble( String.valueOf(json.get( key)));
				}else if(returnType.getName().equals( "short") || returnType.equals( Short.class)){
					value = Short.parseShort( String.valueOf(json.get( key)));
				}
				
				ObjectUtil.setProperty( target, key, value);
			}else{
				ObjectUtil.setProperty( target, key, null);
			}
		}
		
		return null;
	}
	
	@Test
	public void testConvert() throws Exception{
		JSONObject json = new JSONObject();
		json.put("id", "23");
		json.put("name", "sample name");
		
		CategoryModel model = new CategoryModel();
		convert( json, model);
		
		System.out.println( model.getId());
		System.out.println( model.getName());
	}
}
