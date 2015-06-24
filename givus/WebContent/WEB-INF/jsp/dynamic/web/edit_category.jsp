<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- variable --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="func" value="${dispatcher.function}"/>

<link type="text/css" href="${contextPath}/style/property.css" rel="stylesheet"/>

<script src="${contextPath}/plugin/jquery_fileupload/js/vendor/jquery.ui.widget.js"></script>
<script src="${contextPath}/plugin/jstree-v.pre1.0/_lib/jquery.cookie.js"></script>
<script src="${contextPath}/plugin/jstree-v.pre1.0/_lib/jquery.hotkeys.js"></script>
<script src="${contextPath}/plugin/jstree-v.pre1.0/jquery.jstree.js"></script>

<%-- CKEDITOR --%>
<script src="${contextPath}/plugin/ckeditor/ckeditor.js"></script>

<style>
.table{margin-bottom:10px;}
.fileupload-buttonbar{height:30px;}
<%-- ////////////// BOOTSTRAP MODIFY ////////////// --%>
body {
  font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
  padding-top:0px;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
	margin-bottom:3px;
	font-size:9pt;
	font-family: "Malgun Gothic", "Helvetica Neue", Helvetica, Arial, sans-serif;
	padding-top:1px;
	padding-bottom:1px;
	min-height:23px;
	height:21px;
}
table tr{
	height:30px;
}

