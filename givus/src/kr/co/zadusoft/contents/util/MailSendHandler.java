/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

//import org.apache.log4j.Logger;

/**
 * 기본으로 UTF-8로 메일 전송 - 한글 가능하도록
 * @author erdekim
 *
 */
public class MailSendHandler {
//	private Logger logger = Logger.getLogger( MailHandler.class);

	/**
	 * 메일 서버 초기화
	 * @param mail
	 */
	private void initialize( MailConstants mail){
		Properties props = new Properties();
		props.put( MailConstants.MAIL_TRANSPORT, mail.getMailTransport());
		props.put( MailConstants.MAIL_SMTP_HOST, mail.getMailHost());
		props.put( MailConstants.MAIL_SMTP_PORT, mail.getMailPort());
		props.put( MailConstants.MAIL_TRANSPORT_SECURITY_SET, "true");
		props.put( MailConstants.MAIL_SECURE_SOCKET_LAYER_SET, MailConstants.MAIL_SECURE_SOCKET_LAYER_SET_VALUE);
		props.put( MailConstants.MAIL_SMTP_AUTHORITY, mail.getMailAuthority());
		props.put( MailConstants.MAIL_SMTP_USER, mail.getSenderEmail());
		
		Authenticator auth = new Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication("zadusoft.task@gmail.com", "wkenthvmxm");
				//return new PasswordAuthentication("root", "83eb61f3");
            }
		};
		
		Session session = Session.getDefaultInstance(props, auth);		
		mail.setMessage(new MimeMessage(session));
	}
	
	/**
	 * 메일 주소 지정
	 * @param mail
	 */
	private boolean setAddress( MailConstants mail){
		return setSender( mail) && setReceivers( mail);
	}
	/**
	 * 보내는 사람 지정
	 * @param mail
	 * @return
	 * @throws UnsupportedEncodingException 표시 이름이 인식할 수 없는 문자(Base64 기준)일때 발생
	 */
	private boolean setSender( MailConstants mail){
		try{
			//보내는 사람
			String senderName = mail.getSenderName() != null ? mail.getSenderName() : mail.getSenderEmail();
			mail.setSenderAddress( new InternetAddress( mail.getSenderEmail(), MimeUtility.encodeText(senderName, "UTF-8", "B")));
			
			return true;
		}catch(UnsupportedEncodingException uee){
			uee.printStackTrace();
//			logger.error(uee.getMessage());
			return false;
		}
	}
	/**
	 * 받는 사람들
	 * @param mail
	 * @return
	 * @throws AddressException 받는 사람이 인식할 수 없는 이름일때 발생
	 */
	private boolean setReceivers( MailConstants mail){
//		ArrayList<String> receiverList = new ArrayList<String>();
//		StringTokenizer receivers = new StringTokenizer( mail.getReceivers(), ";");
		
		try{
			if ( mail.getReceivers() != null && mail.getReceivers() != "")
			{
				String splitReceivers[] = mail.getReceivers().split(";");
				int splitLength = splitReceivers.length;
				Address receiverAddress[] = new InternetAddress[splitLength];
				for( int i=0; i < splitLength; i++)
				{
					receiverAddress[i] = new InternetAddress( splitReceivers[i]);
				}
				mail.setReceiverAddress(receiverAddress);
				return true;
			}
			return false;
		}
		catch( AddressException ae)
		{ 
			ae.printStackTrace();
//			logger.error(ae.getMessage());
			return false;
		}
	}
	/**
	 * 메일 보내기
	 * @param mail
	 * @return boolean true:전송 성공, false:전송실패
	 */
	public boolean sendMail( MailConstants mail){
		initialize( mail);
//		setAddress(mail);
		if ( setAddress(mail))
		{
			return send( mail);
		}
		return false;
	}
	
	/**
	 * 실제 메일 전송
	 * @param mail
	 * @return
	 * @throws MessagingException 메세지 초기화중 오류 발생
	 * @throws UnsupportedEncodingException 메일 제목이 인식할 수 없는 문자일때 발생
	 */
	private boolean send( MailConstants mail){
		Message message = mail.getMessage();
		try{
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom( mail.getSenderAddress());
			message.setRecipients( Message.RecipientType.TO, mail.getReceiverAddress()); //받는 사람 타입(TO, CC, BCC) 
			message.setSubject(mail.getSubject());
			message.setContent( mail.getContents(), "text/html;charset=UTF-8");
			message.setSentDate( new java.util.Date());
			
			Transport.send(message);
			return true;
		}catch(MessagingException me){
			me.printStackTrace();
//			logger.error(me.getMessage());
			return false;
//		}catch(UnsupportedEncodingException uee){
//			return false;
		}
	}
	
	
	public static void main( String[] args){
		MailSendHandler mailhandler = new MailSendHandler();
		MailConstants mail = new MailConstants();
//		mail.setMailHost("erp.sinshin.co.kr");
//		mail.setMailPort("25");
		mail.setSenderEmail("dieerde@naver.com");
		mail.setSenderName("자두");
		mail.setReceivers("이메일받는자<erdekim@gmail.com>");
		
		
		mail.setSubject("메일제목-메일보내기테스트중");
		mail.setContents("메일 내용");
		
		System.out.println("전송결과 : " + ( mailhandler.sendMail( mail)? "성공" :"실패"));

	}
	
}
