<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<style>
.popup-outline{
	width:720px;
	padding-left: 25px;
	background: #ffffff;
	-webkit-border-radius: 9px;
	-moz-border-radius: 9px; 
}
.posting-epilogue-header, .posting-epilogue-contents{
	width:700px;
	line-height:170%;
}
.posting-epilogue-title{
	width:700px;
	height:40px;
	border-bottom:2px solid #4086bc;
	margin-bottom:10px;
}
.posting-epilogue-header{
	padding:5px;
}
.posting-epilogue-contents{
	margin-top:10px;
	border-top: 1px solid #ccc;
	padding-top:20px;
	margin-bottom: auto;
	overflow-y: scroll;
	height:300px;
}
.posting-epilogue-header .header{
	border-left: 1px solid #ccc;
	padding:10px;
}

.posting-epilogue-header .title{
	width: 100px;
	font-weight: bold;
	text-align: center;
}
.posting-epilogue-header .subject{
	color:#444444;
	font-weight: bold;
	font-size:14px;
	text-align:left;
	margin-bottom: 10px;
}
.posting-epilogue-header .createDate{
	color: #837f85;
	font-size:11px;
	text-align:left;
}
.posting-epilogue-header .count{
	font-size:12px;
	text-align:left;
	float:left;
	margin-right: 30px;
	color: #0f1217;
}
.posting-epilogue-header .creator{
	font-size:12px;
	text-align:right;
	color: #0f1217;
}
.title{
	color: #4086bc;
}
#recommand_posting{
	float:left;
}
.posting-buttons{
	padding-right: 3px;
	float:left;
}
.buttons-outline{
	width:700px;
	height:40px;
	border-top: 1px solid #ccc;
	padding-top: 10px;
}
</style>

<script type="text/javascript">
$( function(){
	$('.close_epilogue').click( function(){
		$.unblockUI();
	}).css('cursor', 'pointer');
	
	$('#recommand_posting').click( function(){
		dynamic.contents.recommendPosting('${dispatcher.data.id}');
		
	}).css('cursor', 'pointer');
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
});
</script>

<div class="popup-outline">
<div class="posting-epilogue-title">
	<img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" id="close_epilogue" class="close_epilogue">
</div>
<div class="posting-epilogue-viewer">
	<table class="posting-epilogue-header">
	<tr>
		<td class="title">병원후기</td>
		<td>
			<div class="header">
				<div class="subject">${dispatcher.data.subject}</div>
				<div class="createDate">${dispatcher.data.renderedData.createDate}</div>
				<div class="count">
					<img src="${imageHandler.g_hospital_view}"> <span>${dispatcher.data.viewCount}</span>
				</div><div class="count">
					<img src="${imageHandler.g_hospital_good}"> <span>${dispatcher.data.recommendCount}</span>
				</div>
				<c:if test="${ dispatcher.data.board.useRecommend == 'Y'}"><%--#################### Recommend ####################--%>
			<div id="recommand_posting" class="text-center" style="height:30px;" data-postingId="${dispatcher.data.id}">
				<img src="${imageHandler.g_board_bt_recommend}" alt="추천하기" title="추천하기">
			</div>
		</c:if>
				<div class="creator">${dispatcher.data.renderedData.creator}</div>
			</div>
		</td>
	</tr>
	</table>
	
		<div class="posting-epilogue-contents">
			${dispatcher.data.contents}
		<%-- Attachment Files --%>
			<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y' && dispatcher.data.files != null}">	
				<c:forEach var="file" items="${dispatcher.data.files}">
				<tr>
					<td class="property-value-td">
						<div class="attachment">
							<img src="/___/file/get/${file.id}">
						</div>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</div>
		<div class="buttons-outline">
			<div class="posting-buttons">
			<c:if test="${ dispatcher.data.board.useRecommend == 'Y'}"><%--#################### Recommend ####################--%>
				<div id="recommand_posting" class="text-center" style="height:20px;" data-postingId="${dispatcher.data.id}">
					<img src="${imageHandler.g_board_bt_recommend}" alt="추천하기" title="추천하기">
				</div>
			</c:if>
			</div>
			
			<c:set var="deleteXpath" value="${contextPath}/___/p/hepilogue/${dispatcher.data.customField1}"/>
			<c:set var="deletefid" value="${funcHandler.funcPostingDeleteBoardPage.id}"/>
			<c:forEach var="button" items="${dispatcher.buttons}">
			<div class="posting-buttons">
				<c:if test="${button.title=='수정'}"><%-- <div class="modify_posting"><img src="${imageHandler.g_board_bt_modify}" alt="수정" align="left"></div> --%></c:if>
				<c:if test="${button.title=='삭제'}"><a href="${contextPath}/delete.do?fid=${deletefid}&id=${dispatcher.data.id}&xpath=${deleteXpath}" target="${button.target}"><img src="${imageHandler.g_board_bt_delete}" alt="삭제" align="left"></a></c:if>
			</div>
			</c:forEach>
			<div class="posting-buttons"><img src="${imageHandler.g_board_bt_close}" alt="닫기" align="left" class="close_epilogue"></div>
		</div>
	</div>

</div>