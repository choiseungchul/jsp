<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div style="text-align:center;margin-top:20px;margin-bottom:50px;">
</div>
<%-- contextmenu --%>
<script>
$(function(){
    $.contextMenu({
        selector: '.context-menu-one', 
        trigger: 'left',
        callback: function(key, options) {
            var m = "clicked: " + key + "," + $(this).data('account');
            window.console && console.log(m) || alert(m); 
        },
        items: {
            "message": {name: "쪽지보내기", icon: "message"},
            "profile": {name: "프로필보기", icon: "profile"},
            "sep1": "---------",
            "quit": {name: "닫기", icon: "quit"}
        }
    });
});
</script>