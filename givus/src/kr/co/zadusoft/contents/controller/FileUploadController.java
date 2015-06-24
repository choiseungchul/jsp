/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.Editor;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.PostingService;
import kr.co.zadusoft.contents.util.FileUploadHandler;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import dynamic.util.HttpServiceContext;
import dynamic.util.StringUtil;

/** Controller's RequestMapping must start with ___ */
/** CHECK Transaction, Access */
@Controller
@RequestMapping(value = "/___/file")
public class FileUploadController {

	Logger Log = Logger.getLogger(FileUploadController.class);

	@Autowired
	private FileUploadHandler fileUploadHandler;
	@Autowired
	private FileService fileService;
	@Autowired
	private PostingService postingService;

	public FileUploadHandler getFileUploadHandler() {
		return fileUploadHandler;
	}

	public void setFileUploadHandler(FileUploadHandler fileUploadHandler) {
		this.fileUploadHandler = fileUploadHandler;
	}

	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}

	@RequestMapping(value = "/thumb/{id}/{size}", method = RequestMethod.GET)
	public void getThumb(@PathVariable Integer id, @PathVariable Integer size,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		FileModel model = (FileModel) fileService.get(id);
		if (model != null
				&& FileModel.FILE_TYPE_IMAGE.equals(model.getFileType())) {

			InputStream is = fileUploadHandler.getThumbInputStream(
					model.getPath(), size);

			// check thumbnail exist
			if (is == null) {
				fileUploadHandler.createThumbnail(model, size);
				is = fileUploadHandler.getThumbInputStream(model.getPath(),
						size);
			}

			int bytes = 0;
			ServletOutputStream op = response.getOutputStream();

			response.setContentType(getMimeType(is));
			// response.setContentLength((int) thumb.length());
			response.setHeader("Content-Disposition", "inline; filename=\""
					+ model.getName() + "\"");

			DataInputStream in = null;
			try {
				byte[] bbuf = new byte[1024];
				in = new DataInputStream(is);
				while ((in != null) && ((bytes = in.read(bbuf)) != -1)) {
					op.write(bbuf, 0, bytes);
				}
				op.flush();
			} finally {
				if (is != null) {
					is.close();
					is = null;
				}
				if (in != null) {
					in.close();
					in = null;
				}
				if (op != null) {
					op.close();
					op = null;
				}
			}
		}
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public void delete(@PathVariable Integer id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		FileModel model = (FileModel) fileService.get(id);

		if (model != null) {

			fileUploadHandler.delete(model);

			fileService.delete(model.getId());

			// decrease file count
			if (postingService.getTableName().equals(model.getRelationType())) {
				PostingModel pmodel = (PostingModel) postingService.get(model
						.getRelationId());
				pmodel.setFileCount(pmodel.getFileCount() - 1);
				postingService.update(pmodel);
			}
		}
	}

	@RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
	public void get(@PathVariable Integer id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FileModel model = (FileModel) fileService.get(id);
		InputStream is = fileUploadHandler.getFileInputStream(model.getPath());
		if (is != null) {
			int bytes = 0;
			ServletOutputStream op = response.getOutputStream();

			response.setContentType(getMimeType(is));
			// response.setContentLength((int) is.length());
			response.setHeader("Content-Disposition", "inline; filename=\""
					+ model.getName() + "\"");

			DataInputStream in = null;
			try {
				byte[] bbuf = new byte[1024];
				in = new DataInputStream(is);
				while ((in != null) && ((bytes = in.read(bbuf)) != -1)) {
					op.write(bbuf, 0, bytes);
				}
				op.flush();
			} finally {
				if (is != null) {
					is.close();
					is = null;
				}
				if (in != null) {
					in.close();
					in = null;
				}
				if (op != null) {
					op.close();
					op = null;
				}
			}
		}
	}

	public void get2(@PathVariable Integer id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FileModel model = (FileModel) fileService.get(id);
		File file = new File(model.getPath());
		if (file.exists()) {
			int bytes = 0;
			ServletOutputStream op = response.getOutputStream();

			response.setContentType(getMimeType(file));
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "inline; filename=\""
					+ model.getName() + "\"");

			FileInputStream fis = null;
			DataInputStream in = null;
			try {
				byte[] bbuf = new byte[1024];
				fis = new FileInputStream(file);
				in = new DataInputStream(fis);
				while ((in != null) && ((bytes = in.read(bbuf)) != -1)) {
					op.write(bbuf, 0, bytes);
				}
				op.flush();
			} finally {
				if (fis != null) {
					fis.close();
					fis = null;
				}
				if (in != null) {
					in.close();
					in = null;
				}
				if (op != null) {
					op.close();
					op = null;
				}
			}
		}
	}

	@RequestMapping(value = "/download/{id}", method = RequestMethod.GET)
	public void download(@PathVariable Integer id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		FileModel model = (FileModel) fileService.get(id);
		InputStream is = null;
		DataInputStream in = null;
		ServletOutputStream op = null;
		try {
			is = fileUploadHandler.getFileInputStream(model.getPath());
			if (is != null) {
				int bytes = 0;
				op = response.getOutputStream();

				response.setContentType("application/x-msdownload");
				response.setContentLength(model.getSize());
				response.setHeader("Content-Disposition", "inline; filename=\""
						+ model.getName() + "\"");

				byte[] bbuf = new byte[1024];
				in = new DataInputStream(is);
				while ((in != null) && ((bytes = in.read(bbuf)) != -1)) {
					op.write(bbuf, 0, bytes);
				}
				op.flush();

				// increase download count
				model.setDownloadCount(model.getDownloadCount() == null ? 1
						: model.getDownloadCount());
				fileService.update(model);
			}
		} finally {
			if (is != null) {
				is.close();
				is = null;
			}
			if (in != null) {
				in.close();
				in = null;
			}
			if (op != null) {
				op.close();
				op = null;
			}
		}
	}

	@RequestMapping("/file_uploader")
	public ModelAndView file_uploader(HttpServletRequest request,
			HttpServletResponse response, Editor editor) {
		
		ModelAndView mv = new ModelAndView();
		
		String return1 = request.getParameter("callback");
		String return2 = "?callback_func="
				+ request.getParameter("callback_func");
		String return3 = "";
		String name = "";
		try {
			if (editor.getFiledata() != null
					&& editor.getFiledata().getOriginalFilename() != null
					&& !editor.getFiledata().getOriginalFilename().equals("")) {
				// 기존 상단 코드를 막고 하단코드를 이용
				name = editor
						.getFiledata()
						.getOriginalFilename()
						.substring(
								editor.getFiledata().getOriginalFilename()
										.lastIndexOf(File.separator) + 1);
				String filename_ext = name.substring(name.lastIndexOf(".") + 1);
				filename_ext = filename_ext.toLowerCase();
				String[] allow_file = { "jpg", "png", "bmp", "gif" };
				int cnt = 0;
				for (int i = 0; i < allow_file.length; i++) {
					if (filename_ext.equals(allow_file[i])) {
						cnt++;
					}
				}
				if (cnt == 0) {
					return3 = "&errstr=" + name;
				} else {
					// 파일 기본경로
					
					String filePath = fileUploadHandler.getRepository() + "/";
					File file = new File(filePath);
					if (!file.exists()) {
						file.mkdirs();
					}
					String realFileNm = "";
					SimpleDateFormat formatter = new SimpleDateFormat(
							"yyyyMMddHHmmss");
					String today = formatter.format(new java.util.Date());
					realFileNm = today + UUID.randomUUID().toString()
							+ name.substring(name.lastIndexOf("."));
					String rlFileNm = filePath + realFileNm;
					// /////////////// 서버에 파일쓰기 /////////////////
					editor.getFiledata().transferTo(new File(rlFileNm));
					// /////////////// 서버에 파일쓰기 /////////////////

					// 파일 정보를 디비에 저장한다.
					FileModel fileModel = new FileModel();
					fileModel.setPath(rlFileNm);
					fileModel.setName(name);
					// i 를 넣는다
					fileModel.setFileType("I");
					fileModel.setSize((int) editor.getFiledata().getSize());

					fileModel = (FileModel) fileService.create(fileModel);
					
//					System.out.println("file id= " + fileModel.getId());
					
					return3 += "&bNewLine=true";
		    		return3 += "&sFileName="+ name;
		    		return3 += "&sFileURL=/___/file/get/"+fileModel.getId();
					
//					json.put("", paramV)
		    		
		    		mv.setViewName("redirect:" + return1 + return2 + return3);
					
				}
			} else {
				return3 += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public ModelAndView upload(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		if (HttpServiceContext.isRequestMethodPost()
				&& request instanceof MultipartHttpServletRequest) {

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Iterator<String> fileNames = multipartRequest.getFileNames();
			List<FileModel> fileModels = new ArrayList<FileModel>();
			while (fileNames.hasNext()) {
				MultipartFile file = multipartRequest
						.getFile((String) fileNames.next());
				if (!file.isEmpty()) {
					String path = fileUploadHandler.saveFile(file);

					// 파일 정보를 디비에 저장한다.
					FileModel fileModel = new FileModel();
					fileModel.setPath(path);
					fileModel.setName(file.getOriginalFilename());
					fileModel.setFileType(checkFileType(file
							.getOriginalFilename()));
					fileModel.setSize((int) file.getSize());

					// relationId, relationType
					String relationId = multipartRequest
							.getParameter("relationId");
					String relationType = multipartRequest
							.getParameter("relationType");
					if (relationId != null) {
						fileModel.setRelationId(Integer.parseInt(relationId));
					}
					fileModel.setRelationType(relationType);

					fileService.create(fileModel);

					fileModels.add(fileModel);
				}
			}

			PrintWriter writer = response.getWriter();
			response.setContentType("text/html");
			JSONObject json = new JSONObject();
			JSONArray jsonArray = new JSONArray();
			try {
				String contextPath = HttpServiceContext.getContextPath();
				for (FileModel model : fileModels) {
					JSONObject jsono = new JSONObject();
					jsono.put("id", String.valueOf(model.getId()));
					jsono.put("name", model.getName());
					jsono.put("size", model.getSize());
					jsono.put("url",
							contextPath + "/___/file/get/" + model.getId());
					jsono.put("thumbnailUrl", contextPath + "/___/file/thumb/"
							+ model.getId() + "/100");
					jsono.put("deleteUrl", contextPath + "/___/file/delete/"
							+ model.getId());
					jsono.put("deleteType", "GET");
					jsonArray.add(jsono);
				}
				json.put("files", jsonArray);
			} catch (Exception e) {
				throw new RuntimeException(e);
			} finally {
				writer.write(json.toString());
				writer.close();
			}
		} else {

		}

		return null;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/upload2", method = RequestMethod.POST)
	public ModelAndView upload2(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		if (HttpServiceContext.isRequestMethodPost()
				&& request instanceof MultipartHttpServletRequest) {

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Iterator<String> fileNames = multipartRequest.getFileNames();
			List<FileModel> fileModels = new ArrayList<FileModel>();
			while (fileNames.hasNext()) {
				MultipartFile file = multipartRequest
						.getFile((String) fileNames.next());
				if (!file.isEmpty()) {
					String path = fileUploadHandler.saveFile(file);

					// 파일 정보를 디비에 저장한다.
					FileModel fileModel = new FileModel();
					fileModel.setPath(path);
					fileModel.setName(file.getOriginalFilename());
					fileModel.setFileType(checkFileType(file
							.getOriginalFilename()));
					fileModel.setSize((int) file.getSize());

					fileService.create(fileModel);

					fileModels.add(fileModel);
				}
			}

			String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
			String contextPath = HttpServiceContext.getContextPath();
			String url = contextPath + "/___/file/get/"
					+ fileModels.get(0).getId();
			// String out = "<script>window.parent.CKEDITOR.tools.callFunction("
			// + CKEditorFuncNum + ",'" + url + "');</script>";
			response.setHeader("Content-type", "text/html"); // 해당 Content-type
																// 을 설정하지 않아도
																// local에서는
																// 정상적으로 작동하지만 실
																// 서버 환경에서는 작동하지
																// 않는다. default
																// 로 설정된
																// Content-type
																// 이 없어서 인듯...
			String out = "<script>window.parent.ckeditorUploadComplete("
					+ CKEditorFuncNum + ",'" + url + "',"
					+ fileModels.get(0).getId() + ");</script>";

			PrintWriter writer = response.getWriter();
			writer.write(out);
			writer.close();
		}

		return null;
	}

	protected String getMimeType(File file) {
		String mimetype = "";
		if (file.exists()) {
			mimetype = URLConnection.guessContentTypeFromName(file.getName());
		}
		return mimetype;
	}

	protected String getMimeType(InputStream is) throws IOException {
		String mimetype = "";
		if (is != null) {
			mimetype = URLConnection.guessContentTypeFromStream(is);
		}
		return mimetype;
	}

	protected String checkFileType(String fileName) {
		String ext = StringUtil.getFileExt(fileName);
		String fileType = FileModel.fileTypes.get(ext.toLowerCase());
		if (fileType == null) {
			return FileModel.FILE_TYPE_ETC;
		}

		return fileType;
	}
}
