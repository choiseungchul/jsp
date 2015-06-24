package wp.cli;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import wp.utils.Debugger;
import wp.utils.Property;

public class Command{ 
	
	private int exitcode = -1;
	private String exitValue = null;	
	private String errorValue = null;	
	private String encoding = "UTF-8";
	 //Property.getProperty("cli.encoding");		// 스트림에서 불러올때 인코딩
	
	/**
	 * CLI 명령 실행
	 * @param runtext  	CLI명령어
	 */
	public void runCmd(String runtext) 
	{
		Debugger dbug = new Debugger();
		dbug.setStartTime("runCmd");
		
		Runtime run = Runtime.getRuntime();
		
		Process proc = null;
		
		try {
			
			String[] fullcmd = new String[8];
			
			fullcmd[0] = "/secui/bin/cli";
			fullcmd[1] = "-g";
			fullcmd[2] = "-u";
			fullcmd[3] = "root";
			fullcmd[4] = "-c";
			fullcmd[5] = "conf t";
			fullcmd[6] = "-c";
			//runtext = "sslvpn user id11 pass11 prp3 한글한글한글";
			
			fullcmd[7] = runtext;
			
			for ( String cmds : fullcmd)
			{
				System.out.print(cmds + " ");
			}
			
			proc = run.exec(fullcmd);
		
			try {
				proc.waitFor();		// 스레드가 종료될때 까지 기다린다.
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			int code = proc.exitValue();
			
			System.out.println("return code:"+code);
			
			InputStream isr = proc.getInputStream();
			StringBuilder value = new StringBuilder();
			
			InputStreamReader is = new InputStreamReader(isr, encoding);
			
			int inch = 0;
			
			while (true)
			{
				if ( ( inch = is.read() ) != -1 )
				{
					value.append((char)inch);
				}
				else break;
			}
			isr.close();
		
			this.exitValue = value.toString();
			
		
			InputStream eisr = proc.getErrorStream();
			StringBuilder evalue = new StringBuilder();
			
			InputStreamReader eis = new InputStreamReader(eisr, encoding);
			
			int einch = 0;
			
			while (true)
			{
				if ( ( einch = eis.read() )  != -1 )
				{
					evalue.append((char)einch);
				}
				else break;
			}
			eisr.close();
		
			this.errorValue = evalue.toString();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("exit:"+this.exitValue);
		System.out.println("error:"+this.errorValue);
		
		dbug.setEndTime();
		dbug.traceTime();
	}
	
	public void runBlueCmd(String runtext) 
	{
		Debugger dbug = new Debugger();
		dbug.setStartTime("runCmd");
		
		Runtime run = Runtime.getRuntime();
		
		Process proc = null;
		
		try {
			
			proc = run.exec(Property.getProperty("blueclipath") + " -i " + runtext);
		
			try {
				proc.waitFor();		// 스레드가 종료될때 까지 기다린다.
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			int code = proc.exitValue();
			
			System.out.println("return code:"+code);
			
			InputStream isr = proc.getInputStream();
			StringBuilder value = new StringBuilder();
			
			InputStreamReader is = new InputStreamReader(isr, encoding);
			
			int inch = 0;
			
			while (true)
			{
				if ( ( inch = is.read() ) != -1 )
				{
					value.append((char)inch);
				}
				else break;
			}
			isr.close();
		
			this.exitValue = value.toString();
			
		
			InputStream eisr = proc.getErrorStream();
			StringBuilder evalue = new StringBuilder();
			
			InputStreamReader eis = new InputStreamReader(eisr, encoding);
			
			int einch = 0;
			
			while (true)
			{
				if ( ( einch = eis.read() )  != -1 )
				{
					evalue.append((char)einch);
				}
				else break;
			}
			eisr.close();
		
			this.errorValue = evalue.toString();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("exit:"+this.exitValue);
		System.out.println("error:"+this.errorValue);
		
		dbug.setEndTime();
		dbug.traceTime();
	}
	
	public int getExitcode() {
		return exitcode;
	}

	public String getExitValue() {
		return exitValue;
	}
	
	public String getErrorValue() {
		return errorValue;
	}
	
}
