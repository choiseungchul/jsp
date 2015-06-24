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

.posting_view_title{
	font-size: 24px;
	float:left;
	text-align: left;
}
.posting_view_boardpath, .posting_view_boardpath a{
	color: #005ea6;
	float:left;
}
.posting_view_bar{
	color: #ebe3eb;
}
.posting_view_h_bar{
	border-top:2px solid #d6d6d6;
	padding-bottom: 20px;
}
.posting_view_h_bar_slim{
	border-top:1px solid #d6d6d6;
	padding-bottom: 30px;
}
.posting_view_h_bar_slim_dash{
	border-top:1px dashed #d6d6d6;
	padding-bottom: 30px;
}
.view-posting-creatorinfo{
}
.view-posting-contents{
	white-space: normal;
	word-wrap: break-all;
	padding: 10px 15px 15px 10px;
	line-height: 1.5em;
	text-align: left;
}
</style>
<script>
$(function(){
	var ckeditor_comment_config = {
		resize_enabled : false, 
		autoUpdateElement : true, 
		enterMode : CKEDITOR.ENTER_BR , 
		shiftEnterMode : CKEDITOR.ENTER_P , 
		toolbarCanCollapse : true , 
		skin:'moonocolor',
		toolbar : [
			[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
			[ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ],
			[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote']
		] 
	};
	
	CKEDITOR.replace('contents', ckeditor_comment_config);
	
	// file size;
	$('span.fileSize').each( function( idx, value){
		var fileSize = $(this).html();
		var formatedFileSize = utils._formatFileSize( parseInt(fileSize));
		$(this).html( formatedFileSize);
	});
	
	//
	$('.reply-comment').bind( 'click', function(){
		var td = $(this).closest('td');
		var frmDiv = td.find('.comment-form');
		
		var textarea = frmDiv.find('textarea');
		if( !textarea.attr('ckeditor_applied') || textarea.attr('ckeditor_applied') == 'N'){
			CKEDITOR.replace( $(textarea).attr('id'), ckeditor_comment_config);
			textarea.attr('ckeditor_applied', 'Y');
		}
		CKEDITOR.instances[$(textarea).attr('id')].setData('');
		frmDiv.find('input[name=action]').val('create');
		frmDiv.toggle();
	});
	
	$('.modify-comment').bind( 'click', function(){
		var td = $(this).closest('td');
		var frmDiv = td.find('.comment-form');
		
		var textarea = frmDiv.find('textarea');
		if( !textarea.attr('ckeditor_applied') || textarea.attr('ckeditor_applied') == 'N'){
			CKEDITOR.replace( $(textarea).attr('id'), ckeditor_comment_config);
			textarea.attr('ckeditor_applied', 'Y');
		}
		CKEDITOR.instances[$(textarea).attr('id')].setData(td.find('.comment-contents').html());
		frmDiv.find('input[name=action]').val('modify');
		frmDiv.toggle();
	});
});

var utils = {
	_formatFileSize : function (bytes) {
	    if (typeof bytes !== 'number') {
	        return '';
	    }
	    if (bytes >= 1000000000) {
	        return (bytes / 1073741824).toFixed(2) + ' GB';
	    }
	    if (bytes >= 1000000) {
	        return (bytes / 1048576).toFixed(2) + ' MB';
	    }
	    return (bytes / 1024).toFixed(2) + ' KB';
	}
};

dynamic.contents = {
	deleteComment : function( formId){
		if( confirm('${msgHandler['confirm.msg.comment.delete']}')){
			dynamic.util.submitForm( formId);
		}
	},
	selectBestAnswer : function( formId){
		if( confirm('${msgHandler['confirm.msg.select_best_answer']}')){
			dynamic.util.submitForm( formId);
		}
	},
	recommendPosting : function( postingId){
		var url = dynamic.constants.CONTEXTPATH + "/___/posting/recommend/" + postingId;
		$.getJSON( url, function( data){
			alert( data.message);	
		});
	}
};
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td align="center">
	<%-- //////////////// PATH INFO //////////////// --%>
	<table width="980" style="margin:auto;margin-top:20px;" >
		<tr>
			<td class="path_info" align="left">
				<c:choose>
				<c:when test="${boardType == 'howToUseGivus'}"> GIVUS 활용하기</c:when>
				<c:otherwise> CONTACT US > ${board.name }</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	<table width="980" style="margin:auto;" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<c:choose>
				<c:when test="${boardType == 'howToUseGivus'}">
			<td width="145px" height="52px" class="body_title_name" align="center">GIVUS 활용하기</td>
				</c:when>
				<c:otherwise>
			<td width="145px" height="52px" class="body_title_name" align="center">CONTACT US</td>
				</c:otherwise>
			</c:choose>
			<td class="body_title_desc" align="left">${ board.description}</td>
		</tr>
		<tr>
			<td width="145px" valign="top" height="860px"  class="body_subtitles" >
				<table width="145px" height="150px"  border="0" cellspacing="0" cellpadding="0">
				<c:choose>
					<c:when test="${boardType == 'howToUseGivus'}">
				<tr>
					<td height="30px"><a href="${contextPath}/___/p/howToUseGivus">GIVUS 활용하기</a></td>
				</tr>
					</c:when>
					<c:otherwise>
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
					</c:otherwise>
				</c:choose>
				<tr>
					<td height="170px"></td>
				</tr>
				</table>
			</td>
			<td width="830px" height="860px" class="notice_body" valign="top" align="center"> 				
				<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="body_top" width="700px" height="200px">
						<%-- <table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<img src="${imageHandler.g_right_logoset}">
							</td>
						</tr>
						</table> --%>
					</td>
				</tr>
				<tr>
					<td height="25px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> ${board.name }</td>
				</tr>
				
				<tr>
					<td class="posting_view_h_bar" width="100%"></td>
				</tr>
				<tr>
					<td height="40px">
						<div class="posting_view_title">${dispatcher.data.subject}</div>
					</td>
				</tr>
				<tr>
					<td height="30px">
						<div class="posting_view_boardpath">
							<a href="${contextPath}/___/p/${boardName}">${dispatcher.data.renderedData['boardId']}</a> 
							
							<span class="posting_view_bar">&nbsp;|&nbsp;</span>
						</div>
						
						<%-- TODO: 신고에 대한 기능 개발
						<div class="posting_view_bar">&nbsp;|&nbsp;<img src="${imageHandler.g_board_icon_report}" alt="신고"></div> --%>
						<div class="posting_view_viewcount_createdate">조회: ${dispatcher.data.renderedData['viewCount']}
							<span class="posting_view_bar">&nbsp;|&nbsp;</span>
							등록일 : ${dispatcher.data.renderedData['createDate']}</div>
						<c:if test="${board.useRecommend == 'Y' }"> <%--#################### Recommend Count ####################--%>
								&nbsp; 추천수 : <span id="recommendCount">${dispatcher.data.recommendCount}</span> &nbsp;
								<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
									<span class="btn btn-warning btn-mini"><i class="icon-thumbs-up icon-white"></i> ${msgHandler['posting.button.recommend']}</span>
								</a>
						</c:if> 
					</td>
				</tr>
				<tr><%-- creator --%>
					<td class="view-posting-contents">
						<div id="subject_value" class="view-posting-creatorinfo">
							<c:if test="${board.useRecommend == 'Y' }"> <%--#################### Recommend Count ####################--%>
								&nbsp; 추천수 : <span id="recommendCount">${dispatcher.data.recommendCount}</span> &nbsp;
								<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
									<img src="${imageHandler.g_board_bt_recommend}" alt="추천하기" title="추천하기">
								</a>
							</c:if> 
						</div>
					</td>
				</tr>
				<tr>
					<td class="posting_view_h_bar_slim" width="100%"></td>
				</tr>
				<tr>
					<td class="view-posting-contents">${dispatcher.data.contents}</td>
				</tr>
				</table>

			</td>
		</tr>
	</table>


</td></tr></table>
