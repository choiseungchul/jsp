<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
.popup-edit-outline{
	background: url("${imageHandler.g_right_body_bg_700}");
	width: 608px;
	height:630px;
	border-bottom: 1px solid #d4d4d4; 
}
.property-view, .property-edit {
	width: 90%;
}
.property-title-td{
	color: #444444;
	text-shadow: 1px 1px 1px #a8a8a8;
	font-size: 12px;
	font-weight: strong;
	width: 80px;
	vertical-align: middle;
	text-align: center;
	letter-spacing: 1px;
}
.property-value-td{
	vertical-align: middle;
	padding: 10px;
}
.givus-input-text{
	font-size: 12px;
	height: 15px;
	background-color: white;
	color: #444444;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #cfcfcf;
}

.givus-select {
	font-size: 12px;
	font: 나눔고딕;
	height:20px;
	background-color: white;
	color: #444444;
	border: 1px solid #cfcfcf;
}
.givus-input-textarea{
	font: 나눔고딕;
	font-size: 12px;
	background-color: white;
	color: #444444;
	padding-left: 2px;
	padding-top: 2px;
	border: 1px solid #cfcfcf;
	overflow-x: scroll;
	overflow-y: scroll;
	overflow: -moz-scrollbars-horizontal;
}

</style>

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
		dynamic.util.submitForm('form_epilogue');
	}
}

function ckeditorUploadComplete( CKEditorFuncNum, url, fileId){
	var contentsFileInfos = $(':hidden[name=contents_file_infos]');
	contentsFileInfos.val( contentsFileInfos.val() + fileId + ",");
	CKEDITOR.tools.callFunction( CKEditorFuncNum, url);
}


$( function(){
	$('#close_epilogue_write').click( function(){
		$.unblockUI();
	}).css('cursor', 'pointer');
});
</script>

<%-- //////////////// EDIT POSTING //////////////// --%>
				
<div class="popup-edit-outline">

	<%-- <img src="${imageHandler.g_popup_icon_close}" align="right" alt="close this popup" id="close_epilogue_write"> --%>


			<div class="board_right">
				
				<%-- //////////////// WRITE POSTING //////////////// --%>
				<div style="width:510px;float:left;text-align:center;margin:10px 10px 10px 40px;">
					<table>
						
						<tr>
							<td class="right_table">
				
								<!-- variable -->
								<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
								<c:set var="func" value="${dispatcher.function}"/>
								
								<div class="wrapper">
								<c:choose>
									<c:when test="${dispatcher.function.width > 0}">
									<div id="container" style="width:${dispatcher.function.width}px;margin:0 auto;"><style>.table{width:${dispatcher.function.width}px;}</style>
									</c:when>
									<c:otherwise>
									<div id="container">
									</c:otherwise>
								</c:choose>
								
								
								
								<%-- input field form --%>
								
								<form:form id="form_epilogue" enctype="multipart/form-data" action="${contextPath}/gedit.do?fid=${dispatcher.function.id}&action=create&bid=${dispatcher.data.boardId}&hid=${dispatcher.data.customField1}" method="post">
								
									<div class="property-form">
									<form:errors path="${id}" cssClass="property-error"/>
									<table class="property-list" style="width:510px;">
										<c:set var="render" value="${dispatcher.renders[head.name]}"/>
										<tr>
											<td class="property-title-td"><span class="property-title">제목</span><span class="${validationCss}"></span></td>
											<td class="property-value-td" align="left">
												<c:if test="${ dispatcher.data.board.usePostingCategory == 'Y'}">
													<span class="property-value">
														<form:select path="categoryId" items="${requestScope['categoryId_items']}" cssClass="givus-select" />
													</span>
												</c:if>
											</td>
											<td class="property-value-td" align="left">
												<span class="property-value">
													<form:input path="subject" cssClass="givus-input-text" size="50" style="height:20px;"/>
													<form:errors path="subject" cssClass="property-error"/>
												</span>
											</td>
										</tr>
										<tr><td colspan="3" style="padding-bottom: 10px;"><img src="${imageHandler.g_hospital_line_horizontal_510}"></td></tr>
										
										<tr style="padding-bottom: 10px;">
											
											<td class="property-value-td" colspan="3" style="background-color: #e5e8f0;text-align: center;border: 1px solid #cfcfcf;">
												<span class="property-value">
													<form:textarea path="contents" cssClass="givus-input-textarea" cssStyle="width:98%;height:200px;"/>
													<form:errors path="contents" cssClass="property-error"/>
												</span>
												<span class="${validationCss}"></span>
											</td>
										</tr>
									</table>
									</div>
									
									<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
										<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
									</c:forEach>
									<input type="hidden" name="customField1" value="${dispatcher.data.customField1}"/>
									
									<input type="hidden" name="file_infos" value=""/>
									<input type="hidden" name="contents_file_infos" value=""/>
									
									<div class="property-edit-button" style="text-align:center;height:40px;margin-top: 10px;margin-bottom: 10px;">
										
										<c:set var="button_text" value="${imageHandler.g_hospital_bt_epilogue_ok}"/>
										<c:if test="${dispatcher.parameter.action == 'modify'}">
											<c:set var="button_text" value="수정"/>
										</c:if>
										
										<a href="javascript:submitFormWithFile();">
											<img src="${button_text}">
										</a>
									</div>
								</form:form>
								
								<c:if test="${ dispatcher.data.board.useAttachmentFile == 'Y'}">
									<%-- file upload form --%>
									<div class="container">
										<form id="fileupload" action="${contextPath}/upload" method="POST" enctype="multipart/form-data">
											<div class="row fileupload-buttonbar">
												<div class="span2">
													<span class="btn btn-small btn-info fileinput-button"> 
														<i class="icon-plus icon-white"></i> <span>파일 추가...</span> <input type="file" name="files[]" multiple>
													</span>
													<button type="submit" class="btn btn-small btn-primary start hide">
														<i class="icon-upload icon-white"></i> <span>업로드</span>
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



</div>