<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<style>
.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
}
.body_title_name {
	border: 1px solid #CCCCCC;
	background:url('${imageHandler.g_left_title_bg}') no-repeat;
	color: #FFFFFF;
	font-size: 15px;
	text-shadow: 1px 1px 1px #0C0C0C;
}
.body_title_desc {
	border: 1px solid #CCCCCC;
	color: #444444;
	font-size: 13px;
	padding-left: 25px; 
	font-weight: bold;
}
.table-data-tr {
	height: 28px;
}
.table-data-td {
	color: #454545;
	padding: 1px 0px 1px 0px;
	text-overflow: ellipsis; /* for browsers that supports it */  
	overflow: hidden; /* for other browsers */
	white-space: normal; /* force one-line text */
	border-bottom: 1px solid #d7dce5;
	word-break:break-all;
}
.table-nav-div {
	text-align: center;
	margin-top: 20px;
}
.table-nav, .table-nav-selected{
	margin-left: 5px;
	padding: 3px;
	border: 1px solid white;
	width: 18px;

}
.table-nav-prev, .table-nav-next{
	margin-left: 5px;
	margin-right: 5px;
}
.table-nav-selected {
	border: 1px solid #cbcbcb;
	font-weight: bold;
}
.board-list{
	border-top: 1px solid #CCCCCC;
	list-style:none;
	padding:0px;
	margin:0px;
}
.board-list > li{
	border-bottom: 1px solid #CCCCCC;
	background-color: #FBFCFC;
	padding:10px;
}
.board-sublist{
	list-style:none;
	padding:3px 3px 3px 10px;
	margin:0px;
}
.board-sublist > li{
	padding:3px;
}
.selected{
	border-right: 1px solid #fff;
	background-color: #fff;
}
.board_right{
	width: 834px;
	height:800px;
	float: left;
	border-right: 1px solid #CCCCCC;
}
.board_left{
	width:143px;
	height:800px;
	float:left;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
}
</style>
<script>
$(function(){
	$('.board-list > li:eq(2)').css('background-color', '#fff');
});
</script>
<div style="height:20px"></div>
<table width="980" style="margin:auto;maring-top:20px;">
	<tr>
		<td class="path_info" align="left"> 게시판 > 병원관계자공간 </td>
	</tr>
