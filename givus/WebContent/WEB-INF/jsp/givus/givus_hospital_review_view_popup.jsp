<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

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



<style type="text/css">
.popup-outline{
	width:800px;
	background: #ffffff;
	-webkit-border-radius: 9px;
	-moz-border-radius: 9px; 
	overflow-y: scroll;
}
.posting-epilogue-close{
	text-align: right;
}
.posting-epilogue-subject{
	padding-left: 37px;
	font-size: 12px;
	font-weight: bold;
	color: #444444;
	text-align: left;
	padding-top: 0px;
	height:30px;
}
.posting-epilogue-head{
	border-top: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
	height:40px;
}
.posting-epilogue-left{
	padding-left: 30px;
	padding-top: 25px;
	padding-right: 20px;
	width: 180px;
	float:left;
}
.posting-epilogue-count{
	margin-top:10px;
	color: #0f1217;
	float : left;
}
.posting-epilogue-createDate{
	margin-top:10px;
	color : #837f85;
	float : right;
	margin-right: 110px;
}
.posting-epilogue-writerinfo{
	text-align: left;
}
.posting-epilogue-dot{
	color: #bac0c2;
	padding-right: 10px;
	font-size: 8px;
	background: url(${imageHandler.g_hospital_icon_dot}) no-repeat;
}
.posting-epilogue-title{
	color : #444444;
	font-size: 12px;
	font-weight: bold;
}
.posting-epilogue-writerinfo-photo{
	color : #837f85;
	padding-left: 11px;
	padding-top: 16px;
}

.posting-epilogue-right{
	float:left;
	padding-left: 60px;
	margin-top: 25px;
	border-left: 1px solid #dadada;
	text-align: left;
	margin-bottom: 15px;
}
.review-evaluation-view-header{
	background:url( ${imageHandler.g_hospital_bg_hospital_review_evaluation_view});
	height:41px;
	width:443px;
	margin-top:15px;
	border-bottom: 1px solid #e5e5e5;
}
.review-evaluation-view-data{
	height:27px;width:441px;border-left: 1px solid #e5e5e5;border-bottom: 1px solid #e5e5e5;border-right: 1px solid #e5e5e5;
}
.evaluation-question-odd, .evaluation-question{
	height:19px;width:296px;float:left;padding-left:31px;padding-top:8px;border-right: 1px solid #e5e5e5;border-bottom: 1px solid #e5e5e5;
}
.evaluation-question-odd{
	background: #ffffff;
}
.evaluation-question{
	background: #f9fafa;
}
.evaluation-answer{
	height:20px;width:112px;float:left;padding-top:8px;text-align: center;color:#0057a3;
}
.posting-epilogue-contents{
	margin-bottom:0px;
	padding:5px;
	line-height: 170%;width:450px;height:120px;overflow-y: scroll;
}
</style>


	<div class="posting-epilogue-close">
		<img src="${imageHandler.g_popup_icon_close2}" align="right" alt="close this popup" class="close_epilogue">
	</div>
<div class="popup-outline">
	<!-- 제목 -->
	<div class="posting-epilogue-subject" >${dispatcher.data.subject}</div>
	
	<!-- 조회수/ 추천수 / 등록일 -->
	<div class="posting-epilogue-head">
		<div class="posting-epilogue-count" style="margin-left: 100px;">
			<img src="${imageHandler.g_hospital_view}"> <span>${dispatcher.data.viewCount}</span>
		</div>
		<div class="posting-epilogue-count" style="margin-left: 40px;">
			<img src="${imageHandler.g_hospital_good}"> <span>${dispatcher.data.recommendCount}</span>
		</div>
		<div class="posting-epilogue-createDate">${dispatcher.data.renderedData.createDate}</div>
	</div>
	
	<!-- 글쓴이 정보 및 추가 후기 정보 -->
	<div class="posting-contents" style="border-bottom:1px dashed #ccc;height:660px;">
		<div class="posting-epilogue-left">
			<!-- 평가자 -->
			<div class="posting-epilogue-writerinfo">
				<span class="posting-epilogue-dot"><!-- ● --></span><span class="posting-epilogue-title">평가자</span>
				<c:set var="writer_infos" value="${fn:split(dispatcher.data.customField2,',')}"/>
									
				<div class="posting-epilogue-writerinfo-photo">
					<c:forEach var="info" items="${writer_infos}" varStatus="status">
						<c:choose>
						<c:when test="${status.count==1}">
							<div style="float:left;margin-right:15px;">
							<c:choose>
								<c:when test="${info=='F'}"><img src="${imageHandler.g_hospital_woman}" alt="woman"></c:when>
								<c:otherwise><img src="${imageHandler.g_hospital_man}" alt="man"></c:otherwise>
							</c:choose>
							</div>
						</c:when>
						<c:otherwise>
						<div class="writer_info" style="padding-top:8px;">${info}</div>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
			</div>
		
		</div>
		
		<!-- 평가 내용 -->
		<div class="posting-epilogue-right">
			<div style="padding-bottom: 20px;">
				<span class="posting-epilogue-dot"></span>
				<span class="posting-epilogue-title">평가평점</span>
				<span class="" style="font-size:13px;padding-left:10px;">[ <span style="font-size:18px;color:#066dc6;font-weight:bold;">${reviewMean}</span> / 5 ]</span>
			</div>
			<div style="padding-bottom: 20px;">
				<span class="posting-epilogue-dot"></span><span class="posting-epilogue-title">만족도 평가</span>
				<div class="review-evaluation-view-header">
					<div style="width:190px;float:left;padding-left:140px;padding-top:16px;">평가항목</div>
					<div style="width:77px;float:left;padding-left:36px;padding-top:16px;">만족도</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review1']}</div>
					<div class="evaluation-answer">${reviewPoints.review1}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review2']}</div>
					<div class="evaluation-answer">${reviewPoints.review2}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review3']}</div>
					<div class="evaluation-answer">${reviewPoints.review3}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review4']}</div>
					<div class="evaluation-answer">${reviewPoints.review4}</div>
				</div>		
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review5']}</div>
					<div class="evaluation-answer">${reviewPoints.review5}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review6']}</div>
					<div class="evaluation-answer">${reviewPoints.review6}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review7']}</div>
					<div class="evaluation-answer">${reviewPoints.review7}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review8']}</div>
					<div class="evaluation-answer">${reviewPoints.review8}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review9']}</div>
					<div class="evaluation-answer">${reviewPoints.review9}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review10']}</div>
					<div class="evaluation-answer">${reviewPoints.review10}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question-odd">${msgHandler['reviewPoints.question.review11']}</div>
					<div class="evaluation-answer">${reviewPoints.review11}</div>
				</div>
				<div class="review-evaluation-view-data">
					<div class="evaluation-question">${msgHandler['reviewPoints.question.review12']}</div>
					<div class="evaluation-answer">${reviewPoints.review12}</div>
				</div>
			</div>
				
			<!-- 리뷰 내용 -->
			<div style="padding-bottom: 10px;">
				<span class="posting-epilogue-dot"></span><span class="posting-epilogue-title">종합리뷰</span>
			</div>
			<div class="posting-epilogue-contents">
				${dispatcher.data.contents}
			</div>
		</div>

	</div>
	<div id="recommand_posting" data-postingId="${dispatcher.data.id}" class="posting-epilogue-recommend" style="padding:5px;" >
		<img src="${imageHandler.g_hospital_bt_recommend_with_msg}" alt="이 글을 추천해주세요!" title="이 글을 추천해주세요!">
	</div>
</div>