.node-changed{
	color:red;
	font-weight:bold;
	font-style:italic;
}
</style>
<script>
//$(function(){
	var ckeditor_config = {
		resize_enabled : true, // 에디터 리사이즈 여부
		autoUpdateElement : true, // 자동 textarea 업데이트 여부 (안됨)
		enterMode : CKEDITOR.ENTER_BR , // 에디터 엔터를 <br> 태그를 사용함.
		shiftEnterMode : CKEDITOR.ENTER_P , // 에디터 시프트 + 엔터를 <p> 태그를 사용함
		toolbarCanCollapse : true , // 에디터 툴바 숨기기 기능 여부
		skin:'moonocolor',
		pasteFromWordRemoveFontStyles : false,
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
	
	// CKEDITOR.replace('contents', ckeditor_config);
//});
var selectedNode;
<c:choose>
	<c:when test="${param.action == 'modify'}">
var initialData = [ ${dispatcher.data.jsonString} ];
	</c:when>
	<c:otherwise>
var initialData = [{
    "data": "루트 카테고리",
    "attr" : { id : 'rootNode', rel : 'root'}
}];
	</c:otherwise>
</c:choose>
$(function(){
	$('#jstree').jstree({
		"plugins" : ["themes", "ui", "crrm", "dnd", "hotkeys", "types", "json_data"], //, "contextmenu"],
		"json_data" : {
			"data" : initialData
		},
		"types" : {
			"types" : {
				"default" : {
					"max_children" : -1,
					"max_depth" : -1,
					"valid_children" : "all"
				},
				"root" : {
					"valid_children" : ["default"],
					"start_drag" : false,
					"move_node" : false,
					"delete_node" : false,
					"remove" : false,
					"rename" : false
				}
			}
		},
		<c:choose>
			<c:when test="${param.action == 'modify'}"><%-- 수정시에는 루트 카테고리의 아이디를 설정한다. --%>
		"core" : { "initially_open" : ['${dispatcher.data.id}']},
		"ui" : { "initially_select" : ['${dispatcher.data.id}']},
			</c:when>
			<c:otherwise><%-- 생성시에는 루트 카테고리의 아이디가 rootNode로 설정되어 있다. --%>
		"core" : { "initially_open" : ['rootNode']},
		"ui" : { "initially_select" : ['rootNode']},
			</c:otherwise>
		</c:choose>
		"contextmenu" : { items : contextMenu}
	})
	.bind("move_node.jstree", function (e, data) {
		data.rslt.o.each( function (i) {
			var id = $(this).attr("id");
			if( id && id != 'rootNode'){
				if( confirm('카테고리를 이동하시겠습니까?')){
					var parentId = data.rslt.cr === -1 ? 1 : data.rslt.np.attr("id");
					// var title = data.rslt.name;
					var position = data.rslt.cp + i;
					// alert( "id : " + id + ", parentId : " + parentId + ", title : " + title + ", position : " + position);
					$.ajax({
						type : 'POST',
						url : '/givus/___/category/move/' + id + '/' + parentId + '/' + position,
						success : function( result){
							alert( result.message);
							$(data.rslt.obj).attr("id", result.id);
						}
					});
				}else{
					$.jstree.rollback(data.rlbk);
				}
			}
		});
	})
	.bind("create.jstree", function (e, data) {
		var parentId = data.rslt.parent.attr("id");
		if( parentId && parentId != 'rootNode'){
			if( confirm('카테고리를 생성하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '/givus/___/category/create/' + parentId,
					data : 'name=' + data.rslt.name,
					success : function( result){
						alert( result.message);
						$(data.rslt.obj).attr("id", result.id);
					}
				});
			}else{
				$.jstree.rollback(data.rlbk);
			}
		}
	})
	.bind("remove.jstree", function (e, data) {
		var id = data.rslt.obj.attr("id");
		if( id && id != 'rootNode'){
			if( confirm('카테고리를 삭제하시겠습니까?')){
				$.ajax({
					type : 'POST',
					url : '/givus/___/category/remove/' + id,
					success : function( result){
						alert( result.message);
					}
				});
			}else{
				$.jstree.rollback(data.rlbk);
			}
		}
	})
	.bind("rename.jstree", function (e, data) {
		var id = data.rslt.obj.attr("id");
		if( id && id != 'rootNode'){
			var name = data.rslt.new_name;
			if( confirm('이름을 [' + name + "] 으로 변경하시겠습니까?")){
				$.ajax({
					type : 'POST',
					url : '/givus/___/category/rename/' + id,
					data : 'name=' + name,
					success : function( result){
						alert( result.message);
					}
				});
			}else{
				$.jstree.rollback(data.rlbk);
			}
		}
	})
	.bind("select_node.jstree", function (e, data) {
		selectedNode = dynamic.jstree.getSelectedNode();
		
		if( 'board' == selectedNode.data('relatedType')){
			$.getJSON( '/givus/___/board/getwithpc/'+selectedNode.data('relatedId'), function( json){
				var items = [];
				$(json.postingCategory).each( function(){
					items.push('<option value="' + this.id + '">' + this.name + '</option>');
				});
				$('#suggest_relatedId').val( json.name);
				$('#relatedId').val( json.id);
				if( items.length > 0){
					$('#postingCategory').html( items.join()).prop('disabled', false).find('option[value='+selectedNode.data('relatedSubId')+']').prop('selected', true);
				}else{
					$('#postingCategory').html( '').prop('disabled',true);
				}
				console.log( JSON.stringify( json));
			});
			
			$('#relationTab a[href="#board"]').tab('show');
		}else{
			dynamic.category.clearBoardRelationTab();
		}
    })
	.bind('loaded.jstree', function() {
		$('#jstree').jstree('open_all');
	});
	
	$('#category_buttons span').click( function(){
		$('#jstree').jstree( this.id);
	});
	
	$('.property-edit-buttons .submit').click( function(){
		var json = jQuery.jstree._reference("#rootNode").get_json(-1);
		
		$.ajax({
			type : 'POST',
			url : '/givus/___/category/compose',
			data : 'categoryInfo=' + JSON.stringify(json),
			success : function( args){
				
			}
		});
	});
	
	$('.property-edit-buttons .saveAll').click( function(){
		var myTreeContainer = $.jstree._reference('#${param.id}').get_container();
		var allChildren=myTreeContainer.find("li");
		var nodes = [];
		allChildren.each( function( data){
			var target = $(this).find('a:first');
			if( target.hasClass('node-changed')){
				var node = {};
				node.id = $(this).attr('id');
				node.relatedId = $(this).data('relatedId');
				node.relatedSubId = $(this).data('relatedSubId');
				node.relatedType = $(this).data('relatedType');
				nodes.push( node);
			}
		});
		
		console.log( $.toJSON(nodes));
		
		if( nodes.length > 0){
			$.ajax({
				type : 'POST',
				url : '/givus/___/category/save',
				data : 'infos=' + $.toJSON( nodes),
				success : function( json){
					alert( json.message);
					if( json.result == 'true'){
						dynamic.jstree.displayAllNodeNormal();
					}else{
						
					}
				}
			});
		}
	});
});
    
function contextMenu(node) {
    // The default set of all items
    var items = {
        renameItem: { // The "rename" menu item
            label: "이름 변경하기",
            action: function () {
            }
        },
        deleteItem: { // The "delete" menu item
            label: "카테고리 제거하기",
            action: function () {
            }
        }
    };

    if ($(node).attr("rel") == 'root') {
    	return null;
    }

    return items;
}

$(function(){
	$('#board_buttons .go').bind('click', function(){
		console.log( selectedNode.data('relatedId'));
		if( selectedNode.data('relatedId')){
			var url = '/givus/list.do?fid=PA&bid=' + selectedNode.data('relatedId');
			dynamic.util.openPopup( url, 'board', '1100', '650');	
		}
	});
	
	$('#board_buttons .clear').bind('click', function(){
		console.log( selectedNode.data('relatedId'));
		if( selectedNode.data('relatedId')){
			dynamic.category.clearBoardRelationTab( selectedNode);
			dynamic.jstree.displayNodeChanged();
		}
	});
	
	$('#postingCategory').bind('change', function(){
		selectedNode.data('relatedSubId', $('#postingCategory option:selected').val());
		dynamic.jstree.displayNodeChanged();
		// console.log( selectedNode.children("a").text());
	});
	
	$('#relationTab a').click(function (e) {
		e.preventDefault();
		$(this).tab('show');
	})
});