</table>
<table width="100%"><tr><td align="center">
<table width="980px" style="margin:auto;">
	<tr><%-- //////////////// BOARD MENU //////////////// --%>
		<td valign="top" align="left">
		
		<div>
			<table width="980px" style="margin:auto;">
				<tr>
					<td width="145px" height="52px" class="body_title_name" align="center">병원회원공간</td>
					<td class="body_title_desc" align="left">병원스탭들이 자유롭게 이야기를 나눌 수 있는 자리 입니다. </td>
				</tr>
			</table>
		</div>
		<div class="board_left">
			<ul class="board-list">
				<c:forEach var="menu" items="${leftMenu.children}" varStatus="count">
				<li>
				<c:choose>
					<c:when test="${menu.relatedType == 'board'}">
					<a href="${contextPath}/___/p/hboard/${menu.relatedId}">${menu.name}</a>
					</c:when>
					<c:otherwise>
					${menu.name}
					</c:otherwise>
				</c:choose>
					<c:if test="${menu.children != null}">
					<ul class="board-sublist">
					<c:forEach var="menu2" items="${menu.children}" varStatus="count">
						<li>
						<c:choose>
						<c:when test="${menu2.relatedType == 'board'}">
						<a href="${contextPath}/___/p/hboard/${menu2.relatedId}">${menu2.name}</a>
						</c:when>
						<c:otherwise>
						${menu2.name}
						</c:otherwise>
						</c:choose>
						</li>
					</c:forEach>
					</ul>
					</c:if>
				</li>
				</c:forEach>
			</ul>
		</div>
		<div class="board_right">
			<%-- //////////////// BEST VIEW POSTINGS //////////////// --%>
			<div style="width:350px;float:left;text-align:center;margin:10px 10px 10px 40px;">
				<table>
					<tr>
						<td colspan="3"><img src="${imageHandler.g_hits}"></td>
					</tr>
					<c:forEach var="posting" items="${bestViewPostings}" varStatus="count">
					<tr>
						<td align="center" width="30" align="left"><img src="${contextPath}/images/givus/${count.count}.gif"></td>
						<td align="left">${posting.renderedData.subject}</td>
						<td align="center" width="50">${posting.viewCount}</td>
					</tr>
					</c:forEach>
				</table>
			</div><%-- //////////////// BEST RECOMMEND POSTINGS //////////////// --%>
			<div style="width:350px;float:left;text-align:center;margin:10px 10px 10px 40px;">
				<table>
					<tr>
						<td colspan="3"><img src="${imageHandler.g_recommend}"></td>
					</tr>
					<c:forEach var="posting" items="${bestRecommendPostings}" varStatus="count">
						<tr>
							<td align="center" width="30" align="left"><img src="${contextPath}/images/givus/${count.count}.gif"></td>
							<td align="left">${posting.renderedData.subject}</td>
							<td align="center" width="50">${posting.recommendCount}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<%-- //////////////// BOARD POSTING TABLE //////////////// --%>
			<div style="width:700px;float:left;text-align:center;margin:10px 10px 10px 40px;">
				<table>
					<tr>
						<td colspan="6"><img src="${imageHandler.g_board_title}" width="756" height="36"></td>
					</tr>
					<tr>
						<td width="76"><img src="${imageHandler.g_no}" alt="" width="76" height="33" /></td>
		                <td width="310"><img src="${imageHandler.g_subject}" alt="" width="310" height="33" /></td>
		                <td width="110"><img src="${imageHandler.g_name}" alt="" width="110" height="33" /></td>
		                <td width="80"><img src="${imageHandler.g_recommend_b}" alt="" width="80" height="33" /></td>
		                <td width="80"><img src="${imageHandler.g_hits_b}" alt="" width="80" height="33" /></td>
		                <td width="100"><img src="${imageHandler.g_date}" alt="" width="100" height="33" /></td>
					</tr>
					<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
					<tr class="table-data-tr ${data.className}" id="${dispatcher.function.id}_tr_${data.id}">
						<c:forEach var="head" items="${dispatcher.headers}">
							<td class="table-data-td ${head.className}" align="${head.align}" width="${head.width}">
							<c:choose>
								<c:when test="${data.renderedData[head.name] != null}">
								${data.renderedData[head.name]} 
								</c:when>
								<c:otherwise>
								${data[head.name]}
								</c:otherwise>
							</c:choose>
							</td>
						</c:forEach>
					</tr>
					</c:forEach>
					
					<c:if test="${fn:length(dispatcher.datas)==0}">
					
					<tr class="right_table_data">
						<td colspan=12 class="right_table_data" style="text-align: center;padding:30px;border-bottom: 1px solid #d7dce5;">게시글이 없습니다.</td>
					</tr>
					</c:if>
					<tr>
						<td colspan=12 style="text-align: right;padding-top:5px">
							<a href="${contextPath}/___/p/posting/write/hboard/${boardId}/${postingCategoryId}?bid=${boardId}">
								<img src="${imageHandler.g_right_write}"></a>
						</td>
					</tr>
					
					<tr>
						<td colspan="6">
						<%-- navigation --%>
						<c:if test="${not empty dispatcher.navigations}">
							<div class="table-nav-div">
							<c:forEach var="nav" items="${dispatcher.navigations}">
								<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected btn btn-small">${nav.name}</span></a></c:if>
								<c:if test="${nav.selected == false}"><a href="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
							</c:forEach>
							</div>
						</c:if>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</td>
	</tr>
</table>
</td></tr>
</table>