/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.io.File;

/**
 * 해당 폴더에 위치한 모든 이미지에 대한 properties 를 생성한다.
 * @author kidong
 *
 */
public class ContentsImagePropertiesGenerator {
	
	/**
	 * 이미지가 위치해 있는 폴더 Full Path
	 */
	private String folder;
	
	private String keyPrefix;
	
	private String valuePrefix;
	
	public ContentsImagePropertiesGenerator( String folder, String keyPrefix, String valuePrefix){
		this.folder = folder;
		this.keyPrefix = keyPrefix;
		this.valuePrefix = valuePrefix;
	}
	
	public void generate() throws Exception{
		File file = new File( folder);
		File[] files = file.listFiles();
		for( File _file : files){
			if( _file.isFile()){
				String fileName = _file.getName();
				StringBuilder sbKey = new StringBuilder();
				if( keyPrefix != null){
					sbKey.append( keyPrefix);
				}
				sbKey.append( fileName.substring( 0, fileName.lastIndexOf( ".")))
					.append("=");
				if( valuePrefix != null){
					sbKey.append( valuePrefix);
				}
				sbKey.append( fileName);
				
				System.out.println(sbKey);
			}
		}
	}
	
	public static void main(String[] args) throws Exception{
		String folder = "g:/sProject/GIVUS/WebContent/images/givus";
		String keyPrefix = "g_";
		String valuePrefix = "/images/givus/";
		
		ContentsImagePropertiesGenerator generator = new ContentsImagePropertiesGenerator( folder, keyPrefix, valuePrefix);
		generator.generate();
	}
}
