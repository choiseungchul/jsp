package wp.cli;

import java.util.HashMap;
import java.util.List;

import wp.utils.Debugger;

public class CliTest {
	
	public static void main(String[] args)
	{
		if (args.length == 0) {
			System.out.println("usage info : --help");
			System.exit(0);
		}
		
		Command cmd = new Command();
		
		if ( args[0].equals("--help"))
		{
			StringBuilder help = new StringBuilder();
			
			help.append("===========================================================\n");
			help.append(" [mode] [target] {spec} \n");
			help.append("ex) add user [id] [pass] [profile] [desc]\n");
			help.append("ex) add profile [profile_name] [desc]\n");
			help.append("ex) show user \n");
			help.append("ex) show bmk \n");
			help.append("ex) mod profile-mod [profile_name] [profile_name] [desc]\n");
			help.append("ex) mod profile-srv [profile_name] [Y/N] [domain_name]\n");
			help.append("===========================================================\n");
			
			
			System.out.println(help.toString());
			System.exit(0);
		}else if (args[0].equals("--test"))
		{
			String command = String.format(CmdString.user_list);
			
			cmd.runCmd(command);
			
			List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 1); 
			
			Debugger.traceValue(list);
			
			System.exit(0);
			
		}else if (args[0].equals("--add"))
		{
			String command = String.format(CmdString.add_user, "id123" ,"pass123" ,"한글" , "한글한글한글");
			
			cmd.runCmd(command);
			
			List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 1); 
			
			Debugger.traceValue(list);
			
			System.exit(0);
		}
		
		if ( args[0].equals("add"))
		{
			if ( args[1].equals("user"))
			{
				String command = String.format(CmdString.add_user , args[2], args[3], args[4], args[5]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
				
				cmd.runCmd(String.format(CmdString.apply_user));
				
			}else if (args[1].equals("domain"))
			{
				String command = String.format(CmdString.add_srv_domain, args[2], args[3], args[4], args[5]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
				
				cmd.runCmd(String.format(CmdString.apply_srv));
				
			}else if (args[1].equals("profile"))
			{
				String command = String.format(CmdString.add_profile, args[2], args[3]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
				
				cmd.runCmd(String.format(CmdString.apply_profile));
				
			}else if (args[1].equals("bmk"))
			{
				String command = String.format(CmdString.add_bmk, args[2] ,args[3], args[4], args[5]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
			}
				
		}else if (args[0].equals("show"))
		{
			if (args[1].equals("user"))
			{
				String command = String.format(CmdString.user_list);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 4); 
				
				Debugger.traceValue(list);
				
			}else if (args[1].equals("profile"))
			{
				String command = String.format(CmdString.user_profile, args[2]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 3); 
				
				Debugger.traceValue(list);
				
			}else if (args[1].equals("bmk"))
			{
				String command = String.format(CmdString.s_user_bmk, args[2]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 2); 
				
				Debugger.traceValue(list);
				
			}else if (args[1].equals("domain"))
			{
				String command = String.format(CmdString.s_domain);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
			}
			
		}else if (args[0].equals("mod"))
		{
			if (args[1].equals("profile-srv"))
			{
				String command = String.format(CmdString.add_srv_domain, args[2], args[3], args[4]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
				
				cmd.runCmd(String.format(CmdString.apply_profile));
				
			}else if (args[1].equals("profile-name"))
			{
				String command = String.format(CmdString.mod_profile, args[2], args[3], args[4]);
				
				cmd.runCmd(command);
				
				List<HashMap<String, String>> list = CLIParser.getInstance().parseAttr(cmd.getExitValue(), 0); 
				
				Debugger.traceValue(list);
				
				cmd.runCmd(String.format(CmdString.apply_profile));
				
			}
		}else{
			System.out.println("unknown command : " + args[0]);
			System.exit(0);
		}
	}	
}
