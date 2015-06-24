/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.net.URL;
import java.util.List;

import org.junit.Test;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

public class RSSReader {
	
	public List readRSS( String url) throws Exception{
		URL feedUrl = new URL( url);
	    SyndFeedInput input = new SyndFeedInput();
	    SyndFeed feed = input.build( new XmlReader( feedUrl));

//	    System.out.println("RSS title: " + feed.getTitle());
//	    System.out.println("RSS author: " + feed.getAuthor());

	    List entries = feed.getEntries();
//	    for (int i = 0; i < entries.size(); i++) {
//	        SyndEntry entry = (SyndEntry) entries.get(i);
//	        System.out.println("--- Entry " + i);
//	        System.out.println(entry.getTitle());
//	        System.out.println(entry.getAuthor());
//	        System.out.println(entry.getDescription().getValue());
//	        System.out.println(entry.getLink());
//	        // TODO entry.getPublishedDate() 와 마지막 읽은 시간을 비교하여 최신 글을 게시판에 입력한다.
//	    }
	    
	    return entries;
	}
	
	@Test
	public void testReadRSS() throws Exception{
		String url = "http://newssearch.naver.com/search.naver?where=rss&query=%EC%84%B1%ED%98%95%EC%88%98%EC%88%A0&field=0";
		List entries = readRSS( url);

	    for (int i = 0; i < entries.size(); i++) {
	        SyndEntry entry = (SyndEntry) entries.get(i);
	        System.out.println("--- Entry " + i);
	        System.out.println(entry.getTitle());
	        System.out.println(entry.getAuthor());
	        System.out.println(entry.getDescription().getValue());
	        System.out.println(entry.getLink());
	        System.out.println(entry.getPublishedDate());
	        
	        // TODO entry.getPublishedDate() 와 마지막 읽은 시간을 비교하여 최신 글을 게시판에 입력한다.
	    }
	}
}
