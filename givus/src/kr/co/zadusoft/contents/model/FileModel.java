/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.HashMap;
import java.util.Map;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class FileModel extends ManagedBaseModel{
	
	public static Map<String, String> fileTypes = new HashMap<String, String>();
	static{
		fileTypes.put("jpg", FileModel.FILE_TYPE_IMAGE);
		fileTypes.put("png", FileModel.FILE_TYPE_IMAGE);
		fileTypes.put("gif", FileModel.FILE_TYPE_IMAGE);
		fileTypes.put("avi", FileModel.FILE_TYPE_MOVIE);
		fileTypes.put("mp4", FileModel.FILE_TYPE_MOVIE);
		fileTypes.put("mp3", FileModel.FILE_TYPE_AUDIO);
		fileTypes.put("ogg", FileModel.FILE_TYPE_AUDIO);
		fileTypes.put("zip", FileModel.FILE_TYPE_ZIP);
		fileTypes.put("7z", FileModel.FILE_TYPE_ZIP);
		fileTypes.put("doc", FileModel.FILE_TYPE_DOC);
		fileTypes.put("docx", FileModel.FILE_TYPE_DOC);
		fileTypes.put("xls", FileModel.FILE_TYPE_DOC);
		fileTypes.put("xlsx", FileModel.FILE_TYPE_DOC);
	}
	
	public static final String RELATIONTYPE_THUMB = "file_thumb";
	public static final String RELATIONTYPE_HOSPITAL_GALLERY = "hospital_gallery";
	public static final String RELATIONTYPE_HOSPITAL = "hospital";
	public static final String RELATIONTYPE_POSTING_CONTENTS = "posting_contents";
	
	public static final String FILE_TYPE_IMAGE = "I";
	public static final String FILE_TYPE_MOVIE = "M";
	public static final String FILE_TYPE_AUDIO = "A";
	public static final String FILE_TYPE_ZIP = "Z";
	public static final String FILE_TYPE_DOC = "D";
	public static final String FILE_TYPE_ETC = "E";
	
	@DBField
	private String path;
	
	@DBField
	private Integer size;
	
	@DBField
	private String fileType;
	
	@DBField
	private Integer relationId;
	
	@DBField
	private String relationType;

	@DBField
	private Integer downloadCount;
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public Integer getRelationId() {
		return relationId;
	}

	public void setRelationId(Integer relationId) {
		this.relationId = relationId;
	}

	public String getRelationType() {
		return relationType;
	}

	public void setRelationType(String relationType) {
		this.relationType = relationType;
	}

	public Integer getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(Integer downloadCount) {
		this.downloadCount = downloadCount;
	}
}
