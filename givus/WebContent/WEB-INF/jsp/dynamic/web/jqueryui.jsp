<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ///////////////////// JQUERY  ///////////////////// --%>
<%-- <script type="text/javascript" src="${contextPath}/script/jqueryui/js/jquery-1.3.2.min.js"></script>  --%>
<%-- <script type="text/javascript" src="${contextPath}/script/jqueryui/js/jquery-1.6.4.min.js"></script> --%>
<%-- <script type="text/javascript" src="${contextPath}/script/jqueryui/js/jquery-1.7.2.min.js"></script> --%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<%--<script type="text/javascript" src="${contextPath}/script/jqueryui/js/jquery-1.10.2.min.js"></script> --%>
<%-- ///////////////////// JQUERY UI ///////////////////// --%>
<%-- <link type="text/css" href="${contextPath}/script/jqueryui/css/ui.all.css" rel="stylesheet"/>  --%>
<%-- <link type="text/css" href="${contextPath}/script/jqueryui/css/redmond/jquery-ui-1.7.2.custom.css" rel="stylesheet"/>  --%>
<%-- <script type="text/javascript" src="${contextPath}/script/jqueryui/js/jquery-ui-1.7.2.custom.min.js"></script> --%>
<link type="text/css" href="${contextPath}/script/jquery-ui-1.10.3/css/redmond/jquery-ui-1.10.3.custom.css" rel="stylesheet"/> 
<script type="text/javascript" src="${contextPath}/script/jquery-ui-1.10.3/js/jquery-ui-1.10.3.custom.min.js"></script>
<script type="text/javascript" src="${contextPath}/script/jqueryui/i18n/ui.datepicker-ko.js"></script>
<%-- ///////////////////// JQUERY PLUGINS ///////////////////// --%>
<%-- autocomplete --%> 
<link href="${contextPath}/script/jqueryui/plugin/autocomplete/autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/autocomplete/jquery.autocomplete-min.js"></script>
<%-- contextmenu --%>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/contextmenu/jquery.contextMenu.js"></script>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/contextmenu/jquery.ui.position.js"></script>
<link href="${contextPath}/script/jqueryui/plugin/contextmenu/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<%-- jquery plug in --%>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/dateFormat/jquery.dateFormat-1.0.js"></script>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/base64/jquery.base64.js"></script>
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/jquery.json-2.4.min.js"></script>
<%-- ///////////////////// NOT USE /////////////////////
// fullsize
<link href="${contextPath}/script/jqueryui/plugin/fullsize/fullsize.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/fullsize/jquery.fullsize.minified.js"></script>
// tipTip
<link href="${contextPath}/script/jqueryui/plugin/tipTipv13/tipTip.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/tipTipv13/jquery.tipTip.js"></script>
// lightbox
<link href="${contextPath}/plugin/lightbox/css/basic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextPath}/plugin/lightbox/js/jquery.simplemodal.js"></script>
<script type="text/javascript" src="${contextPath}/plugin/lightbox/js/basic.js"></script>
// colorbox
<script type="text/javascript" src="${contextPath}/script/jqueryui/plugin/colorbox/jquery.colorbox-min.js"></script>
<link href="${contextPath}/script/jqueryui/plugin/colorbox/colorbox.css" rel="stylesheet" type="text/css" />
--%>  
<script type="text/javascript">
	$(document).ready(function(){
		// default settting
		$.datepicker.setDefaults({
			showOn: 'button', 
			buttonImage: '${imageHandler.calendar}', 
			buttonText: '달력',
			buttonImageOnly : true
			<%-- changeMonth: true, changeYear: true, --%>
		});
		//$(".tipTip").tipTip({maxWidth: "auto", edgeOffset:10}).css('cursor','pointer');
		//$("img.thumb").fullsize();
		//$("a.thumb").colorbox();
		$.base64.is_unicode = true;
	});
</script>

