var givus = {};

givus.user = {
	disuseUser : function( id){
		if( confirm('영구 삭제 하시겠습니까? \n\n 사용자 삭제시 사용자에 대한 정보가 영구 삭제되며 다시는 복구할 수 없습니다.')){
			location.href=dynamic.constants.CONTEXTPATH + '/delete.do?fid=' + dynamic.functions.funcUserDelete + '&id=' + id;
		}
	},
	deleteUser : function( id){
		if( confirm('삭제 하시겠습니까? \n\n 사용자 삭제시 사용자에 대한 정보가 영구 삭제됩니다.')){
			location.href=dynamic.constants.CONTEXTPATH + '/edit.do?fid=' + dynamic.functions.funcUserDelete + '&id=' + id;
		}
	},
	lockUser : function( id){
		if( confirm('상태를 잠금 하시겠습니까? \n\n 사용안함으로 변경시 사용자의 모든 활동이 중지됩니다.')){
			location.href=dynamic.constants.CONTEXTPATH + '/edit.do?fid=' + dynamic.functions.funcUserLock + '&id=' + id;
		}
	},
	activeUser : function( id){
		if( confirm('상태를 활성화 하시겠습니까? \n\n 활성화 변경시 사용자의 모든 활동이 가능하게 됩니다.')){
			location.href=dynamic.constants.CONTEXTPATH + '/edit.do?fid=' + dynamic.functions.funcUserActivate + '&id=' + id;
		}
	}
};