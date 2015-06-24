var dynamic = {};

dynamic.init = {
	init : function(){
		dynamic.init.blockEnterSubmit();
		dynamic.init.bindChkAll();
		dynamic.sjax.init();
		
		String.prototype.startsWith = function(str) 
		{return (this.match("^"+str)==str)}
	},
	
	blockEnterSubmit : function(){
		$("form input").keyup(function (e) {
			if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
				$('button[type=submit] .default').click();
				return false;
			} else {
				return true;
			}
		});
	},
	
	bindChkAll : function(){
		$(':checkbox[id$=chkall]').bind('click', function(){
			var funcId = this.id.split('_')[0];
			var checked = this.checked;
			$(':checkbox[id^=' + funcId + '_chk_]').each( function(){
				this.checked = checked;
			});
		});
		
		$('[id^=suggest_]').bind('click', function(){this.select();});
	}
};

// dynamic.action
dynamic.action = {
	/**
	 *	fid : checkbox 를 검색할 function id
	 *	successUrl : 삭제후 이동할 페이지 url
	 */
	del : function( param){
		var ids = dynamic.util.searchCheckedIds( param.fid);
		if( ids.length > 0 && confirm('continue delete these items ?'))
		{
			dynamic.util.move( dynamic.constants.CONTEXTPATH + '/delete.nc?fid='+param.fid+'&ids='+ids+'&xpath='+encodeURIComponent(param.successUrl));
		}
	},
	print : function( param){
		var ids = dynamic.util.searchCheckedIds( param.chkfid);
		if( ids.length > 0)
		{
			var url = dynamic.constants.CONTEXTPATH + '/print.do?action=preview&fid='+param.fid+'&ids='+ids;
			dynamic.util.openPopup( url, 'processOrderPrint', '1024', '650');
		}
	},
	printView : function( param){
		var url = dynamic.constants.CONTEXTPATH + param.url
		dynamic.util.openPopup( url, 'processOrderPrint', '1024', '600');
	},
	printViewV : function( param){
		var url = dynamic.constants.CONTEXTPATH + param.url
		dynamic.util.openPopup( url, 'processOrderPrint', '720', '900');
	},
	logout : function(){
		if( confirm('continue logout?'))
		{
			parent.location.href = dynamic.constants.CONTEXTPATH + '/logout.nc';
		}
	},
	
	up : function( param, func){
		var chkId = dynamic.util.searchCheckedIds( param.fid);
		if( chkId == '' || chkId.indexOf(',') > -1) return;
		var curTr = $('tr:has(:checkbox[value='+chkId+'])');
		var preTr = curTr.prev();
		if( preTr.prev().size() > 0) // if preTr is table header
		{
			var preChk = preTr.find(':checkbox');
//			console.log( 'preChk value is ' + preChk.val());
			var curChk = curTr.find(':checkbox');
//			console.log( 'curChk value is ' + curChk.val());
			curTr.insertBefore( curTr.prev());
			
			func( preChk.val(), curChk.val());
		}
	},
	
	down : function( param, func){
		var chkId = dynamic.util.searchCheckedIds( param.fid);
		if( chkId == '' || chkId.indexOf(',') > -1) return;
		var curTr = $('tr:has(:checkbox[value='+chkId+'])');
		if( curTr.next().size() > 0)
		{
			var nextChk = curTr.next().find(':checkbox');
//			console.log( 'preChk value is ' + preChk.val());
			var curChk = curTr.find(':checkbox');
//			console.log( 'curChk value is ' + curChk.val());
			curTr.insertAfter( curTr.next());
			
			func( nextChk.val(), curChk.val());
		}
	},
	
	loadTableData : function( funcId, url){
		var _url = url + '&rtype=data';
		$( '#' + funcId + '_table').load( _url);
	}
};

