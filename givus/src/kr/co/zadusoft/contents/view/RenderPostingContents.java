/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

public class RenderPostingContents extends RenderText{
	
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
		
		if( getHangulCutLength() > 0){
			renderedContents = cutHangul( renderedContents, getHangulCutLength() * 2, CUT_SUFFIX);
		}
		
		return renderedContents;
	}
	
	/**
	 * 한글 자르는 메소드
	 * @param inputStr
	 * @param limit
	 * @param fixStr
	 * @return
	 */
	public static String cutHangul(String sourceText, int cutLength, String fixStr) {
		String targetText = sourceText;
		int oF = 0;
		int oL = 0;
		int rF = 0;
		int rL = 0;
		int nLengthPrev = 0;
		
		try {
			 // 바이트 보관
			byte[] bytes = targetText.getBytes("UTF-8");

			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
			int j = 0;

			if (nLengthPrev > 0)
				while (j < bytes.length) {
					if ((bytes[j] & 0x80) != 0) {
						oF += 2;
						rF += 3;
						if (oF + 2 > nLengthPrev) {
							break;
						}
						j += 3;
					} else {
						if (oF + 1 > nLengthPrev) {
							break;
						}
						++oF;
						++rF;
						++j;
					}
				}

			j = rF;

			while (j < bytes.length) {
				if ((bytes[j] & 0x80) != 0) {
					if (oL + 2 > cutLength) {
						break;
					}
					oL += 2;
					rL += 3;
					j += 3;
				} else {
					if (oL + 1 > cutLength) {
						break;
					}
					++oL;
					++rL;
					++j;
				}
			}

			// charset 옵션
			targetText = new String(bytes, rF, rL, "UTF-8");
			
			if( fixStr != null){
				targetText += fixStr;
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return targetText;
    }
}
