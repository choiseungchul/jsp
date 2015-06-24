package kr.co.zadusoft.givus.util;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class RequestUtil { 

	public static HashMap<String, Object> getParameterMap(HttpServletRequest request){ 

		HashMap<String, Object> parameterMap = new HashMap<String, Object>(); 
		Enumeration<String> enums = request.getParameterNames(); 
		while(enums.hasMoreElements()){ 
			String paramName = (String)enums.nextElement(); 
			String[] parameters = request.getParameterValues(paramName); 

			// Parameter가 배열일 경우 
			if(parameters.length > 1){ 
				parameterMap.put(paramName, parameters); 
				// Parameter가 배열이 아닌 경우 
			}else{ 
				parameterMap.put(paramName, parameters[0]); 
			} 
		} 

		return parameterMap; 
	} 
}