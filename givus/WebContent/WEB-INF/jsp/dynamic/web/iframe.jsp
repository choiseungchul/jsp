<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
function resizeIF(obj) 
{ 
    var Body; 
    var H, Min; 

    Min = 100; 

    Body = (obj.contentWindow.document.getElementsByTagName('BODY'))[0]; 
    H = parseInt(Body.scrollHeight) + 5; 
    obj.style.height = (H<Min?Min:H) + 'px'; 

    window.scrollTo(1, 1); 
} 
</script>
<iframe width="100%" height="100%" src="${referenceUrl}" scrolling="no" noresize onload="resizeIF(this)"></iframe>