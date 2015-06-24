package kr.co.zadusoft.givus.controller;

public class GivusAuthorityException extends Exception {
	
	private static final long serialVersionUID = 2L;

	public GivusAuthorityException(Exception e) {
		super( e);
		// TODO Auto-generated constructor stub
	}

	public GivusAuthorityException(String msg) {
		super( msg);
		// TODO Auto-generated constructor stub
	}
}
