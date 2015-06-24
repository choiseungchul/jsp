<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>로그인</title>

    <link rel="stylesheet" type="text/css" href="${contextPath}/plugin/bootstrap-3.0.3/css/bootstrap.css?noc=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" type="text/css" href="${contextPath}/plugin/bootstrap-3.0.3/css/bootstrap-theme.css?noc=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" type="text/css" href="${contextPath}/style/admin/common.css?noc=<%=System.currentTimeMillis() %>" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="${contextPath}/script/jquery.base64.min.js"></script>
<script type="text/javascript" src="${contextPath}/plugin/bootstrap-3.0.3/js/bootstrap.js"></script>

<script type="text/javascript">
function login(){
	if($('#email').val() == ''){
		alert('이메일을 입력해주세요.');
		$('#email').focus();
		return;
	}
	if($('#pass').val() == ''){
		alert('비밀번호을 입력해주세요.');
		$('#pass').focus();
		return;
	}
	
	$.ajax({
		url:'${contextPath}/___/admin/loginproc',
		type: 'post',
		data: { email : $('#email').val(), pass  : $.base64.encode( $('#pass').val() ) },
		dataType : 'json',
		success:function(d){
			if(d.code == '0'){
				location.href='${contextPath}/___/admin/main';
			}else{
				alert(d.msg);
			}
		},
		error:function(e){
			
		}
	});
}
</script>
  </head>

  <body>

    <div class="container">

      <form class="form-signin" role="form">
        <h2 class="form-signin-heading">GIVUS 관리자로그인</h2>
        <input type="email" id="email" class="form-control" placeholder="Email address" required autofocus>
        <input type="password" id="pass" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 아이디저장
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="button" onclick="login();">Sign in</button>
      </form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
