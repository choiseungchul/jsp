<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<c:set var="answerComment" value="${dispatcher.data.answerComment}"/>
<c:set var="board" value="${dispatcher.data.board}"/>
<%-- CKEDITOR --%>
<script src="${contextPath}/plugin/ckeditor/ckeditor.js"></script>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>
<style>
.property-value{
	white-space: normal;
}
.table td{
	line-height: 18px;
	padding: 5px;
}
.view-posting-subject{
	font-size: 13px;
	font-weight: bold;
	color:black;
	height:21px;
	padding-top:5px;
}
.view-posting-creatorinfo{
}
.view-posting-contents{
	white-space: normal;
	word-wrap: break-all;
	padding: 10px 5px 5px 10px;
	line-height: 1.5em;
}
.comment-header{
	width:100%;height:20px;border-bottom:1px dotted #f9f9f9;background-color:#f8f8f9;padding:3px;
}
.comment-writer{
	font-weight: bold;
}
.comment-contents{
	line-height: 1.5em;
	word-wrap: break-all;
	white-space: normal;
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
<div class="wrapper">
<c:choose>
	<c:when test="${dispatcher.function.width > 0}">
	<div class="property-view" style="width:${dispatcher.function.width}px;margin:0 auto;">
	</c:when>
	<c:otherwise>
	<div class="property-view">
	</c:otherwise>
</c:choose>
	<div style="height:35px;">
		<!-- title -->
		<div class="property-title-div" style="width:200px;float:left;">
			<c:if test="${dispatcher.function.title != null}">
				<span class="table-title">${dispatcher.function.title}</span> 
			</c:if>
		</div>
		<div style="float:right;">
			<c:forEach var="button" items="${dispatcher.buttons}">
				<a href="${button.link}" target="${button.target}"><span class="btn btn-small"><i class="${button.className}"></i> ${button.title}</span></a>
			</c:forEach>
		</div>
	</div>
	<table class="table">
		<tr><%-- subject --%>
			<td class="property-value-td" style="background-color:#f8f8f9;">
				<div id="subject_value" class="view-posting-subject">
					${dispatcher.data.subject}
				</div>
			</td>
		</tr>
		<tr><%-- creator --%>
			<td class="property-value-td">
				<div id="subject_value" class="view-posting-creatorinfo">
					${msgHandler['posting.view.writer']} : ${dispatcher.data.renderedData.creator} &nbsp; ${msgHandler['posting.view.writeDate']} : ${dispatcher.data.renderedData.createDate} &nbsp; ${msgHandler['posting.view.viewCount']} : ${dispatcher.data.viewCount}
					<c:if test="${board.useRecommend == 'Y' }"> <%--#################### Recommend Count ####################--%>
						&nbsp; 추천수 : <span id="recommendCount">${dispatcher.data.recommendCount}</span> &nbsp;
						<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
							<span class="btn btn-warning btn-mini"><i class="icon-thumbs-up icon-white"></i> ${msgHandler['posting.button.recommend']}</span>
						</a>
					</c:if> 
				</div>
			</td>
		</tr>
		<%-- Attachment Files --%>
		<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y' && dispatcher.data.files != null}">	
			<c:forEach var="file" items="${dispatcher.data.files}">
			<tr>
				<td class="property-value-td">
					<div class="attachment">
					<a href="${contextPath}/___/file/download/${file.id}"><span class="property-value"> <i class="icon-circle-arrow-down"></i> ${file.name} </span>(<span class="fileSize text-right">${file.size}</span>)</a>
					</div>
				</td>
			</tr>
			</c:forEach>
		</c:if>
		<c:if test="${ dispatcher.data.postingType == 'R'}">
		<tr><%--#################### RSS Posting Reference URL ####################--%>
			<td class="property-value-td">
				<div class="reference">
				출처 : <a href="${dispatcher.data.referenceURL}" target="_blank"><span class="property-value"> ${dispatcher.data.referenceURL}</span></a>
				</div>
			</td>
		</tr>
		</c:if>
		<tr><%--#################### Posting Contents ####################--%>
			<td class="property-value-td">
				<div id="contents_value" class="view-posting-contents">
					${dispatcher.data.contents}
				</div>
			</td>
		</tr>
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
	</table>
	<c:if test="${ board.useRecommend == 'Y'}"><%--#################### Recommend ####################--%>
		<div class="text-center" style="height:50px;">
			<a href="javascript:dynamic.contents.recommendPosting(${dispatcher.data.id});">
				<span class="btn btn-warning btn-mini"><i class="icon-thumbs-up icon-white"></i> ${msgHandler['posting.button.recommend']}</span>
			</a>
		</div>
	</c:if>
	<c:if test="${ dispatcher.data.board.useComment == 'Y'}"><%--#################### Comment ####################--%>
		<c:if test="${dispatcher.data.comments != null}">
		<div class="comments-div" style="clear:both;">
			<table class="table">
				<c:forEach var="comment" items="${dispatcher.data.comments}">
				<tr style="height:30px;">
					<td class="property-value-td">
						<div style="padding-left:${comment.depth * 40}px">
							<a href="#comment_${comment.id}"></a>
							<div class="comment-header">
								<span class="comment-writer">${comment.creator}</span> <span class="comment-writedate">${comment.renderedData.createDate}</span>
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
						</div><%--#################### Comment Buttons ####################--%>
						<div style="width:100%;height:25px;text-align:right;padding:3px;">
							<c:if test="${comment.isDelete == 'N' && answerComment.id != comment.id}">
							<span class="btn btn-mini reply-comment">${msgHandler['comment.button.reply']}</span>
							<c:if test="${comment.renderedData.isOwner == 'Y'}">
								<span class="btn btn-mini modify-comment">${msgHandler['comment.button.modify']}</span>
								<a href="javascript:dynamic.contents.deleteComment('form_comment_delete_${comment.id}');"><span class="btn btn-mini">${msgHandler['comment.button.delete']}</span></a>
								<form id="form_comment_delete_${comment.id}" action="${contextPath}/delete.do?fid=CD" method="POST">
									<input type="hidden" name="id" value="${comment.id}"/>
									<input type="hidden" name="xpath" value="${xpath}"/>
								</form>
							</c:if>
							</c:if>
						</div>
						<div class="comment-form" style="display:none;">
							<div class="comment-textarea">
								<form id="form_comment_${comment.id}" action="${contextPath}/edit.do?fid=CC&xpath=${xpath}" method="POST">
								<table width="100%">
									<tr>
										<td width="100"></td>
										<td align="right"><textarea id="comment_${comment.id}" name="contents"></textarea></td>
										<td width="50" align="right"><a href="javascript:dynamic.util.submitForm('form_comment_${comment.id}')"><span class="btn btn-mini"><i class="icon-ok"></i> ${msgHandler['button.create']}</span></a></td>
									</tr>
								</table>
								<input type="hidden" name="id" value="${comment.id}"/>
								<input type="hidden" name="action"/>
								<input type="hidden" name="parentCommentId" value="${comment.id}"/>
								<input type="hidden" name="postingId" value="${dispatcher.data.id}"/>
								</form>
							</div>
						</div>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		</c:if><%--#################### Comment Form ####################--%>
		<form:form id="form" action="${contextPath}/edit.do?fid=CA&xpath=${xpath}" method="POST">
		<div class="comment-div" style="clear:both;">
			<table class="table table-striped">
				<tr>
					<td class="property-value-td"><textarea id="contents" name="contents"></textarea></td>
					<td style="width:70px;"><a href="javascript:dynamic.util.submitForm('form')"><span class="btn btn-small"><i class="icon-ok"></i> ${msgHandler['button.create']}</span></a></td>
				</tr>
			</table>
		</div>
		<input type="hidden" name="postingId" value="${dispatcher.data.id}"/>
		</form:form>
	</c:if>
	
	<div class="property-buttons" style="float:right;">
		<c:forEach var="button" items="${dispatcher.buttons}">
			<a href="${button.link}" target="${button.target}"><span class="btn btn-small"><i class="${button.className}"></i> ${button.title}</span></a>
		</c:forEach>
	</div>
</div>
<div style="height:20px"></div>
</div>
