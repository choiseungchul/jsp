<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

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

<script src="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.min.js"></script>
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.carousel.css">
<link rel="stylesheet" href="${contextPath}/script/jqueryui/plugin/owl-carousel/owl.theme.css">

<style>
.table{	margin-bottom:10px;}
.progress{margin-bottom:3px;}
.fileupload-buttonbar{margin-bottom:10px;}

body {
  font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
  padding-top:0px;
}

.carousel-wrapper{
	text-align:center;
	margin-bottom:20px;
}
.carousel{
}
#carousel .item img{
	display:block;
}
</style>
<script>
var upload_info = {
	failCount : 0,
	uploadedFiles : new Array(),
	init : function(){
		this.failCount = 0;
	},
	getNumberOfFiles: function () {
		return $('#files').find('tr.template-upload') ? $('#files').find('tr.template-upload').length : 0;
	},
	maxFileSize: 1048576, // 1 MB
	maxFileCount : 10, // 10 file count
	acceptFileTypes : 'jpg,png,gif',
	getFormData : function(){
		return $('#fileupload').serializeArray();
	},
	setUploadInfo : function(){
		var info = ' ( 첨부파일 용량 : ' + upload_info.formatFileSize( upload_info.maxFileSize) + ' 이내';
		if( upload_info.acceptFileTypes && upload_info.acceptFileTypes.length > 0){
			info += ', 파일타입 : ' + upload_info.acceptFileTypes;
		}
		info += ' )';
		
		$('#upload_info').html( info);
	},
	formatFileSize : function (bytes) {
	    if (typeof bytes !== 'number') {
	        return '';
	    }
	    if (bytes >= 1000000000) {
	        return (bytes / 1073741824).toFixed(0) + ' GB';
	    }
	    if (bytes >= 1000000) {
	        return (bytes / 1048576).toFixed(0) + ' MB';
	    }
	    return (bytes / 1024).toFixed(0) + ' KB';
	}
};

function submitFormWithFile(){
	if( upload_info.getNumberOfFiles() > 0){
		$("button.start").click();
	}
}

$(function(){
	upload_info.setUploadInfo();

	$("#carousel").owlCarousel({
		// navigation : true, // Show next and prev buttons
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		autoScaleUp:false
		
		// "singleItem:true" is a shortcut for:
		// items : 1, 
		// itemsDesktop : false,
		// itemsDesktopSmall : false,
		// itemsTablet: false,
		// itemsMobile : false
		
	});
});
</script>

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

<div style="height:20px;margin-bottom:20px;">
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

<c:if test="${files != null}">
<div class="carousel-wrapper">
<table width="${dispatcher.function.cellWidth}" style="margin:auto;"><tr><td>
<div id="carousel" class="owl-carousel owl-theme">
	<c:forEach var="file" items="${files}">
	<div class="item"><img src="/___/file/get/${file.id}" alt=""></div>
	</c:forEach>
</div>
</td></tr></table>
</div>
</c:if>

<%-- input field form --%>
<form:form id="fileupload" action="${contextPath}/upload" method="POST" enctype="multipart/form-data">
	<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
		<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
	</c:forEach>
	<div class="container">
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
			<div class="span5">
				<span id="upload_info"></span>
			</div>
		</div>
		<div class="row">
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
	</div>
	<div class="property-edit-buttons" style="text-align:center">
		<c:set var="button_text" value="등록"/>
		<c:if test="${dispatcher.parameter.action == 'modify'}">
			<c:set var="button_text" value="수정"/>
		</c:if>
		<%-- <a href="javascript:dynamic.util.submitForm('form')"> --%>
		<a href="javascript:submitFormWithFile();">
			<span class="btn btn-small"><i class="icon-ok"></i> ${button_text}</span>
		</a>
	</div>
</form:form>
</div><%-- container --%>
</div><%-- wrapper --%>

<%-- end of container --%>
<script id="template-upload" type="text/x-tmpl">
	{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
		<td>
            <span class="preview"></span>
        </td>
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
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
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
<c:if test="${files != null}">
<script>
$(function(){
	var that = $('#fileupload').data('blueimp-fileupload') || $('#fileupload').data('fileupload');
	<c:forEach items="${files}" var="file">
	template = that._renderDownload([${file.renderedData.json}]);
	that._transition( template);
	$('.files').append( template);
	</c:forEach>
});
</script>
</c:if>