dynamic.jstree = {
	getSelectedNode : function(){
		return $.jstree._focused().get_selected();
	},
	displayNodeChanged : function( node){
		if( !node){
			node = dynamic.jstree.getSelectedNode();
		}
		node.find('a:first').addClass('node-changed');
	},
	displayNodeNormal : function( node){
		if( !node){
			node = dynamic.jstree.getSelectedNode();
		}
		node.find('a:first').removeClass('node-changed');
	},
	displayAllNodeNormal : function(){
		var myTreeContainer = $.jstree._reference('#${param.id}').get_container();
		myTreeContainer.find("a").removeClass('node-changed');
	}
};

dynamic.category = {
	clearBoardRelationTab : function( node){
		if( node){
			selectedNode.data('relatedId', '').data('relatedSubId', '').data('relatedType', '');
		}
		$('#suggest_relatedId').val('');
		$('#relatedId').val('');
		$('#postingCategory').html('').prop('disabled', true);
	}
};
</script>

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

<div style="height:20px;">
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

<%-- input field form --%>
<form:form id="form" enctype="multipart/form-data">
	<div class="property-form">
	<form:errors path="${id}" cssClass="property-error"/>
	<table class="property-list">
		<tr>
			<td valign="top" style="padding:5px;"><%-- CATEGORY TREE --%>
				<div id="category_buttons" >
					<span id="create" class="btn btn-mini">카테고리 생성하기</span>
					<span id="remove" class="btn btn-mini">카테고리 제거하기</span>
					<span id="rename" class="btn btn-mini">이름 변경하기</span>
				</div>
				<div id="jstree" style="margin-top:5px;">
				</div>
			</td>
			<td valign="top" style="padding:5px;"><%-- CATEGORY INFO --%>
				<ul class="nav nav-tabs" id="relationTab">
				  <li class="active"><a href="#board">게시판 연결</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="board">
						<table>
							<tr>
								<td width="100">게시판명</td>
								<td><input id="suggest_relatedId" name="suggest_${head.name}" type="text" size="50" class="input-text" value=""></td>
							</tr>
							<tr>
								<td>글 구분</td>
								<td><select id="postingCategory"></select><input type="hidden" id="relatedId" name="relatedId"/></td>
							</tr>
						</table>
						<div id="board_buttons" style="margin-top:5px;">
							<span class="btn btn-mini go">게시판 가기</span>
							<span class="btn btn-mini clear">설정해제</span>
						</div>
						<script>
							$(function(){
								$('#suggest_relatedId').autocomplete({
									serviceUrl : '${contextPath}/ajax.do', minChars: 2,
									params:{ fid:'${func.id}', field:'relatedId'},
									onSelect: function( value, data){ 
										$('#relatedId').val( data).change();
										dynamic.jstree.displayNodeChanged();
										selectedNode.data('relatedType', 'board').data('relatedId', data);
										$.getJSON( '/givus/___/board/pc/' + data, function( json){<%-- GET PostingCategory --%>
											var items = [];
											$(json).each( function(){
												items.push('<option value="' + this.id + '">' + this.name + '</option>');
											});
											
											if( items.length > 0){
												$('#postingCategory').html( items.join()).prop('disabled', false).change();
											}else{
												selectedNode.data('relatedSubId', '');
												$('#postingCategory').html( items.join()).prop('disabled', true);
											}
											console.log( selectedNode.data('relatedType') + ':' + selectedNode.data('relatedId') + ',' + selectedNode.data('relatedSubId'));
										});
									}
								});
							});
						</script>
					</div>
				</div>
			</td>
		</tr>
	</table>
	</div>
	
	<c:forEach var="hidden" items="${dispatcher.hiddenFields}">
		<input type="hidden" name="${hidden.name}" value="${hidden.value}"/>
	</c:forEach>
	
	<input type="hidden" name="fileInfos" value=""/>
	
	<div class="property-edit-buttons" style="text-align:center">
		<c:choose>
			<c:when test="${param.action == 'modify'}">
				<span class="saveAll btn btn-small"><i class="icon-ok"></i> 변경사항 저장</span>
			</c:when>
			<c:otherwise>
				<span class="submit btn btn-small"><i class="icon-ok"></i> 등록</span>
			</c:otherwise>
		</c:choose>
	</div>
</form:form>