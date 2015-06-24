<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script>
// 로그인 로직
window.fbAsyncInit = function() {
    FB.init({
      appId      : '1427018384229922', // App ID from the App Dashboard
      //channelUrl : '//www.socialwing.co.kr/js/channel.html', // Channel File for x-domain communication
      status     : true, // check the login status upon init?
      cookie     : true, // set sessions cookies to allow your server to access the session?
      xfbml      : true,  // parse XFBML tags on this page?
      locale	 : 'ko_KR'
    });
  };

  (function(d, debug){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/ko_KR/all" + (debug ? "/debug" : "") + ".js";
     ref.parentNode.insertBefore(js, ref);
   }(document, /*debug*/ false));

 function fbLogin(){	  
	 FB.login(function(response) {
		   if (response.authResponse) {
			   FB.api('/me', function(data){				   
				   if(data.email){
					   if(data.email == 'arcray@naver.com' || data.email == 'maxotagu79@naver.com' || data.email == 'ahappymood@hotmail.com' || data.email == 'ksr18bobae@naver.com'){						   
						   location.replace('${contextPath}/___/renew/main');
					   }else{
						   alert('권한이 없습니다.');
					   }
				   }
			   });
		   }
	 },{ scope : 'email' });
 }

//
</script>
</head>
<body>
<div class="container" style="margin: 0 auto; width:1024px">
<h1>Under Construction</h1>
<h3>관리자분은 아래 로그인 버튼을 눌러주세요.</h3>
<button onclick="fbLogin()">로그인</button>
</div>
</body>
</html>