dynamic.util = {
	searchCheckedIds : function( funcId){
		var ids = new Array();
		$(':checkbox[id^=' + funcId + '_chk_]:checked').each( function(){
			ids.push( this.value);
		});
		
		return ids.join(',');
	},
	submitForm : function(id){
		$('span.button-submit').removeAttr('onclick').css('color', 'gray').append(' 처리중입니다...');
		$("#"+id).submit();
	},
	filterKeyControl : function(id, e){
		var keyCode = e.which ? e.which : e.keyCode;
		if( e.altKey){ // alt+1..9
			if( keyCode >= 49 && keyCode < 59){
				var idx = keyCode - 49; 
				var sel = $('#'+id).find('select');
				sel.find('option:nth('+idx+')').attr('selected','true');
			}
		}else if( e.ctrlKey){
			if( keyCode == 41 || keyCode == 122){
				var obj = $('#'+id).find('#search_cancel');
				obj.click( function(){
					$(this).next().trigger('click');
				});
			}
		}else if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
			dynamic.util.submitForm(id);
		}
	},
	move : function( url, params){
		if( !url.startsWith( dynamic.constants.CONTEXTPATH)){
			url = dynamic.constants.CONTEXTPATH + url;
		}
		if( params){
			var paramStr = '?';
			$.each( params, function(key, value){
				paramStr += key + '=' + value + '&';
			});
			url += paramStr;
		}
		location.href = url;
	},
	enterClick : function( url, e){
		if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
			dynamic.util.move(url);
		}
	},
	getTreeInfo : function( checkboxValue){
		return  $('#' + checkboxValue + '_name_value span:first-child').attr('id');
	},
	findThreads : function( parentTreeInfo){
		return $( 'tr:has(span[id^=' + parentTreeInfo + '|])');
	},
	findNextThreads : function( currentTreeInfo){
		var currentThreads = dynamic.util.findThreads( currentTreeInfo);
		
	},
	openPopup : function (popupUrl, popupName, w, h, opt) {
		if( !popupUrl.startsWith( dynamic.constants.CONTEXTPATH)){
			popupUrl = dynamic.constants.CONTEXTPATH + popupUrl;
		}
        var leftPosition = (screen.width) ? (screen.width-w)/2 : 0;
        var topPosition = (screen.height) ? (screen.height-h)/2 : 0;
        var option = 'height='+h+',width='+w+',top='+topPosition+',left='+leftPosition+',scrollbars=auto';
        if( opt)
        	option += "," + opt;
        window.open( popupUrl, popupName, option);
	},
	/**
	 * tr : $(tr) jquery 객체
	 * vars : value 를 구하기 위한 array
	 */
	getTRInfo : function( tr, vars){
		var result = {};
		for( var prop in vars){
			//console.log( vars[prop]);
			result[vars[prop]] = jQuery.trim( tr.find( '[id*=' + vars[prop] + ']').html());
		}
		return result;
	},
	delFile : function( id){
		$('span#' + id).hide();
		$('input#file_' + id + '_delete').val("Y");
	},
	digitToHangul : function( input){
	    var index=0;
	    var i=0;
	    var result="";
	    var newResult="";
//	    var money = commaDel(input);
	    var money = input;
	    su = new Array("0","1","2","3","4","5","6","7","8","9");
	    km = new Array("영","일","이","삼","사","오","육","칠","팔","구");
	    danwi = new Array("","십","백","천","만","십","백","천","억","십","백","천","조");
	    for(j=1;j<=money.length;j++){
	        for(index=0;index<10;index++){
	            money = money.replace(su[index],km[index]);
	        }
	    }
	    
	    for(index = money.length;index>0;index=index-1){
	        result = money.substring(index-1,index);
	        if(result=="영"){
	            if(i<4 || i>8){
	                result = "";
	                
	            }else if(i>=4 && i<8 && newResult.indexOf("만")<0){
	                result = "만";
	                
	            }else if(i>=8 && i<12 && newResult.indexOf("억")<0){
	                result = "억";
	            }
	        }else{
	            result = result + danwi[i];
	        }
	        i++;
	        newResult = result + newResult;
	    }
	    
	    for(j=1;j<newResult.length;j++){
	        newResult = newResult.replace("영","");
	    }
	    
	    if((newResult.indexOf("만")-newResult.indexOf("억"))==1)
	        newResult = newResult.replace("만","");
	    if((newResult.indexOf("억")-newResult.indexOf("조"))==1)
	        newResult = newResult.replace("억","");
	        
	    return newResult;
	}
};

