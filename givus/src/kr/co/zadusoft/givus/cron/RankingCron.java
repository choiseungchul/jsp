package kr.co.zadusoft.givus.cron;

import java.io.IOException;
import java.net.URL;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import kr.co.zadusoft.contents.model.RankingDataModel;
import kr.co.zadusoft.contents.model.RankingModel;
import kr.co.zadusoft.givus.util.GivusConstants;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.Scheduled;

import dynamic.util.DateUtil;
import dynamic.web.dao.DAException;

public class RankingCron{

	private Logger logger = Logger.getLogger( RankingCron.class);
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	private SqlSession sqlsession;
	
	public void generateTop100Ranking( Date startDate, Date endDate){
		
		logger.info( "START 전국 TOP100 RANKING");
		System.out.println( "startDate = " + startDate);
		System.out.println( "endDate = " + endDate);
		
		// 100순위까지가 아닌 1000순위까지 병원에 대한 순위
		HashMap<String, Object> top100Param = new HashMap<String, Object>();
		top100Param.put("start", 0);
		top100Param.put("limit", 1000);
		
		System.out.println("sqlsession : " + sqlsession);
		
		List<HashMap<String, Object>> datas = sqlsession.selectList("renew_ranking.top50", top100Param);
		
		System.out.println( "size=" + datas.size());
		
		if( datas != null){
			// create Ranking
			StringBuilder sbRankingName = new StringBuilder();
			sbRankingName.append( "전국 TOP100 (").append( DateUtil.formatDate( startDate, DateUtil.YYYYMMDD)).append( " ~ " ).append( DateUtil.formatDate( endDate, DateUtil.YYYYMMDD)).append(")");
			RankingModel rankingModel = new RankingModel();
			rankingModel.setName( sbRankingName.toString());
			rankingModel.setRankingType( RankingModel.RANKING_TYPE_TOP_100);
			rankingModel.setStartDate( startDate);
			rankingModel.setEndDate( endDate);
			
			System.out.println( " start generateRankingTop100 ");
			
			generateRankingData( rankingModel, datas);
		}
	}
	
	/**
	 * 광역시별 TOP 50
	 * @param locationCode
	 * @throws Exception
	 */
	public void generateTop10RankingByLocationCode( String locationCode, Date startDate, Date endDate) {
		
		logger.info( "START 광역시 TOP50 RANKING");
		
		// 광역시 50개씩
		HashMap<String, Object> top50byLocParam = new HashMap<>();
		top50byLocParam.put("start", 0);
		top50byLocParam.put("limit", 50);
		top50byLocParam.put("location", locationCode);
		
		List<HashMap<String, Object>> datas = sqlsession.selectList("renew_ranking.top50byLoc", top50byLocParam);
		
		List<HashMap<String, Object>> locations = sqlsession.selectList("renew_ranking.get_location");
		
		String locName = "";
		for(int i = 0 ; i < locations.size(); i++){
			String code = locations.get(i).get("code").toString();
			if(locationCode.equals(code)){
				locName = locations.get(i).get("name").toString();
				break;
			}
		}
		
		if( datas != null){
			// create Ranking
			StringBuilder sbRankingName = new StringBuilder();
			sbRankingName.append( locName ).append( " TOP10 (").append( DateUtil.formatDate( startDate, DateUtil.YYYYMMDD)).append( " ~ " ).append( DateUtil.formatDate( endDate, DateUtil.YYYYMMDD)).append(")");
			RankingModel rankingModel = new RankingModel();
			rankingModel.setName( sbRankingName.toString());
			rankingModel.setRankingType( RankingModel.RANKING_TYPE_MAJOR_CITY_10);
			if( locationCode != null)
				rankingModel.setRankingLocationCode( locationCode);
			rankingModel.setStartDate( startDate);
			rankingModel.setEndDate( endDate);
			
			generateRankingData( rankingModel, datas);
		}
	}
	
