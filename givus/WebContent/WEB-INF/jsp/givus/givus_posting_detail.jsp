<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<%-- CKEDITOR --%>
<script src="${contextPath}/plugin/ckeditor/ckeditor.js"></script>

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
.board_outline{
	border: 1px solid #CCCCCC;
}
.board_left{
	float:left;
	color: #444444;
	width:145px;
}
.board_right{
	border-left: 1px solid #CCCCCC;
	padding-top: 5px;
	padding-bottom: 20px;
}
.board-list{
	border-top: 1px solid #CCCCCC;
	list-style:none;
	padding:0px;
	margin:0px;
	text-align: left;
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

.posting_view_title{
	font-size: 24px;
	float:left;
	text-align: left;
}
.comment_count{
	font-size: 14px;
	color: #ec4d37;
	float:left;
}
.posting_view_boardpath, .posting_view_boardpath a{
	color: #005ea6;
	float:left;
}
.posting_view_bar{
	color: #ebe3eb;
}
.posting_view_writer{
	color: #333333;
	float:left;
}
.posting_view_viewcount_createdate{
	color: #999999;
	float:right;
	text-align: right;
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
.view-posting-contents{
	white-space: normal;
	word-wrap: break-all;
	padding: 10px 15px 15px 10px;
	line-height: 1.5em;
	text-align: left;
}
.posting_view_comment_count{
	font-size: 24px;
	color: #ec4d37;
	text-align: left;
}
.posting_view_comment_msg{
	font-size: 13px;
	color: #434343;
	text-align: left;
	font-weight: bold;
}
.comment-header{
	width:100%;
	height:20px;
	padding-top:20px;
	text-align: left;
	padding-left:10px;
}
.comment-writer{
	color: #48688f;
}
.comment-writedate{
	color: #aaaaaa;
	padding-left:10px;
}
.comment-contents{
	text-align: left;
	line-height: 1.5em;
	word-wrap: break-all;
	white-space: normal;
	color: #434343;
	padding-left:10px;
}
.comment-outline{
	border:1px solid #d6d6d6;
	background-color: #eceff8;
	height: 300px;
}
.comment-outline2{
	border:1px solid #d6d6d6;
	background-color: #ffffff;
	height: 300px;
	float: left;
	margin-left: 110px;
}
.comment-left{
	color: #004b85;
	text-shadow: 1px 1px 1px #88a0b4;
	font-size: 14px;
	font-weight: bold;
	width: 100px;
}
.comment-right{
	background-color: #eceff8;
	vertical-align: middle;
	padding-top:7px;
}

.attachment{
	padding-left: 10px;
}
.reply-comment-form{
	text-align: right;
	width:100%;
}
.reply-comment-textarea{
	text-align: right;
}
.reply-comment, .delete-comment, .modify-comment{
	color: #999999;
}
.comment-div{
	width: 100%;
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
			<c:choose>
			<c:when test="${boardType == 'hboard'}"><td class="path_info" align="left"> 게시판 > 병원회원공간 > ${dispatcher.data.renderedData['boardId']}</td></c:when>
			<c:otherwise> <td class="path_info" align="left"> 게시판 > 일반회원공간 > ${dispatcher.data.renderedData['boardId']}</td></c:otherwise>
			</c:choose>
		</tr>
	</table>
	
	<table width="980px" style="margin:auto;">
		<tr>
		<c:choose>
			<c:when test="${boardType == 'hboard'}">
				<td width="145px" height="52px" class="body_title_name" align="center">병원회원공간</td>
				<td class="body_title_desc" align="left">병원스탭들이 자유롭게 이야기를 나눌 수 있는 자리 입니다. </td>
			</c:when>
			<c:otherwise>
			<td width="145px" height="52px" class="body_title_name" align="center">게시판</td>
			<td class="body_title_desc" align="left">아름다움(美)에 관심있는 모든 분들이 자유롭게 이야기를 나눌 수 있는 자리 입니다. </td>
			</c:otherwise>
		</c:choose>
		</tr>
		<tr class="board_outline">
			<td class="board_left"><!--   -->
			<%-- //////////////// BOARD MENU //////////////// --%>
<style type="text/css">
.boardmenus {
	list-style:none;
	padding:0px;
	margin:0px;	
}
.boardmenus > li{
	list-style:none;
	padding:0px;
	margin:0px;	
	width:145px;
	float: left; 
	display: block;
	vertical-align: middle;
	padding-top: 10px;
}
.boardmenus > li a:visited, .boardmenus > li a:link, .boardmenus > li a:hover{
	text-decoration:none;
}
.boardmenus > li a:hover{
	color: #19498C;
}

.tab_selected {
	background: #ffffff;
	color: #005ea6;
	font-family: "나눔고딕 ExtraBold";
	font-size: 13px;
	width:145px;
	border-top: 2px solid #005ea6;
	border-bottom: 1px solid #005ea6;
	border-left: 1px solid #005ea6;
}
.tab_selected a{
	color: #005ea6;
	font-family: "나눔고딕 ExtraBold";
}
.tab_not_selected {
	background: #f6f7f8;
	color: #444444;
	font-size: 13px;
	font-family: "나눔고딕 ExtraBold";
	width:145px;
	border-top: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
}
.tab_not_selected a{
	color: #444444;
	font-family: "나눔고딕 ExtraBold";
}
</style>
<SCRIPT type=text/javascript>
	/*
	* @desc : best list tab menu
	*/
	function displayTopTabMenu(menuId1, menuId2) {
		$("#"+menuId1).removeClass("tab_not_selected").addClass( "tab_selected");
		$("#"+menuId2).removeClass("tab_selected").addClass( "tab_not_selected");
	}
	
	function hideTopTabMenu(menuId1, menuId2){

		if ( $("#"+menuId1).attr('clicked') != 'true'){
			$("#"+menuId1).removeClass("tab_selected").addClass('tab_not_selected');
			$("#"+menuId2).removeClass("tab_not_selected").addClass( "tab_selected");
		}
		if ( $("#"+menuId2).attr('clicked') != 'true'){
			$("#"+menuId2).removeClass("tab_selected").addClass('tab_not_selected');
			$("#"+menuId1).removeClass("tab_not_selected").addClass( "tab_selected");
		}
	}
	
	// 각 메뉴별 click 이벤트 설정
	$(function(){
		
		$("#topmenuTab1").click( function(){
			$("#topmenuTab1").removeClass("tab_not_selected").addClass( "tab_selected");
			$("#topmenuTab2").removeClass("tab_selected").addClass( "tab_not_selected");
		}).click();
		
		$("#topmenuTab2").click( function(){
			$("#topmenuTab2").removeClass("tab_not_selected").addClass( "tab_selected");
			$("#topmenuTab1").removeClass("tab_selected").addClass( "tab_not_selected");
		});	
	});
</SCRIPT>

				<ul class="board-list">
					<c:forEach var="menu" items="${leftMenu.children}" varStatus="count">
					<li>
					<c:choose>
						<c:when test="${menu.relatedType == 'board'}">
						<a href="${contextPath}/___/p/${boardType}/${menu.relatedId}/${menu.relatedSubId}">${menu.name}</a>
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
							<a href="${contextPath}/___/p/${boardType}/${menu2.relatedId}/${menu2.relatedSubId}">${menu2.name}</a>
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
			</td>
			
			<td  class="board_right">
			<%-- //////////////// VIEW POSTING BUTTONS //////////////// --%>
				<table style="width:760px;float:left;text-align:right;margin:10px 10px 10px 40px;">
					<tr>
						<td width="760px">
							<c:set var="deleteXpath" value="${contextPath}/___/p/${boardType}/${dispatcher.data.boardId}/${dispatcher.data.categoryId}"/>
							<c:set var="deletefid" value="${funcHandler.funcPostingDeleteBoardPage.id}"/>
							<c:forEach var="button" items="${dispatcher.buttons}">
								<c:if test="${button.title=='수정'}"><a href="${contextPath}/___/p/posting/modify/${boardType}/${dispatcher.data.id}" target="${button.target}"><img src="${imageHandler.g_board_bt_modify}" alt="수정"></a></c:if>
								<c:if test="${button.title=='삭제'}"><a href="${contextPath}/delete.do?fid=${deletefid}&id=${dispatcher.data.id}&xpath=${deleteXpath}" target="${button.target}"><img src="${imageHandler.g_board_bt_delete}" alt="삭제"></a><%-- <a href="${button.link}" target="${button.target}"><img src="${imageHandler.g_board_bt_delete}" alt="삭제"></a> --%></c:if>
								<c:if test="${button.title=='목록'}"><a href="${deleteXpath}" target="${button.target}"><img src="${imageHandler.g_board_bt_list}" alt="목록"></a></c:if>
							</c:forEach>
							
							<c:if test="${prevPosting!=null && prevPosting.id > 0 }"><a href="${contextPath}/___/p/posting/detail/${boardType}/${prevPosting.id}"><img src="${imageHandler.g_board_bt_prev_contents}" alt="이전글" ></a></c:if>
							<c:if test="${nextPosting!=null && nextPosting.id > 0 }"><a href="${contextPath}/___/p/posting/detail/${boardType}/${nextPosting.id}"><img src="${imageHandler.g_board_bt_next_contents}" alt="다음글"></a></c:if>
								
						</td>
					</tr>
				</table>
					
			<%-- //////////////// VIEW POSTING //////////////// --%>
			
				<table style="width:760px;float:left;text-align:center;margin:10px 10px 10px 40px;">
					<tr>
						<td height="40px">
							<div class="posting_view_title">${dispatcher.data.subject}</div>
							<c:if test="${dispatcher.data.commentCount>0}"><div class="comment_count">[${dispatcher.data.commentCount}]</div></c:if>
						</td>
					</tr>
					<tr>
						<td height="30px">
							<div class="posting_view_boardpath">
								${dispatcher.data.renderedData['boardId']}
								<c:if test="${dispatcher.data.categoryId>0}">&nbsp;>&nbsp;${dispatcher.data.renderedData['categoryId']}</c:if>
								<span class="posting_view_bar">&nbsp;|&nbsp;</span>
							</div>
							<div class="posting_view_writer"> ${dispatcher.data.renderedData.creator}</div>
							<%-- TODO: 신고에 대한 기능 개발
							<div class="posting_view_bar">&nbsp;|&nbsp;<img src="${imageHandler.g_board_icon_report}" alt="신고"></div> --%>
							<div class="posting_view_viewcount_createdate">조회: ${dispatcher.data.renderedData['viewCount']}
								<span class="posting_view_bar">&nbsp;|&nbsp;</span>
								등록일 : ${dispatcher.data.renderedData['createDate']}
								<!-- </div> -->
								<c:if test="${dispatcher.data.board.useRecommend == 'Y' }"> <%--#################### Recommend Count ####################--%>
									&nbsp;<span class="posting_view_bar">&nbsp;|&nbsp;</span>
										 추천수 : <span id="recommendCount">${dispatcher.data.recommendCount}</span> &nbsp;
										<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
											<%-- <span class="btn btn-warning btn-mini"><i class="icon-thumbs-up icon-white"></i> ${msgHandler['posting.button.recommend']}</span> --%>
											<img src="${imageHandler.g_board_bt_recommend}" alt="추천하기" title="추천하기">
										</a>
								</c:if> 
							</div>
						</td>
					</tr>
							
					<tr>
						<td class="posting_view_h_bar" width="100%"></td>
					</tr>
					<%-- Attachment Files --%>
					<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y' && dispatcher.data.files != null}">	
						<c:forEach var="file" items="${dispatcher.data.files}">
					<tr>
						<td class="view-posting-contents">
							<div class="attachment">
							<a href="${contextPath}/___/file/download/${file.id}"><span class="property-value"> <i class="icon-circle-arrow-down"></i> ${file.name} </span>(<span class="fileSize text-right">${file.size}</span>)</a>
							</div>
						</td>
					</tr>
						</c:forEach>
					</c:if>
					<tr><%--#################### Posting Contents ####################--%>
						<td class="view-posting-contents">
							<div id="contents_value" class="view-posting-contents">
								${dispatcher.data.contents}
							</div>
						</td>
					</tr>
					<c:if test="${ dispatcher.data.postingType == 'R'}">
					<tr><%--#################### RSS Posting Reference URL ####################--%>
						<td class="view-posting-contents">
							<div class="reference">
							출처 : <a href="${dispatcher.data.referenceURL}" target="_blank"><span class="property-value"> ${dispatcher.data.referenceURL}</span></a>
							</div>
						</td>
					</tr>
					</c:if>
					<c:if test="${ board.boardType == 'Q' && answerComment != null}">
					<tr><%--#################### Answer Contents ####################--%>
						<td class="property-value-td">
							<div id="contents_value" class="view-posting-contents">
								<span class="btn btn-mini btn-warning disabled">${msgHandler['posting.view.best_answer_title']}</span>
								<div class="comment-header">
									<span class="comment-writer">${answerComment.creator}</span> <span class="comment-writedate">${answerComment.renderedData.createDate}</span>
								</div>
								<div style="width:100%;padding:3px;">
									<div class="comment-contents">${answerComment.contents}</div>
								</div>
							</div>
						</td>
					</tr>
					</c:if>
					<tr>
						<td class="posting_view_h_bar_slim" width="100%" height="10"></td>
					</tr>
							
					<tr>
						<td>
						<c:if test="${ board.useRecommend == 'Y'}"><%--#################### Recommend ####################--%>
							<div class="text-center" style="height:50px;">
								<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
									<img src="${imageHandler.g_board_bt_recommend}" alt="추천하기" title="추천하기">
								</a>
							</div>
						</c:if>
						</td>
					</tr>
					
					<c:if test="${ dispatcher.data.board.useComment == 'Y'}"><%--#################### Comment ####################--%>
					<tr>
						<td height="40px" class="view-posting-contents">
							<span class="posting_view_comment_count">
								<c:if test="${dispatcher.data.commentCount>0}">${dispatcher.data.commentCount}</c:if>
								<c:if test="${dispatcher.data.commentCount==0 || dispatcher.data.commentCount==null}">0</c:if>
							</span>
							<span class="posting_view_comment_msg"> 개의 댓글</span>
						</td>
					</tr>
					<tr>
						<td class="comment-outline">
							<div class="comment-right">
							<%--#################### Comment Form ####################--%>
							<form:form id="form" action="${contextPath}/edit.do?fid=CA&xpath=${xpath}" method="POST">
							<div class="comment-div" style="clear:both;">
								<table class="table table-striped">
									<tr>
										<td class="comment-left">댓글쓰기</td>
										<td class="comment-right" width="550"><textarea id="contents" name="contents"></textarea></td>
										<td style="width:100px;"><a href="javascript:dynamic.util.submitForm('form')"><img src="${ imageHandler.g_board_bt_confirm}" alt="등록"><%-- <span class="btn btn-small"><i class="icon-ok"></i> ${msgHandler['button.create']}</span> --%></a></td>
									</tr>
								</table>
							</div>
							<input type="hidden" name="postingId" value="${dispatcher.data.id}"/>
							</form:form>
							</div>
						</td>
					</tr>
					<%--#################### Comment List####################--%>
							
					<c:if test="${dispatcher.data.comments != null}">
						
					<tr >
						<td class="property-value-td" width="100%" height="${fn:length(dispatcher.data.comments) * 130}px">
						<table style="width:100%;height:100%;">
					<c:forEach var="comment" items="${dispatcher.data.comments}">
						<tr><td>
							<div style="padding-left:${comment.depth * 30}px">
							
								<a href="#comment_${comment.id}"></a>
								<div class="comment-header">
									<c:if test="${comment.depth > 0}"><img src="${imageHandler.g_board_icon_reply }" alt="->"></c:if>
									<span class="comment-writer">${comment.renderedData.creator}</span> 
									<span class="comment-writedate">${comment.renderedData.createDate}</span>
									<c:if test="${ board.boardType == 'Q' && answerComment == null}"><%--#################### Q&A Board ####################--%>
										<a href="javascript:dynamic.contents.selectBestAnswer('form_best_answer_${comment.id}');"><span class="btn btn-mini btn-warning">${msgHandler['comment.button.select_best_answer']}</span></a>
										<form id="form_best_answer_${comment.id}" action="${contextPath}/___/posting/answer/select/${dispatcher.data.id}" method="POST">
											<input type="hidden" name="commentId" value="${comment.id}"/>
											<input type="hidden" name="xpath" value="${xpath}"/>
										</form>
									</c:if>
								</div>
								<div style="width:100%;padding:3px;">
									<div class="comment-contents">
										<c:if test="${comment.renderedData.contents != null}">${comment.renderedData.contents}</c:if>
										<c:if test="${comment.renderedData.contents == null}">${comment.contents}</c:if>
									</div>
								</div>
							</div>
							<%--#################### Comment Buttons ####################--%>
							<div style="width:100%;height:25px;text-align:right;padding:3px;">
								<span class="reply-comment">답글 <span style="color:#e82a1e;">0</span> 개</span>
								<c:if test="${comment.isDelete == 'N' && answerComment.id != comment.id}">
								<span class="posting_view_bar">&nbsp;|&nbsp;</span><span class="btn btn-mini reply-comment">${msgHandler['comment.button.reply']}</span>
								<c:if test="${comment.renderedData.isOwner == 'Y'}">
									<span class="posting_view_bar">&nbsp;|&nbsp;</span><span class="btn btn-mini modify-comment">${msgHandler['comment.button.modify']}</span>
									<span class="posting_view_bar">&nbsp;|&nbsp;</span><a href="javascript:dynamic.contents.deleteComment('form_comment_delete_${comment.id}');"><span class="btn btn-mini delete-comment">${msgHandler['comment.button.delete']}</span></a>
									<form id="form_comment_delete_${comment.id}" action="${contextPath}/delete.do?fid=CD" method="POST">
										<input type="hidden" name="id" value="${comment.id}"/>
										<input type="hidden" name="xpath" value="${xpath}"/>
									</form>
								</c:if>
								</c:if>
							</div>
							
							<div class="comment-form" style="display:none;">
							<div class="comment-outline2">
								<div class="comment-textarea">
									<form id="form_comment_${comment.id}" action="${contextPath}/edit.do?fid=CC&xpath=${xpath}" method="POST">
									<table width="100%">
										<tr>
											<td class="comment-left" >답글쓰기</td>
											<td align="right" width="450"><textarea id="comment_${comment.id}" name="contents" ></textarea></td>
											<td style="width:100px;" align="center"><a href="javascript:dynamic.util.submitForm('form_comment_${comment.id}')"><span class="btn btn-mini"><img src="${ imageHandler.g_board_bt_confirm}" alt="등록"><%-- <span class="btn btn-mini"><i class="icon-ok"></i> ${msgHandler['button.create']}</span> --%></a></td>
										</tr>
									</table>
									<input type="hidden" name="id" value="${comment.id}"/>
									<input type="hidden" name="action"/>
									<input type="hidden" name="parentCommentId" value="${comment.id}"/>
									<input type="hidden" name="postingId" value="${dispatcher.data.id}"/>
									</form>
								</div>
							</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="padding-left:${comment.depth * 30}px">
								<c:if test="${comment.depth==0 }">
									<div class="posting_view_h_bar_slim" width="100%"></div>
								</c:if>
								<c:if test="${comment.depth>0 }">
									<div class="posting_view_h_bar_slim_dash" width="100%"></div>
								</c:if>
							</div>
					
						</td>
					</tr>
					</c:forEach>
					</table>
					</td>
					</tr>
					</c:if>
				</c:if>
				</table>
					
				<%-- //////////////// VIEW POSTING BUTTONS //////////////// --%>
				
				<table style="width:760px;float:left;text-align:right;margin:10px 10px 10px 40px;">
					<tr>
						<td width="760px">
							<c:if test="${dispatcher.data.boardId != 29}">
							<a href="${contextPath}/___/p/posting/write/${boardType}/${dispatcher.data.boardId}/${dispatcher.data.categoryId}?bid=${dispatcher.data.boardId}"><img src="${imageHandler.g_right_write}"></a>
							</c:if>
							<a href="${contextPath}/___/p/${boardType}"><img src="${imageHandler.g_board_bt_posting_home}" alt="게시판홈"></a>
							
							<c:forEach var="button" items="${dispatcher.buttons}">
								<c:if test="${button.title=='수정'}"><a href="${contextPath}/___/p/posting/modify/${boardType}/${dispatcher.data.id}" target="${button.target}"><img src="${imageHandler.g_board_bt_modify}" alt="수정"></a></c:if>
								<c:if test="${button.title=='삭제'}"><a href="${contextPath}/delete.do?fid=${deletefid}&id=${dispatcher.data.id}&xpath=${deleteXpath}" target="${button.target}"><img src="${imageHandler.g_board_bt_delete}" alt="삭제"></a><%-- <a href="${button.link}" target="${button.target}"><img src="${imageHandler.g_board_bt_delete}" alt="삭제"></a> --%></c:if>
								<c:if test="${button.title=='목록'}"><a href="${deleteXpath}" target="${button.target}"><img src="${imageHandler.g_board_bt_list}" alt="목록"></a></c:if>
							</c:forEach>
							<c:if test="${prevPosting!=null && prevPosting.id > 0 }"><a href="${contextPath}/___/p/posting/detail/${boardType}/${prevPosting.id}"><img src="${imageHandler.g_board_bt_prev_contents}" alt="이전글" ></a></c:if>
							<c:if test="${nextPosting!=null && nextPosting.id > 0 }"><a href="${contextPath}/___/p/posting/detail/${boardType}/${nextPosting.id}"><img src="${imageHandler.g_board_bt_next_contents}" alt="다음글"></a></c:if>
						</td>
					</tr>
					<tr>
						<td style="border-bottom:2px solid #d6d6d6;height:20px;">
						</td>
					</tr>
					<c:if test="${prevPosting!=null && prevPosting.id > 0 }">
					<tr>
						<td align="left" style="border-bottom:1px solid #d6d6d6;height:40px;padding-left:10px;">
							<a href="${contextPath}/___/p/posting/detail/${boardType}/${prevPosting.id}">
								<span style="float: left;"><img src="${imageHandler.g_board_bt_prev_contents}" alt="이전글" >
								${prevPosting.subject}</span>
								<span style="float: right;">${prevPosting.renderedData['createDate']}</span>
							</a>
						</td>
					</tr>
					</c:if>
					<c:if test="${nextPosting!=null && nextPosting.id > 0 }">
					<tr>
						<td align="left" style="border-bottom:1px solid #d6d6d6;height:40px;padding-left:10px;">
							<a href="${contextPath}/___/p/posting/detail/${boardType}/${nextPosting.id}">
								<span style="float: left;"><img src="${imageHandler.g_board_bt_next_contents}" alt="다음글" >
								${nextPosting.subject}</span>
								<span style="float: right;">${nextPosting.renderedData['createDate']}</span>
							</a>
						</td>
					</tr>
					</c:if>
				</table>
			</td>
		</tr>	


	</table>

</td></tr></table>