dynamic.render = {
	initRadio : function( id){
		var input = $("#" + id + "_input");
		$(':radio[id^=' + id + '][value!=xxxx]').bind( 'click', function(){ 
				input.attr('disabled','true');
				input.addClass('disabled');
		});
		$(':radio[id^=' + id + '][value=xxxx]').bind( 'click', function(){ 
			input.attr('disabled','');
			input.removeClass('disabled');
			this.value = input.val();
		});
		
		var xxxxRadio = $(':radio[id^=' + id + '][value=xxxx]');
		$("#" + id + "_input").bind('keyup', function(){
			xxxxRadio.val( input.val());
		});
		
		var checkedRadio = $(':radio[id^=' + id + ']:checked');
		if( checkedRadio.length == 0)
		{
			xxxxRadio.click();
		}
		else 
		{
			input.val('');
			checkedRadio.click();
		}
	}
};

dynamic.sjax = {
	constants : {
		RESTURL : "/sjax.do",
		PARAM_CMD : "cmd",
		PARAM_DUMMY : "_dummy"
	},
	
	init : function(){
		$.ajaxSetup({
			type: 'POST',
			timeout: 5000,
			dataType: 'json'
		});
	},
	
	call : function(cmd){
		var result = {};
		result.callback = function( responseText){
//			alert( responseText.value);
			result.returnObj = $.parseJSON( responseText.value);
			//result.returnObj = responseText;
			if( result.returnObj.error){
				alert( result.returnObj.error);
				return;
			}
		};
		
		var dummy = new Date().getTime();
		var url = dynamic.constants.CONTEXTPATH +
				dynamic.sjax.constants.RESTURL + "?" +
				dynamic.sjax.constants.PARAM_DUMMY + "=" +  dummy;
		var param = dynamic.sjax.constants.PARAM_CMD + "=" + cmd;
		$.ajax({
			url: url,
			data : param,
			success: result.callback,
			async: false,
			error: function(e){
				var msg = 'Error : ' + e.status + ' ' + e.statusText + ' ' + cmd; 
				alert( msg);
				throw msg;
			}
		});
		
		return result.returnObj;
	}
};

dynamic.excel = {
	openPopup : function( allParam, fid){
		var url = dynamic.constants.CONTEXTPATH + '/excel.do?action=popup&' + allParam;
		url = dynamic.url.removeParam(url, "fid");
		url += '&fid=' + fid;
		dynamic.util.openPopup( url, 'excelPageSelect', 500, 300);
	}
};

dynamic.string = {
	remove : function( target, str){
		if( target && str){
			var pos = target.indexOf( str);
			return target.substring( 0, pos) + target.substring( pos + str.length);
		}
		
		return target;
	}
};

dynamic.url = {
	getParam : function( url, paramName){
		var params = url.substring( url.indexOf('?') + 1).split('&');
		//console.log( params);
		for( var idx in params){
			if( params[idx]){
				var pair = params[idx].split('=');
				if( pair[0] == paramName)
					return pair[1];
			}
		}
		
		return null;
	},
	removeParam : function( url, paramName){
		var params = url.substring( url.indexOf('?') + 1).split('&');
		//console.log( params);
		var newParam = new Array();
		for( var idx in params){
			if( params[idx]){
				var pair = params[idx].split('=');
				if( pair[0] != paramName)
					newParam.push( params[idx]);
			}
		}
		
		return url.substring( 0, url.indexOf('?') + 1) + newParam.join('&');
	}
};

dynamic.roleuser = {
	deleteRoleUser : function( id){
		if( confirm('해당 사용자의 권한을 삭제하시겠습니까?')){
			dynamic.sjax.call("kr.co.sinshin.loss.service.SjaxService.deleteRoleUser(" + id + ")");
			location.reload();
		}
	}
};