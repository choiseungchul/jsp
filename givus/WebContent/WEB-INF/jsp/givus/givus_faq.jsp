<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<style type="text/css">

.path_info {
	color: #000;
	font-size: 12px;
	border-bottom: 1px solid #CCCCCC;
	height:30px;
	font-family: 나눔고딕, Arial Unicode MS, sans-serif;
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
.body_subtitles{
	border-left: 1px solid #CCCCCC;
	border-top: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
	background:url("${imageHandler.g_left_sub_bg}") no-repeat;
	color: #444444;
	font-size: 13px;
	align:center;
	text-align: center;
	vertical-align: top;
	font-weight: bold;
}
.notice_body {
	background:url("${imageHandler.g_right_body_bg_700}");
	border: 1px solid #CCCCCC;
	border-top: 0px;
}
.body_top{
	background:url("${imageHandler.g_right_logoset}") no-repeat right;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.right_table{
	border:1px solid #CCCCCC;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
}
.right_table_head {
	border-top:1px solid #CCCCCC;
	background-color: #ebedf2;
	background:url("${imageHandler.g_right_board_title_bg}");
	color: #444444;
	font-size: 12px;
	font-family: "나눔고딕","돋움", Arial Unicode MS, sans-serif;
	text-align: center;
	height:34px;
	font-weight: bold;
}
.right_table_head_bar{
	background:url("${imageHandler.g_right_board_title_bar}") no-repeat;
	vertical-align: middle;
	text-align:center
}
.right_table_data {
	border-top:1px solid #CCCCCC;
	background-color: #FFFFFF;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 550px;
	padding: 5px;
}
</style>

<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				CONTACT US > 자주묻는질문
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="145px" height="52px" class="body_title_name" align="center">CONTACT US</td>
			<td class="body_title_desc" align="left">"GIVUS"에 대한 자주묻는 질문을 조회할 수 있는 공간입니다. </td>
		</tr>
		<tr>
			<td width="145px" valign="top" height="860px"  class="body_subtitles">
				<table  width="145px" height="150px"  border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/notice">공지사항</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/faq">자주묻는질문</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/inquiry">1:1 문의</a></td>
				</tr>
				<tr>
					<td><img src="${imageHandler.g_left_sub_line}"></td>
				</tr>
				<tr>
					<td height="80px"></td>
				</tr>
				</table>
			</td>
			<td width="830px" height="860px" class="notice_body" valign="top" align="center"> 				
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="body_top" width="700px" height="200px">
						
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 자주묻는질문</td>
				</tr>
				<tr>
					<td class="right_table" width="830px">
						<%-- //////////////// BOARD POSTING TABLE //////////////// --%>
						<table>
							<tr class="right_table_head">
				                <td width="100" height="34" class="right_table_head">번호</td>
				                <td width="1" class="right_table_head_bar"></td>
				                <td width="400" class="right_table_head">제목</td>
				                <td width="1" class="right_table_head_bar"></td>
				                <td width="100" class="right_table_head">작성일</td>
				                <td width="1" class="right_table_head_bar"></td>
				                <td width="100" class="right_table_head">조회수</td>
				                <td width="1" ></td>
							</tr>
							<c:forEach var="data" items="${dispatcher.datas}" varStatus="datasLoop">
							<tr class="right_table_data" id="${dispatcher.function.id}_tr_${data.id}" height="35">
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
									<td width="1" ></td>
								</c:forEach>
							</tr>
							</c:forEach>
							<c:if test="${fn:length(dispatcher.datas)==0}">
							<tr class="right_table_data">
								<td colspan=8 class="right_table_data" style="text-align: center;padding:30px">게시글이 없습니다.</td>
							</tr>
							</c:if>
							
						</table>

					</td>
				</tr>
				<tr>
					<td colspan="8" align="center">
					<%-- navigation --%>
					<c:if test="${not empty dispatcher.navigations}">
						<div class="table-nav-div">
						<c:forEach var="nav" items="${dispatcher.navigations}">
							<c:if test="${nav.selected}"><a href="${nav.url}"><span class="table-nav-selected btn btn-small">${nav.name}</span></a></c:if>
							<c:if test="${nav.selected == false}"><a h ref="${nav.url}"><span class="${nav.className}">${nav.name}</span></a></c:if>
						</c:forEach>
						</div>
					</c:if>
					</td>
				</tr>
				</table>

			</td>
		</tr>
	</table>


</td></tr></table>
