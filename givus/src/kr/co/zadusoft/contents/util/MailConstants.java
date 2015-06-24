package kr.co.zadusoft.contents.util;

import javax.mail.Address;
import javax.mail.Message;

public class MailConstants {
	// 프로토콜 설정
	public static final String MAIL_TRANSPORT = "mail.transport";
	// SMTP 호스트 설정
	public static final String MAIL_SMTP_HOST = "mail.smtp.host";
	// SMTP 포트 설정
	public static final String MAIL_SMTP_PORT = "mail.smtp.port";
	// Transport Layer Security 설정
	public static final String MAIL_TRANSPORT_SECURITY_SET = "mail.smtp.starttles.enable";
	// SSL 설정
	public static final String MAIL_SECURE_SOCKET_LAYER_SET = "mail.smtp.socketFactory.class";
	// SSL 값
	public static final String MAIL_SECURE_SOCKET_LAYER_SET_VALUE = "javax.net.ssl.SSLSocketFactory";
	// 전송자 설정
	public static final String MAIL_SMTP_USER = "mail.smtp.user";
	// SMTP 인증 설정
	public static final String MAIL_SMTP_AUTHORITY = "mail.smtp.auth";
	
	// smtp 호스트 설정
	private String mailHost = "smtp.gmail.com";
	// 포트 설정
	private String mailPort = "465";
	// 프로토콜 설정
	private String mailTransport = "smtp";
	// Transport Layer Security 설정
	private String mailStarttlesEnable = "false";
	// SMTP 메일 인증설정
	private String mailAuthority = "true";
	// 보내는 메일 메세지
	private Message message;
	// 보내는 사람 이메일
	private String senderEmail;
	// 보내는 사람 이름
	private String senderName;
	// 제목
	private String subject;
	// 내용
	private String contents;
	// 받는 사람 목록
	private String receivers;
	// 보내는 사람 이메일 주소
	private Address senderAddress;
	// 받는 사람 이메일 주소
	private Address[] receiverAddress;
	
	public String getMailHost() {
		return mailHost;
	}
	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}
	public String getMailPort() {
		return mailPort;
	}
	public void setMailPort(String mailPort) {
		this.mailPort = mailPort;
	}
	public String getMailTransport() {
		return mailTransport;
	}
	public void setMailTransport(String mailTransport) {
		this.mailTransport = mailTransport;
	}
	public String getMailStarttlesEnable() {
		return mailStarttlesEnable;
	}
	public void setMailStarttlesEnable(String mailStarttlesEnable) {
		this.mailStarttlesEnable = mailStarttlesEnable;
	}
	public String getMailAuthority() {
		return mailAuthority;
	}
	public void setMailAuthority(String mailAuthority) {
		this.mailAuthority = mailAuthority;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReceivers() {
		return receivers;
	}
	public void setReceivers(String receivers) {
		this.receivers = receivers;
	}
	public Address getSenderAddress() {
		return senderAddress;
	}
	public void setSenderAddress(Address senderAddress) {
		this.senderAddress = senderAddress;
	}
	public Address[] getReceiverAddress() {
		return receiverAddress;
	}
	public void setReceiverAddress(Address[] receiverAddress) {
		this.receiverAddress = receiverAddress;
	}
	
}
