package kr.co.zadusoft.givus.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.HospitalStatsModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalStatsService;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.controller.ListController;
import dynamic.web.func.FunctionHandler;
import dynamic.web.view.Dispatcher;

public class GivusListController extends ListController {
	private FileService fileService;

	private HospitalStatsService hospitalStatsService;
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public HospitalStatsService getHospitalStatsService() {
		return hospitalStatsService;
	}

	public void setHospitalStatsService(HospitalStatsService hospitalStatsService) {
		this.hospitalStatsService = hospitalStatsService;
	}

	@Override
	public Dispatcher getDispatcher(HttpServletRequest request, HttpServletResponse response, Parameter param) throws Exception {
		Dispatcher dispatcher = super.getDispatcher( request, response, param);
		
		if( FunctionHandler.equals( "funcHospitalRankingList", param.getFunctionId()))
		{
			List<HospitalModel> models = dispatcher.getDatas();
			
			for ( HospitalModel model : models){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition( "relationId", model.getId()));
				conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL)); //"hospital"
				
				FileModel fmodel = (FileModel)fileService.get(conditions);
				if( fmodel != null){ 
					model.setThumbFileId( fmodel.getId());
				}
				// 전문의 정보를 가져온다.
				HospitalStatsModel hospitalStatsModel = ( HospitalStatsModel)hospitalStatsService.get( new SearchCondition( "hospitalId", model.getId()));
				if( hospitalStatsModel != null){ 
					model.setHospitalStatsModel(hospitalStatsModel);
				}
			}
		}
		return dispatcher;
	}
}
