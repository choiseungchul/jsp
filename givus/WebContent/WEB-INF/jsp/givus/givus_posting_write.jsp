<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- variable --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y'}">
<script src="${contextPath}/plugin/jquery_fileupload/js/vendor/jquery.ui.widget.js"></script>
<%-- The Templates plugin is included to render the upload/download listings --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/etc/tmpl.min.js"></script>
<%-- The Load Image plugin is included for the preview images and image resizing functionality --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/etc/load-image.min.js"></script>
<%-- The Canvas to Blob plugin is included for image resizing functionality --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/etc/canvas-to-blob.min.js"></script>
<%-- blueimp Gallery script --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/etc/jquery.blueimp-gallery.min.js"></script>

<%-- The Iframe Transport is required for browsers without support for XHR file uploads --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.iframe-transport.js"></script>
<%-- The basic File Upload plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload.js"></script>
<%-- The File Upload processing plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-process.js"></script>
<%-- The File Upload image preview & resize plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-image.js"></script>
<%-- The File Upload audio preview plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-audio.js"></script>
<%-- The File Upload video preview plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-video.js"></script>
<%-- The File Upload validation plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-validate.js"></script>
<%-- The File Upload user interface plugin --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/jquery.fileupload-ui.js"></script>
<%-- The main application script --%>
<script src="${contextPath}/plugin/jquery_fileupload/js/main.js"></script>

<%-- Generic page styles --%>
<link rel="stylesheet" href="${contextPath}/plugin/jquery_fileupload/css/style.css">
<%-- CSS to style the file input field as button and adjust the Bootstrap progress bars --%>
<link rel="stylesheet" href="${contextPath}/plugin/jquery_fileupload/css/jquery.fileupload.css">
</c:if>

<%-- CKEDITOR --%>
<script src="${contextPath}/plugin/ckeditor/ckeditor.js"></script>


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
	height:920px;
	float: left;
	border-right: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
}
.board_left{
	width:143px;
	height:920px;
	float:left;
	border-left: 1px solid #CCCCCC;
	border-right: 1px solid #CCCCCC;
	border-bottom: 1px solid #CCCCCC;
}
.right_subtitle{
	color: #214579;
	font-size: 13px;
	text-align: left;
	font-weight: bold;
}
.right_table{
	border-top: 2px solid #CCCCCC;
	color: #444444;
	font-size: 12px;
	text-align: left;
	width: 100%;
}
.table{margin-bottom:10px;}
.fileupload-buttonbar{height:30px;}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	margin-bottom:3px;
	font-size:9pt;
	font-family: "나눔고딕", "Helvetica Neue", Helvetica, Arial, sans-serif;
	border:1px solid #d4d4d4;
}
.feedback-input-box{
	border:1px solid #d4d4d4;
}
.property-view, .property-edit {
	width: 100%;
}

/* .property-title-td {
	width: 150px;
}

.property-value-td {
	width: auto;
} */
.property-title-td{
	background-color: #eceff8;
	/* color: #004b85; */
	color: #444444;
	text-shadow: 1px 1px 1px #88a0b4;
	font-size: 13px;
	font-weight: strong;
	width: 100px;
	border:1px solid #d4d4d4;
	vertical-align: middle;
	text-align: center;
	height: 40px;
	letter-spacing: 4px;
}
.property-value-td{
	vertical-align: middle;
	padding: 10px;
	border:1px solid #d4d4d4;
}

.property-buttons, .property-edit-buttons {

	font-size: 11px;
	margin-top: 10px;
	padding-top: 3px;
	height: 23px;
}
.btn-text{
	color: #005ea6;
	font-weight: bold;
	text-shadow: 1px 1px 1px #88a0b4;
}
.property-image {
	height:120px;
}
.property-error {
	color: red;
}
.property-desc{
	padding: 3px;
	line-height: 120%;
	color: blue;
}
</style>

