<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<style>
.path_info {
	color: #000;
	font-size: 12px;
	height:30px;
}
.news_title{
	color: #214579;
	font-size: 14px;
	font-weight: bold;
	font-family: "나눔고딕";
	vertical-align: bottom;
	padding-bottom: 5px;
}
.news_subject{
	color: #444444;
	font-size: 13px;
	font-weight: bold;
	font-family: "나눔고딕";
}
.news_subject_sub{
	color: #707070;
	font-size: 12px;
}
.white, .white a {
	color: #FFF;
	font-family: "나눔고딕";
	font-size: 13px;
	background:url('${imageHandler.g_surgeryinfo_title_bg}') no-repeat;
}
.black {
	color: #030404;
	font-size: 13px;
	font-family: "나눔고딕";
}
.news_contents, .news_contents a{
	color: #444444;
	font-family: "나눔고딕";
	font-size: 13px;
	padding-top: 20px;
}
</style>
<script>
$(function(){

	
	var url_portlet = '${contextPath}/___/posting/portlet/'+${dispatcher.data.boardId}+'/'+${dispatcher.data.categoryId};	
	$('.posting-portlet').load( url_portlet, function( responseText){

	});
	var url_contents = '${contextPath}/___/posting/contents/'+${dispatcher.data.boardId}+'/'+${dispatcher.data.categoryId};	
	$('.posting-contents').load( url_contents, function( responseText){

	});

});

function loadInterviewDetail( id){
	var url = '${contextPath}/___/posting/detail/' + id;
	$('.posting-detail').load( url, function( responseText){
	});
}
</script>
<table width="100%"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;">
		<tr>
			<td class="path_info" align="left"><a href="${contextPath}/___/p/surgeryinfo">정보</a></td>
		</tr>
	</table>
	
	<table width="976" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="976" height="40" align="center" background="${imageHandler.g_surgeryinfo_interview_title}" >
				<table width="98%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="5%">
							<table width="100" border="0" cellspacing="0" cellpadding="0">
								
								<tr>
									<c:if test="${dispatcher.data.categoryId==68}">
									<td width="10%" align="right"></td>
									<td width="80%" height="17" bgcolor="#113145" class="white" align="center" ><a href="${contextPath}/___/p/surgeryinfo/19/68">성형뉴스</a></td>
									<td width="10%" align="left"></td>
									</c:if>
									<c:if test="${dispatcher.data.categoryId!=68}">
									<td width="100%" colspan="3" class="black" align="center"><a href="${contextPath}/___/p/surgeryinfo/19/68">성형뉴스</a></td>
									</c:if>
								</tr>
								
							</table>
						</td>
						<td width="2%" align="center" class="black">|</td>
						<td width="5%" align="left" class="contents">
							<table width="100" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<c:if test="${dispatcher.data.categoryId==69}">
									
									<td width="10%" align="right"></td>
									<td width="80%" height="17" bgcolor="#113145" class="white" align="center" ><a href="${contextPath}/___/p/surgeryinfo/19/69">성형정보</a></td>
									<td width="10%" align="left"></td>
									</c:if>
									<c:if test="${dispatcher.data.categoryId!=69}">
									<td width="100%" colspan="3" class="black" align="center"><a href="${contextPath}/___/p/surgeryinfo/19/69">성형정보</a></td>
									</c:if>
								</tr>
							</table>
						</td>
						<td width="88%" align="right">
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" align="left">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td  width="680" valign="top" align="left">
							<table width="680" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="680" height="40" class="news_title"><img src="${imageHandler.g_right_subtitle_icon}" alt="" width="8" height="8" /> 내용</td>
								</tr>
								<tr>
									<td width="680" height="7"><img src="${imageHandler.g_right_subtitle_bar}"/></td>
								</tr>
								<tr>
									<td valign="top">
										<table width="615" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="615" valign="top">
													<table width="615" border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td width="110" rowspan="2" align="center" valign="middle">
																<span class="news_subject">${dispatcher.data.renderedData['categoryId']}<br /></span>
															</td>
															<td width="19" rowspan="2" align="left" valign="middle"><span class="news_subject"><img src="${imageHandler.g_surgeryinfo_l }" alt="" width="4" height="46" /></span></td>
															<td width="487" height="51" valign="middle">
																<span class="news_subject">${dispatcher.data.subject}</span><br />
																<span class="news_subject_sub">${dispatcher.data.renderedData['createDate']}&nbsp; <img src="${imageHandler.g_right_view}" alt="조회수" width="15" height="10"/>&nbsp;${dispatcher.data.viewCount}</span>
															</td>
														</tr>
														<tr>
															<td align="right" class="news_subject_sub" >${dispatcher.data.customField1}</td>
														</tr>
														<tr>
															<td height="15" colspan="3"><img src="${imageHandler.g_right_subtitle_bar}" alt="" width="616" height="2" /></td>
														</tr>
													</table>
												</td>
											</tr>
											<c:if test="${dispatcher.data.categoryId==69}">
											<tr><%--#################### Twitter ####################--%>
												<td class="property-value-td">
													<div class="news_contents">
														<!-- 트윗 start -->
														<a href="https://twitter.com/share" class="twitter-share-button" data-text="GIVUS TOP 100 성형정보 - ${dispatcher.data.subject}" data-via="givus2014">Tweet</a>
														<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
														<!-- 트윗 end -->
													</div>
												</td>
											</tr>
											</c:if>
											<tr><%--#################### Posting Contents ####################--%>
												<td class="property-value-td">
													<div id="contents_value" class="news_contents">
														${dispatcher.data.contents}
													</div>
												</td>
											</tr>
											
											<c:if test="${ dispatcher.data.postingType == 'R'}">
											<tr><%--#################### RSS Posting Reference URL ####################--%>
												<td class="property-value-td">
													<div class="news_contents">
													출처 : <a href="${dispatcher.data.referenceURL}" target="_blank"><span class="property-value"> ${dispatcher.data.referenceURL}</span></a>
													</div>
												</td>
											</tr>
											</c:if>
											<c:if test="${dispatcher.data.categoryId==69}">
											<tr><%--#################### Twitter ####################--%>
												<td class="property-value-td">
													<div class="news_contents">
														<!-- 트윗 start -->
														<a href="https://twitter.com/share" class="twitter-share-button" data-text="GIVUS TOP 100 성형정보 - ${dispatcher.data.subject}" data-via="givus2014">Tweet</a>
														<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
														<!-- 트윗 end -->
													</div>
												</td>
											</tr>
											</c:if>
										</table>
									</td>
								</tr>
							</table>
						</td>
						
						<td width="300" valign="top" align="left">
							
							<div  style="width:300px;height:25px"></div>
							<div class="news_title"><img src="${imageHandler.g_right_subtitle_icon}" alt="" width="8" height="8" />LIST</div>
							<div class="posting-portlet"></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</td></tr></table>