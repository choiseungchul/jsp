package wp.utils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

public class Property{
    
	private static String PROPERTIES_FILE = null;
    private static String GLOBALS_PROPERTIES_FILE = null;
    
    public static String getpath()
    {
    	return Property.PROPERTIES_FILE;
    }
    
    /**
     * 환경설정 초기화 메소드
     * @param propPath			현재 웹 컨텍스트 경로
     */
    public static void init(String propPath)
    {
    	PROPERTIES_FILE = propPath + "WEB-INF/common.properties";
    	GLOBALS_PROPERTIES_FILE = propPath + "WEB-INF/common.properties";
    }
    
	/**
     * 특정 키값을 반환한다.
     * @param keyName 		설정 키 
     * @return 				설정 값
     */
    public static String getProperty(String keyName) {
        String value = null;
        try {
            Properties props = new Properties();
            FileInputStream fis = new FileInputStream(PROPERTIES_FILE);
            props.load(new java.io.BufferedInputStream(fis));
            value = props.getProperty(keyName).trim();
            fis.close();
        } catch (java.lang.Exception e) {
            System.out.println(e.toString());
        }
        return value;
    }
 
 
    /**
     * 특정 키 이름으로 값을 설정한다.
     * @param keyName		설정 키
     * @param value			설정할 값
     */
    public static void setProperty(String keyName, String value) {
        try {
            Properties props = new Properties();
            FileInputStream fis  = new FileInputStream(PROPERTIES_FILE);
            props.load(new java.io.BufferedInputStream(fis));
            props.setProperty(keyName, value);
            props.store(new FileOutputStream(GLOBALS_PROPERTIES_FILE), "");
            fis.close();
        } catch(java.lang.Exception e) {
            System.out.println(e.toString());
        }
    }

}