<script>
$(function(){
	var ckeditor_config = {
		resize_enabled : true, // 에디터 리사이즈 여부
		autoUpdateElement : true, // 자동 textarea 업데이트 여부 (안됨)
		enterMode : CKEDITOR.ENTER_BR , // 에디터 엔터를 <br> 태그를 사용함.
		shiftEnterMode : CKEDITOR.ENTER_P , // 에디터 시프트 + 엔터를 <p> 태그를 사용함
		toolbarCanCollapse : true , // 에디터 툴바 숨기기 기능 여부
		skin:'moonocolor',
		height: 300, 
		pasteFromWordRemoveFontStyles : false,
		//filebrowserUploadUrl: '/Service/Upload/Uploader.ashx?type=Files', 
		filebrowserImageUploadUrl: dynamic.constants.CONTEXTPATH + '/___/file/upload2',
		//filebrowserFlashUploadUrl: '/Service/Upload/Uploader.ashx?type=Flash',
		// 에디터 툴바를 설정함.
		toolbar : [
			[ 'Source', 'Maximize', '-' , 'NewPage', 'Preview', 'Print' ],
			[ 'Cut', 'Copy', 'Paste', 'PasteText', '-', 'Undo', 'Redo' ],
			[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript'],
			[ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ],
			[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote'],
			'/',
			[ 'Styles', 'Format', 'Font', 'FontSize' ],
			[ 'TextColor', 'BGColor' ],
			[ 'Image', 'Flash', 'Table' , 'SpecialChar' , 'Link', 'Unlink']
		] 
	};
	ckeditor_config.extraAllowedContent = 'iframe[*]'; // stands for: iframe element with any attribute
	CKEDITOR.replace('contents', ckeditor_config);
	
	$('#cke_131_fileInput_input').click(function(){
		alert( $(this).val());
	});
	
});

var upload_info = {
	failCount : 0,
	uploadedFiles : new Array(),
	init : function(){
		this.failCount = 0;
	},
	getNumberOfFiles: function () {
		return $('#files').find('tr.template-upload') ? $('#files').find('tr.template-upload').length : 0;
	},
	getFormData : function(){
		return $('#fileupload').serializeArray();
	},
	maxFileSize: 10485760, // 10 MB
	maxNumberOfFiles : 10 // 10 file count
};
	
function submitFormWithFile(){
	if( upload_info.getNumberOfFiles() > 0){
		$("button.start").click();
	}else{  
		dynamic.util.submitForm('form');
	}
}

function ckeditorUploadComplete( CKEditorFuncNum, url, fileId){
	var contentsFileInfos = $(':hidden[name=contents_file_infos]');
	contentsFileInfos.val( contentsFileInfos.val() + fileId + ",");
	CKEDITOR.tools.callFunction( CKEditorFuncNum, url);
}


</script>

<div style="height:20px"></div>
<table width="980" style="margin:auto;maring-top:20px;">
	<tr>
		<c:choose>
			<c:when test="${boardType == 'hboard'}"><td class="path_info" align="left"> 게시판 > 병원회원공간 > ${dispatcher.data.renderedData['boardId']}</td></c:when>
			<c:otherwise> <td class="path_info" align="left"> 게시판 > 일반회원공간 > ${dispatcher.data.renderedData['boardId']}</td></c:otherwise>
		</c:choose>
	</tr>
</table>

<table width="100%"><tr><td align="center">

<table width="980px" style="margin:auto;">
	
		<tr><%-- //////////////// BOARD MENU //////////////// --%>
			<td valign="top" align="left">
			<div>
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
				</table>
			</div>
			<div class="board_left">
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
			</div>
			<div class="board_right">
				<%-- //////////////// VIEW POSTING BUTTONS //////////////// --%>
				<div style="width:760px;float:left;text-align:right;margin:10px 10px 10px 40px;">
					<table>
						<tr>
							<td width="760px">
								<a href="${contextPath}/___/p/${boardType}/${boardId}/${postingCategoryId}"><img src="${imageHandler.g_board_bt_list}" alt="목록"></a>
							</td>
						</tr>
					</table>
				</div>
				<%-- //////////////// WRITE POSTING //////////////// --%>
				<div style="width:760px;float:left;text-align:center;margin:10px 10px 10px 40px;">
					<table>
						<tr>
							<td height="40px" class="right_subtitle"><img src="${imageHandler.g_right_subtitle_icon}"> 게시판 글 쓰기 [${dispatcher.data.renderedData['boardId']}]</td>
						</tr>
						<tr>
							<td class="right_table">
				
								<!-- variable -->
								
								
								<div class="wrapper">
								<c:choose>
									<c:when test="${dispatcher.function.width > 0}">
									<div id="container" style="width:${dispatcher.function.width}px;margin:0 auto;"><style>.table{width:${dispatcher.function.width}px;}</style>
									</c:when>
									<c:otherwise>
									<div id="container">
									</c:otherwise>
								</c:choose>
								
								<div style="height:20px;">
									<!-- title -->
									
								</div>
								
								<%-- input field form --%>
								
								<c:choose>
									<c:when test="${boardId==null}"><c:set var="bid" value="${dispatcher.data.boardId}"/></c:when>
									<c:otherwise><c:set var="bid" value="${boardId}"/></c:otherwise>
								</c:choose>
								<form:form id="form" enctype="multipart/form-data" action="${contextPath}/edit.do?fid=${dispatcher.function.id}&action=${dispatcher.parameter.action}&bid=${bid}&id=${dispatcher.data.id}&xpath=${xpath}" method="post">
								
									<div class="property-form">
									<form:errors path="${id}" cssClass="property-error"/>
									<table class="property-list">
										<c:set var="render" value="${dispatcher.renders[head.name]}"/>
										<tr>
											<td class="property-title-td"><span class="property-title">제목</span><span class="${validationCss}"></span></td>
											<td class="property-value-td"><%-- <c:if test="${boardId==null}">${dispatcher.data.boardId}</c:if>aaa${boardId==null} --%>
												<span class="property-value">
													<form:input path="subject" cssClass="input-text" size="50" style="width:99%;height:25px;"/>
													<form:errors path="subject" cssClass="property-error"/>
												</span>
											</td>
										</tr>
										<c:if test="${ dispatcher.data.board.usePostingCategory == 'Y'}">
										<tr>
											<td class="property-title-td"><span class="property-title">구분</span><span class="${validationCss}"></span></td>
											<td class="property-value-td">
												<span class="property-value">
													<form:select path="categoryId" items="${requestScope['categoryId_items']}"/>
												</span>
											</td>
										</tr>
										</c:if>
										<tr>
											<td class="property-title-td"><span class="property-title">내용</span><span class="${validationCss}"></span></td>
											<td class="property-value-td">
												<span class="property-value">
													<form:textarea path="contents" cssClass="input-text" cssStyle="width:99%;height:100px;"/>
													<form:errors path="contents" cssClass="property-error"/>
												</span>
											</td>
										</tr>
									</table>
									</div>
									
									<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
										<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
									</c:forEach>
									
									<input type="hidden" name="file_infos" value=""/>
									<input type="hidden" name="contents_file_infos" value=""/>
									
									<div class="property-edit-buttons" style="text-align:center">
										<c:set var="button_text" value="등록"/>
										<c:set var="button_img" value="${imageHandler.g_board_bt_create}"/>
										<c:if test="${dispatcher.parameter.action == 'modify'}">
											<c:set var="button_text" value="수정"/>
											<c:set var="button_img" value="${imageHandler.g_board_bt_modify}"/>
										</c:if>
										
										<a href="javascript:submitFormWithFile();">
											<img src="${button_img}" alt="${button_text}">
										</a>
										<a href="javascript:history.back()"><img src="${imageHandler.g_board_bt_cancel}" alt="취소"></a>
									</div>
									
								</form:form>
								
								<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y'}">
									<%-- file upload form --%>
									<div class="container">
										<form id="fileupload" action="${contextPath}/upload" method="POST" enctype="multipart/form-data">
											<div class="row fileupload-buttonbar">
												<div class="span2">
													<span class="btn btn-small btn-info fileinput-button"> 
														<i class="icon-plus icon-white"></i> <span>파일 찾기...</span> <input type="file" name="files[]" multiple>
													</span>
													<button type="submit" class="btn btn-small btn-primary start hide">
														<span><img src="${imageHandler.g_board_bt_upload}" alt="업로드"></span>
													</button>
													<span class="fileupload-loading"></span>
												</div>
												<div class="span5 fileupload-progress fade">
													<div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
														<div class="bar" style="width: 0%;"></div>
													</div>
													<div class="progress-extended">&nbsp;</div>
												</div>
											</div>
											<div id="files">
											<table role="presentation" class="table table-striped">
												<tbody class="files"></tbody>
											</table>
											</div>
										</form>
									</div>
									<%-- end of container --%>
									<script id="template-upload" type="text/x-tmpl">
	{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <p class="name">{%=file.name%}</p>
            {% if (file.error) { %}
                <div><span class="label label-important">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td style="width:100px;text-align:right;">
            <p class="size">{%=o.formatFileSize(file.size)%}</p>
            {% if (!o.files.error) { %}
                <div class="progress progress-success progress-striped active hide" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            {% } %}
        </td>
        <td style="width:100px;text-align:right;">
            {% if (!o.files.error && !i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start hide">
                    <i class="icon-upload icon-white"></i>
                    <span>Start</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-small btn-warning cancel"> <i class="icon-ban-circle icon-white"></i> <span>취소</span> </button>
            {% } %}
        </td>
    </tr>
	{% } %}
	</script>
									<script id="template-download" type="text/x-tmpl">
	{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <p class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
            </p>
            {% if (file.error) { %}
                <div><span class="label label-important">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td style="width:100px;text-align:right;">
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td style="width:100px;text-align:right;">
            <button class="btn btn-danger btn-small delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                <i class="icon-trash icon-white"></i>
                <span>삭제</span>
            </button>
        </td>
    </tr>
	{% } %}
	</script>
									<c:if test="${dispatcher.parameter.action == 'modify' && dispatcher.data.files != null}">
									<script>
									$(function(){
										var that = $('#fileupload').data('blueimp-fileupload') || $('#fileupload').data('fileupload');
										<c:forEach items="${dispatcher.data.files}" var="file">
										template = that._renderDownload([${file.renderedData.json}]);
										that._transition( template);
										$('.files').append( template);
										</c:forEach>
									});
									</script>
									</c:if>
								</c:if><%-- useAttachmentFile --%>
								
								</div><%-- container --%>
								</div><%-- wrapper --%>
							</td>
						</tr>
					</table>		
				</div>				
				
			</div>
			</td>
		</tr>
	</table>


</td></tr></table>