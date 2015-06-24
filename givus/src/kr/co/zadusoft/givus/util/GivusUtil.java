/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 */
package kr.co.zadusoft.givus.util;

import java.net.URL;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import kr.co.zadusoft.contents.util.RelativeDateFormat;
import dynamic.util.DateUtil;
import dynamic.util.StringUtil;
import dynamic.web.util.MessageHandler;

public class GivusUtil {

	/**
	 * 연령대를 가져온다
	 * @param birthDay
	 * @return
	 */
	public static int getAgeGroup ( Date birthDay){
		int age = getAge( birthDay);
		int generation = 20;
		if ( age < 20) generation = 10;
		else if ( age < 30) generation = 20;
		else if ( age < 40) generation = 30;
		else if ( age < 50) generation = 40;
		else if ( age < 60) generation = 50;
		else if ( age < 70) generation = 60;
		else if ( age < 80) generation = 70;
		return generation;
	}
	
	/**
	 * 만 나이를 가져온다
	 * @param birthDay
	 * @return
	 */
	public static int getAge( Date birthDay){
		int age = 0;
		String today = DateUtil.getToday();
		String birth = DateUtil.formatDate( birthDay, DateUtil.YYYYMMDD);
		
		if ( birth != null){			
			String today_date[] = StringUtil.splitString(today, "-");
			String birth_date[] = StringUtil.splitString(birth, "-");
			int nToday = Integer.parseInt( today_date[0]); 
			int nBirth = Integer.parseInt( birth_date[0]);
			age = nToday - nBirth;
		}
		
		return age; 
	}
	
	public static String parseRelativeDate(Date date){
		RelativeDateFormat rd = new RelativeDateFormat(new Date());
	    rd.setSecondFormatter(new DecimalFormat("0"));	    
		rd.setDaySuffix("일");
		rd.setHourSuffix("시간");
		rd.setMinuteSuffix("분");
		rd.setSecondSuffix("초");
		rd.setMinuteFormatter(new DecimalFormat("0"));
		rd.setHourFormatter(new DecimalFormat("0"));
		
		rd.setShowZeroDays(false);
		rd.setShowZeroHours(false);
		
		return rd.format(date).replace("-","");
	}
	
	public static String priceFormat(int price){
		DecimalFormat moneyFormat = new DecimalFormat("#,###,###");
		
		String formatted = moneyFormat.format(price);
		
		return formatted;
	}
	
	public static List<HashMap<String, Object>> parseRelativeDate(List<HashMap<String, Object>> list){
		RelativeDateFormat rd = new RelativeDateFormat(new Date());
	    rd.setSecondFormatter(new DecimalFormat("00"));	    
		rd.setDaySuffix("일");
		rd.setHourSuffix("시간");
		rd.setMinuteSuffix("분");
		rd.setSecondSuffix("초");
		rd.setMinuteFormatter(new DecimalFormat("00"));
		rd.setHourFormatter(new DecimalFormat("00"));
		
		rd.setShowZeroDays(false);
		rd.setShowZeroHours(false);
		
		for(int i = 0 ; i < list.size(); i++){
			HashMap<String, Object> data = list.get(i);
			
			long compared = new Date().getTime() - ((Date)data.get("createDate")).getTime();
			
			String timetext = "";
			if(compared <= 1000 * 60 * 60 * 24 * 7 ){
				timetext = rd.format((Date)data.get("createDate")) + " 전";
				timetext = timetext.replace("-", "");
			}else{
				timetext = ((Date)data.get("createDate")).toString();
			}
			
			data.put("createDate", timetext);
			list.set(i, data);
			
		}
		return list;
	}
	
	// 숫자인지 체크
	public static boolean isNumber(String number){
	    boolean flag = true;
	    if ( number == null  ||    "".equals( number )  )
	     return false;
	    int size = number.length();
	    int st_no= 0;
	    if ( number.charAt(0)  ==  45 )//음수인지 아닌지 판별 . 음수면 시작위치를 1부터
	     st_no = 1;

	    for ( int i = st_no ; i < size ; ++i ){
	     if ( !( 48   <=  ((int)number.charAt(i))   && 57>= ( (int)number.charAt(i) )  )  ){
	      flag = false;
	      break;
	     }
	    }
	    return flag;
	   }
	
	public static String getReviewAnswerMessage( int point){
		return MessageHandler.getMessage("reviewPoints.answer." + point);
	}
	
	
	public static String getCurrWeek(){
		
		Calendar oCalendar = Calendar.getInstance( );
		
		int year = oCalendar.get(Calendar.YEAR);
		
		int week = oCalendar.get(Calendar.WEEK_OF_MONTH);
		
		int month =  oCalendar.get(Calendar.MONTH) + 1;
		
		return year + "/" + month + "/" + week;
	}
	
}
