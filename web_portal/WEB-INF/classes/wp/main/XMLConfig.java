package wp.main;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

public class XMLConfig {
	
	private static XMLConfig _ins = null;
	
	public static XMLConfig getInstance()
	{
		if (_ins ==null) return new XMLConfig();
		else return _ins;
	}
	 
	public Document getXML()
	{
		Document doc = new Document();
		
		SAXBuilder man = new SAXBuilder();
		
		String path = "/secui/gui/MF2Tomcat/conf/server.xml";
		
		FileInputStream in = null;
		
		try {
			in = new FileInputStream(new File(path));
			try {
				doc = man.build(in);
				
				in.close();
				
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return doc;
	}
	
	public void setXML(Document doc)
	{
		XMLOutputter xmlout = new XMLOutputter();
		
		String path = "/secui/gui/MF2Tomcat/conf/server.xml";
		
		try {
			FileOutputStream fo = new FileOutputStream(new File(path));
			
			try {
				xmlout.output(doc, fo);
				
				fo.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void setWPTomcat(String port , String hostname)
	{
		Document doc = getXML(); 

		Element root = doc.getRootElement();
		
		List<Element> services = root.getChildren("Service");
		
		Element cata3 = services.get(2);
		
		List<Element> connectors = cata3.getChildren("Connector");
		
//		String http1_port = connectors.get(0).getAttribute("port").getValue();
		connectors.get(0).setAttribute("port" , port);
		
		List<Element> engine = cata3.getChildren("Engine");
		
//		String engine_default_host = engine.get(0).getAttributeValue("defaultHost");
		engine.get(0).setAttribute("defaultHost" , hostname);
		
		List<Element> host = engine.get(0).getChildren("Host");
		
//		String host_name   = host.get(0).getAttributeValue("name");
		host.get(0).setAttribute("name", hostname);
		
		setXML(doc);
	}
}
