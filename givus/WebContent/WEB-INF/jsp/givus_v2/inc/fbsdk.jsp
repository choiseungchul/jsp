<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
window.fbAsyncInit = function() {
    FB.init({
      appId      : '724203754269433', // App ID from the App Dashboard      
      //channelUrl : '//www.socialwing.co.kr/js/channel.html', // Channel File for x-domain communication
      status     : true, // check the login status upon init?
      cookie     : true, // set sessions cookies to allow your server to access the session?
      xfbml      : true,  // parse XFBML tags on this page?
      locale	 : 'ko_KR',
        version : 'v1.0'
    });
  };
  
  

 (function(d, debug){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/ko_KR/all" + (debug ? "/debug" : "") + ".js";
    ref.parentNode.insertBefore(js, ref);
  }(document, /*debug*/ false));
</script>