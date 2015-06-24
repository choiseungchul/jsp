<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"  %>
<%-- #################### BoardPostingCategory 등록 / 수정 #################### --%>
<table id="postingCategoryDiv" style="padding-left:200px;" class="hide">
	<tr><td>
		<input type="text" id="posting_category_input">
		<span id="posting_category_add" class='btn btn-mini'>추가</span>
		<div id="category_list" style="white-space:normal;"></div>
	</td></tr>
</table>
<script>
	$('#usePostingCategory1').closest('td').append( $('#postingCategoryDiv'));	
	
	$('#usePostingCategory1').click(function(){
		$('#postingCategoryDiv').show();	
	});
	
	$('#usePostingCategory2').click(function(){
		$('#postingCategoryDiv').hide();	
	});
	
	$('#postingCategory').closest('td').append( $('#posting_category_add')).append( $('#category_list'));
	$('#posting_category_add').click(function(){
		var category = $('#posting_category_input').val();
		$('#posting_category_input').val('');<%-- clear input --%>
		if( category){
			dynamic.board.addPostingCategory( category);
		}
	});
	
	dynamic.board = {
		setPostingCategory : function(){
			var items = [];
			$('.category-item').each( function(){
				if( $(this).data('id')){
					
				}else{
					items.push( $(this).text());
				}
				
			});
			
			$(':hidden[name=postingCategory]').val( items.join(','));
		},
		addPostingCategory : function( name, id){
			var category = $("<span class='btn btn-mini btn-primary disabled category-item' style='cursor:pointer;margin:3px;' title='${msgHandler['common.msg.clear']}'>" + name + " <i class='icon-white icon-remove-sign'></i></span>");
			if( id){
				category.data('id', id);
			}
			$('#category_list').append( category);
			category.click(function(){
				if( category.data('id')){
					if( confirm('${msgHandler['confirm.msg.posting_category.delete']}')){
						dynamic.board.deletePostingCategory( category.data('id'));
					}
				}else{
					$(this).remove();
					dynamic.board.setPostingCategory();
				}
			});
			
			dynamic.board.setPostingCategory();
		},
		deletePostingCategory : function( id){
			var url = dynamic.constants.CONTEXTPATH + "/___/posting_category/delete/" + id;
			$.get( url, function( data){
				if( data.result == 'true'){
					$('.category-item').each( function(){
						if( $(this).data('id') == id)
							$(this).remove();
					});
					dynamic.board.setPostingCategory();
				}else{
					alert( data.errormessage);
				}
			});			
		}
	};
	
	{
	<c:forEach var="model" items="${dispatcher.data.postingCategoryModels}">
		dynamic.board.addPostingCategory( '${model.name}', '${model.id}');
	</c:forEach>
	<c:if test="${dispatcher.data.usePostingCategory == 'Y'}">
		$('#usePostingCategory1').click();
	</c:if>
	}
</script>
