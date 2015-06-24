/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

public class RenderMessageContents extends RenderText{
	
	// script 처리 
	private static final Pattern PATTER_SCRIPT = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);  
	// style 처리
	private static final Pattern PATTER_STYLE = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);  
	// tag 처리 
	private static final Pattern PATTER_TAG = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");  
	// ntag 처리 
	private static final Pattern PATTER_NTAG = Pattern.compile("<\\w+\\s+[^<]*\\s*>");  
	// entity ref 처리
	private static final Pattern PATTER_ENTITY = Pattern.compile("&[^;]+;");  
	// whitespace 처리 
	private static final Pattern PATTER_WSPACE = Pattern.compile("\\s\\s+");  
	
	private static final String CUT_SUFFIX = "...";
	
	private boolean removeTags = false;
	private int hangulCutLength; 
	
	public boolean isRemoveTags() {
		return removeTags;
	}

	public void setRemoveTags(boolean removeTags) {
		this.removeTags = removeTags;
	}
	
	public int getHangulCutLength() {
		return hangulCutLength;
	}

	public void setHangulCutLength(int hangulCutLength) {
		this.hangulCutLength = hangulCutLength;
	}

	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		String renderedContents = (String)super.render( data, value, context);;
		
		if( isRemoveTags()){
			Matcher matcher;
			matcher = PATTER_SCRIPT.matcher( renderedContents);
			renderedContents = matcher.replaceAll( "");
			matcher = PATTER_STYLE.matcher( renderedContents);
			renderedContents = matcher.replaceAll( "");
			matcher = PATTER_TAG.matcher( renderedContents);
			renderedContents = matcher.replaceAll( "");
			matcher = PATTER_NTAG.matcher( renderedContents);
			renderedContents = matcher.replaceAll( "");
		}
		
		// convert line break TO BR tag
		renderedContents = renderedContents.replaceAll("(\r\n|\n)", "<br />");
		
		return renderedContents;
	}
}
