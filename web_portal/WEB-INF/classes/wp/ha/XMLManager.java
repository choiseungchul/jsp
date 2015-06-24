package wp.ha;

import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import wp.databean.SessionDTO;
import wp.manager.SessionDAO;
import wp.manager.SessionStorage;

/**
 * 
 * @author akrey
 *
 */
public class XMLManager {
	
	public Document getSessionDoc()
	{
		Document doc = new Document(); 
		
		// Root 정의 
		Element root 	= new Element("wp");
		Element dbinfo  = new Element("db");
		
		Element meminfo = new Element("mem");
		
		root.addContent(dbinfo);
		root.addContent(meminfo);

		List<HashMap<String, Object>> dbsess =	 SessionDAO.getInstance().getAll();
		
		for ( int i = 0 ; i < dbsess.size() ; i++)
		{
			// DB정보 seq
			Element dbseq = new Element("dbseq");
			
			// DB정보 element
			Element sidx   = new Element("sidx");
			Element sid    = new Element("sid");
			Element uid    = new Element("uid");
			Element cdate  = new Element("cdate");
			
			dbinfo.addContent(dbseq);
			dbseq.setAttribute("seq" ,String.valueOf(i));
			
			dbseq.addContent(sidx);
			dbseq.addContent(sid);
			dbseq.addContent(uid);
			dbseq.addContent(cdate);
			
			HashMap<String, Object> sess = dbsess.get(i);
			
			sidx.setText(String.valueOf(sess.get("s_idx")));
			sid.setText((String)sess.get("s_sid"));
			uid.setText((String)sess.get("s_uid"));
			cdate.setText(sess.get("s_cdate").toString());
		}
		
		List<HashMap<String ,Object>> memlist = SessionStorage.map;
		
		for ( int k = 0 ; k < memlist.size() ; k++)
		{
			// 메모리 정보 seq
			Element memseq = new Element("memseq");
			
			// 메모리 정보 element
			Element sidx   = new Element("sidx");
			Element sid    = new Element("sid");
			Element uid    = new Element("uid");
			Element prop   = new Element("prop");
			
			meminfo.addContent(memseq);
			memseq.setAttribute("seq", String.valueOf(k));
			
			memseq.addContent(sidx);
			memseq.addContent(sid);
			memseq.addContent(uid);
			memseq.addContent(prop);
			
			HashMap<String, Object> memdata = memlist.get(k);
			
			sidx.setText(String.valueOf(memdata.get("sidx")));
			sid.setText((String)memdata.get("secui_session"));
			uid.setText((String)memdata.get("secui_user"));
			prop.setText((String)memdata.get("secui_profile"));
			
		}
		
		doc.setRootElement(root);
		
		return doc;
	}
	
	public void readAndWrite(String url)
	{
		try {
		
			URL otherwp = new URL(url);
			
			URLConnection con = otherwp.openConnection();
			
			con.setReadTimeout(20000);
			con.connect();
		
			// XML 생성에 필요
			SAXBuilder sax = new SAXBuilder();
			
			Document doc = new Document();
			
			// XML 을 Stream 으로 읽어들여 문서 객체를 만든다.
			doc = sax.build(con.getInputStream());
		
			Element root = doc.getRootElement();
			
			List<Element> wpchild = root.getChildren();
			
			System.out.println(wpchild.size());
			
			for ( Element el : wpchild )
			{
				// wp->db ,mem 안의 리스트
				List<Element> nodes = el.getChildren();
				
				for ( Element seq : nodes)
				{
					// wp->db, mem-> seq 안의 리스트
					List<Element> child = seq.getChildren();
					
					if ( el.getName().equals("db"))
					{
						String uid = null;
						String sid = null;
						int sidx   = -1;
						long cdate = 0L;
						
						for ( Element dataNode : child)
						{
							if (dataNode.getName().equals("sidx"))
							{
								sidx = Integer.parseInt( dataNode.getText() );
							}else if (dataNode.getName().equals("sid")){
								sid  = dataNode.getText();
							}else if (dataNode.getName().equals("uid")){
								uid  = dataNode.getText();
							}else if (dataNode.getName().equals("cdate")){
								cdate= Long.parseLong( dataNode.getText() );
							} 
						}
						System.out.println("db seq " + seq.getAttributeValue("seq") + ":" + sidx + "/" + sid + 
								"/" + uid + "/" + cdate);
						
						SessionDTO data = new SessionDTO();
						data.setCdate(cdate);
						data.setUid(uid);
						data.setSid(sid);
						data.setIdx(sidx);
						
						SessionDAO.getInstance().addSession(data);
	
					}else if (el.getName().equals("mem"))
					{
						String uid = null;
						String sid = null;
						String prp = null;
						int idx	   = -1;
						
						for ( Element dataNode : child)
						{
							if (dataNode.getName().equals("sidx"))
							{
								idx = Integer.parseInt( dataNode.getText() );
							}else if (dataNode.getName().equals("sid")){
								sid  = dataNode.getText();
							}else if (dataNode.getName().equals("uid")){
								uid  = dataNode.getText();
							}else if (dataNode.getName().equals("prop")){
								prp  = dataNode.getText();
							}
							
						}
						System.out.println("mem seq " + seq.getAttributeValue("seq") + ":" + idx + "/" + sid + 
								"/" + uid + "/" + prp);
						
						SessionStorage.add(sid, uid, idx, prp);
					}
					
				}
			
			}	
			
		} catch (IOException e) {
			// TODO: handle exception
			System.out.println(url + "에서 세션정보를 읽어오지 못함");
			System.out.println(e.getMessage());	
			
		} catch (JDOMException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}