	/**
	 * 서울 TOP 50
	 * @param locationCode
	 * @throws Exception
	 */
//	public void generateSeoulTop50( Date startDate, Date endDate) throws DAException{
//		
//		logger.info( "START 서울 TOP50 RANKING");
//		
//		final String locationCode = "A";
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new SearchCondition( "locationCode", locationCode));
//		List<HospitalModel> datas = (List<HospitalModel>)hospitalService.search( 0, 50, conditions, "totalPoint DESC");
//		
//		if( datas != null){
//			// create Ranking
//			StringBuilder sbRankingName = new StringBuilder();
//			sbRankingName.append( "서울 TOP50 (").append( DateUtil.formatDate( startDate, DateUtil.YYYYMMDD)).append( " ~ " ).append( DateUtil.formatDate( endDate, DateUtil.YYYYMMDD)).append(")");
//			RankingModel rankingModel = new RankingModel();
//			rankingModel.setName( sbRankingName.toString());
//			rankingModel.setRankingType( RankingModel.RANKING_TYPE_SEOUL_50);
//			if( locationCode != null)
//				rankingModel.setRankingLocationCode( locationCode);
//			rankingModel.setStartDate( startDate);
//			rankingModel.setEndDate( endDate);
//			
//			generateRankingData( rankingModel, datas);
//		}
//	}
	
	/**
	 * 부위별 TOP 10
	 * @param locationCode
	 * @throws Exception
	 */
	public void generateTop10RankingByPartCode( String partCode, Date startDate, Date endDate) {
		
		logger.info( "START 부위별 TOP10 RANKING");
		System.out.println("partCode = " + partCode);
		String partFieldName = "";
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_EYE)){ partFieldName = "h.eyePoint";}
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_NOSE)){ partFieldName = "h.nosePoint";}
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_FACE)){ partFieldName = "h.facePoint";}
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_BREAST)){ partFieldName = "h.breastPoint";}
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_BODY)){ partFieldName = "h.bodyPoint";}
		if( partCode.equals(GivusConstants.CODE_CATEGORY_PARTCODE_PETIT)){ partFieldName = "h.petitPoint";}
		
		// top50bySurg
		// 부위별 랭킹
		HashMap<String, Object> top10byPart = new HashMap<>();
		top10byPart.put("start", 0);
		top10byPart.put("limit", 10);
		top10byPart.put("point", partFieldName);
		
		List<HashMap<String, Object>> datas = sqlsession.selectList("renew_ranking.top50bySurg", top10byPart);
		
		List<HashMap<String, Object>> parts = sqlsession.selectList("renew_ranking.get_parts");
		
		String partName = "";
		for(int i = 0 ; i < parts.size(); i++){
			String code = parts.get(i).get("code").toString();
			if(partCode.equals(code)){
				partName = parts.get(i).get("name").toString();
				break;
			}
		}
		
		if( datas != null){
			// create Ranking
			StringBuilder sbRankingName = new StringBuilder();
			sbRankingName.append( partName).append( " TOP10 (").append( DateUtil.formatDate( startDate, DateUtil.YYYYMMDD)).append( " ~ " ).append( DateUtil.formatDate( endDate, DateUtil.YYYYMMDD)).append(")");
			RankingModel rankingModel = new RankingModel();
			rankingModel.setName( sbRankingName.toString());
			rankingModel.setRankingType( RankingModel.RANKING_TYPE_PART_10);
			if( partCode != null)
				rankingModel.setRankingPartCode( partCode);
			rankingModel.setStartDate( startDate);
			rankingModel.setEndDate( endDate);
			
			generateRankingData( rankingModel, datas);
		}
	}
	
	protected void generateRankingData( RankingModel rankingModel, List<HashMap<String, Object>> datas){
		if( datas != null){
			
			// previous Ranking
			HashMap<String, Object> rankMParam = new HashMap<>();		
			rankMParam.put("rankingType", rankingModel.getRankingType());
			rankMParam.put("rankingLocationCode", rankingModel.getRankingLocationCode());
			RankingModel preRankingModel = sqlsession.selectOne("renew_ranking.get_recent_rank_one", rankMParam); 
					//(RankingModel)rankingService.getRecentRanking( rankingModel.getRankingType(), rankingModel.getRankingLocationCode());
			
			List<RankingDataModel> preRankingDataModels = null;
			
			HashMap<String, Object> rankListParam = new HashMap<>();
			rankListParam.put("rid", rankingModel.getId());	
			rankListParam.put("limitStart", 0);
			rankListParam.put("limitSize", 100);
			
			if( preRankingModel != null){
				preRankingDataModels = sqlsession.selectList("renew_ranking.get_rankingdata_by_rid", rankListParam); 
						//rankingDataService.search( new SearchCondition( "rankingId", preRankingModel.getId()));
			}
			
			System.out.println("--- get ranking model ----");
			
			// 새로운 랭킹 타이틀 넣기
			//rankingModel = (RankingModel)rankingService.create( rankingModel);
			HashMap<String, Object> insert_title = new HashMap<>();
			insert_title.put("name", rankingModel.getName());
			insert_title.put("rtype", rankingModel.getRankingType());
			insert_title.put("sdate", rankingModel.getStartDate());
			insert_title.put("edate", rankingModel.getEndDate());
			insert_title.put("locationCode", rankingModel.getRankingLocationCode());
			insert_title.put("partCode", rankingModel.getRankingPartCode());
			
			sqlsession.insert("renew_ranking.input_ranking_title", insert_title);
			
			rankingModel.setId((Integer)insert_title.get("rid"));
			
			System.out.println("--- new ranking model create ----");
			
			// create RankingData
			int size = datas.size();
			
			// rankingType이 전국인 경우 hospital에 ranking 순위 넣기
//			boolean isRankingTop100 = rankingModel.getRankingType().equals( RankingModel.RANKING_TYPE_TOP_100);
			
			// 트랜잭션처리
//			DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//			// explicitly setting the transaction name is something that can only be done programmatically
//			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
//			
//			TransactionStatus status = txManager.getTransaction(def);
			
			try{
				for( int i=0; i<size; i++){
					HashMap<String, Object> hospitalModel = datas.get( i);
					RankingDataModel rankingDataModel = getRankingDataModel( hospitalModel);
					rankingDataModel.setRanking( i+1);
					rankingDataModel.setRankingId( rankingModel.getId());
					
					// get previous ranking
					if( preRankingDataModels != null){
						for( RankingDataModel preRankingDataModel : preRankingDataModels){
							if( preRankingDataModel.getHospitalId() == (Integer)hospitalModel.get("id")){
								rankingDataModel.setRankingChange( preRankingDataModel.getRanking() - rankingDataModel.getRanking());
							}
						}
					}
					
//					#{name}, now(), 'server', #{ranking}, #{grade}, #{totalPoint}, #{expertPoint}, #{safePoint}, #{satisfyPoint}, #{sizePoint}, #{convenientPoint},
//					#{hid}, #{rid}, #{rankingChange}, #{eyePoint}, #{nosePoint}, #{facePoint}, #{breastPoint}, #{bodyPoint}, #{petitPoint}
					
					HashMap<String, Object> input_param = new HashMap<>();
					input_param.put("name", hospitalModel.get("name").toString());
					input_param.put("ranking", rankingDataModel.getRanking());
					input_param.put("grade", hospitalModel.get("grade").toString());
					
					input_param.put("totalPoint", rankingDataModel.getTotalPoint());
					input_param.put("expertPoint", rankingDataModel.getExpertPoint());
					input_param.put("safePoint", rankingDataModel.getSafePoint());
					input_param.put("satisfyPoint", rankingDataModel.getSatisfyPoint());
					input_param.put("sizePoint", rankingDataModel.getSizePoint());
					input_param.put("convenientPoint", rankingDataModel.getConvinientPoint());
					
					input_param.put("hid", rankingDataModel.getHospitalId());
					input_param.put("rid", rankingModel.getId());
					input_param.put("rankingChange", rankingDataModel.getRankingChange());
					
					input_param.put("eyePoint", rankingDataModel.getEyePoint());
					input_param.put("nosePoint", rankingDataModel.getNosePoint());				
					input_param.put("facePoint", rankingDataModel.getFacePoint());
					input_param.put("breastPoint", rankingDataModel.getBreastPoint());
					input_param.put("bodyPoint", rankingDataModel.getBodyPoint());
					input_param.put("petitPoint", rankingDataModel.getPetitPoint());
					
					sqlsession.insert("renew_ranking.input_ranking_data", input_param);
					
				}
				
//				txManager.commit(status);
				
			}catch(Exception e){
//				txManager.rollback(status);
				e.printStackTrace();
			}
			
			
		}
	}
	
	protected RankingDataModel getRankingDataModel( HashMap<String, Object> hospitalModel){
		RankingDataModel rankingDataModel = new RankingDataModel();
		
		rankingDataModel.setHospitalId( (Integer) hospitalModel.get("id") );
		
		rankingDataModel.setExpertPoint( (Double)hospitalModel.get("expertPoint"));
		rankingDataModel.setSafePoint( (Double) hospitalModel.get("safePoint"));
		rankingDataModel.setSatisfyPoint( (Double) hospitalModel.get("satisfyPoint"));
		rankingDataModel.setSizePoint( (Double) hospitalModel.get("sizePoint"));
		rankingDataModel.setConvinientPoint( (Double) hospitalModel.get("convenientPoint"));
		rankingDataModel.setTotalPoint( (Double) hospitalModel.get("totalPoint"));
		rankingDataModel.setGrade( (String) hospitalModel.get("grade"));
		
		rankingDataModel.setEyePoint((Double) hospitalModel.get("eyePoint"));
		rankingDataModel.setNosePoint((Double) hospitalModel.get("nosePoint"));
		rankingDataModel.setFacePoint( (Double) hospitalModel.get("facePoint"));
		rankingDataModel.setBreastPoint( (Double) hospitalModel.get("breastPoint"));
		rankingDataModel.setBodyPoint( (Double) hospitalModel.get("bodyPoint"));
		rankingDataModel.setPetitPoint( (Double) hospitalModel.get("petitPoint"));
		
		return rankingDataModel;
	}

	private static final String WEBINF = "WEB-INF";

	public static String getWebInfPath(){
	
	    String filePath = "";
	
	    URL url = RankingCron.class.getResource("RankingCron.class");
	
	    String className = url.getFile();
	
	    filePath = className.substring(0,className.indexOf(WEBINF) + WEBINF.length());
	
	    return filePath;
	
	}
	
	@Scheduled(cron = "0 0 0 ? * FRI")
	protected void executeJob() {
		
		SqlSessionFactoryBean sfb = new SqlSessionFactoryBean();
		
		org.apache.commons.dbcp.BasicDataSource ds = new org.apache.commons.dbcp.BasicDataSource();
		
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://1.234.20.221:3306/givus?useUnicode=true&characterEncoding=UTF-8&characterSetResults=UTF-8");
		ds.setUsername("root");
		ds.setPassword("rlqmtm");
		
		
		sfb.setDataSource(ds);
		
		try {
			sfb.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:kr/co/zadusoft/contents/sqlmapper/sqlmap-renew.xml"));
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
//		sfb.setConfigLocation(new DefaultResourceLoader().getResource(getWebInfPath() + "/config/mybatis-config.xml"));
		
		
		
		//sfb.setConfigLocation(configLocation);
		
		try {
			SqlSessionFactory f = sfb.getObject();
			
			sqlsession = f.openSession();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Calendar calendar = Calendar.getInstance(); 
		calendar.add(Calendar.DAY_OF_MONTH, -7); 
		Date startDate = calendar.getTime();
		
		Date endDate = new Date();
		
		logger.info("startDate = " + startDate);
		logger.info("endDate = " + endDate);
		
		generateTop100Ranking(startDate, endDate);

		generateTop10RankingByLocationCode("A", startDate, endDate);
		generateTop10RankingByLocationCode("AA", startDate, endDate);
		generateTop10RankingByLocationCode("B", startDate, endDate);
		generateTop10RankingByLocationCode("C", startDate, endDate);
		generateTop10RankingByLocationCode("D", startDate, endDate);
		generateTop10RankingByLocationCode("E", startDate, endDate);
		generateTop10RankingByLocationCode("F", startDate, endDate);
		generateTop10RankingByLocationCode("G", startDate, endDate);
		
		generateTop10RankingByPartCode("A", startDate, endDate);
		generateTop10RankingByPartCode("B", startDate, endDate);
		generateTop10RankingByPartCode("C", startDate, endDate);
		generateTop10RankingByPartCode("D", startDate, endDate);
		generateTop10RankingByPartCode("E", startDate, endDate);
		generateTop10RankingByPartCode("F", startDate, endDate);
		
	}

}
