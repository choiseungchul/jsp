package kr.co.zadusoft.contents.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/___/renew")
public class RenewEtcController {

	@Autowired
	private SqlSession sqlsession;

	@RequestMapping(value = "/agreement", method = RequestMethod.GET)
	public ModelAndView agreement(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView("givus_v2/etc/agreement");

		return mv;
	}

	@RequestMapping(value = "/privacy", method = RequestMethod.GET)
	public ModelAndView privacy(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView("givus_v2/etc/privacy");

		return mv;
	}

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public ModelAndView test(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView("dynamic/web/json");

		return mv;
	}

	@RequestMapping(value = "/smartPopupUpload", method = RequestMethod.POST)
	public ModelAndView smartPopupUpload(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView();
		
		
		
		
		return mv;
		
	}
	
	@RequestMapping(value = "/imageupload", method = RequestMethod.POST)
	public ModelAndView writeBoard(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String filename = "";
		String filenameFront = "";
		String filenameExt = "";
		String convFilename = "";
		
		FileSystemResource uploadDir = new FileSystemResource(
				"d:/givus_repository");

		MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
		MultipartFile file = multipart.getFile("Filedata");
		String callBack = multipart.getParameter("callback_func");
		
		if (!file.isEmpty()) {

			filename = file.getOriginalFilename();
			filenameFront = filename.substring(filename.lastIndexOf("."));
			filenameExt = filename.substring(filename.lastIndexOf("."),
					filename.length());
			// convFilename = Tool.getCurrentDayTimeMill() + filenameExt;
			convFilename = "";
			
			try {
				if (file.getSize() > 0) {
					File out = new File(uploadDir.getPath() + "/"
							+ UUID.randomUUID() + filenameExt);
					FileCopyUtils.copy(file.getBytes(), out);
					convFilename = out.getName();
					
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		
		json.put("filename", convFilename);
		json.put("callback_func", callBack);
		
		mv.addObject("result", json.toJSONString());
		
//		model.addAttribute("filename", convFilename);
//		model.addAttribute("callback_func", callBack);
		return mv;
	}

}
