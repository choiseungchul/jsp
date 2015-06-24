/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.util;

import java.util.List;

import javax.servlet.ServletException;

import kr.co.zadusoft.contents.model.FileModel;

import org.json.simple.JSONObject;

import dynamic.util.HttpServiceContext;

public class FileUploadUtil {

	/**
	 * FileModel 의 정보를 json 데이터로 변환한다.
	 * 변환된 json 데이터는 첨부파일 리스트 뷰를 구성하는데 사용된다.
	 * @param files
	 * @throws ServletException
	 */
	@SuppressWarnings("unchecked")
	public static void prepareDownloadJSON( List<FileModel> files) throws ServletException{
		
		if( files != null){
			String contextPath = HttpServiceContext.getContextPath();
			for( FileModel file : files){
				JSONObject jsono = new JSONObject();
				jsono.put("id", String.valueOf( file.getId())); 
				jsono.put("name", file.getName());
				jsono.put("size", file.getSize());
				jsono.put("url", contextPath + "/___/file/get/" + file.getId());
				jsono.put("thumbnailUrl", contextPath + "/___/file/thumb/"+ file.getId() + "/100");
				jsono.put("deleteUrl", contextPath + "/___/file/delete/" + file.getId());
				jsono.put("deleteType", "GET");
				
				file.getRenderedData().put( "json", jsono.toJSONString());
			}
		}
	}
}
