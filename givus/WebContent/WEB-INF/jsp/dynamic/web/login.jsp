<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<link type="text/css" href="${contextPath}/style/dynamic/login.css" rel="stylesheet" />

	<script>
		$(function() {
			if (window.parent.frames.length > 0) {
				window.parent.location.href = document.location.href;
			}

			$("form input").keyup(function(e) {
				if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
					doLogin();
					return false;
				} else {
					return true;
				}
			});
		});

		function doLogin() {
			$('.login-error').html("<span>로그인 중입니다.</span>");
			dynamic.util.submitForm('login_form');
		}
	</script>
	
	<form action="${contextPath}/login.do" id="login_form" method="post">
		<table class="table-body">
			<tr valign="middle" align="center">
				<td>
					<table width="900" height="499" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="50">&nbsp;</td>
						</tr>
						<tr>
							<td height="110" align="center"><img src='${imageHandler.login_top_img}' width="900" height="110" /></td>
						</tr>
						<tr>
							<td height="72" align="center"><table width="640" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="63" align="left" valign="bottom"><img src='${imageHandler.login_members_login}' alt="" width="135" height="24" /></td>
									</tr>
									<tr>
										<td>
											<table width="640" height="196" border="0" align="center" cellpadding="0" cellspacing="0">
												<tr>
													<td background='${imageHandler.login_bg_img}' width="640" height="194">

														<table width="365" border="0" align="left" cellpadding="0" cellspacing="0">
															<tr>
																<td width="10" height="20">&nbsp;</td>
																<td width="105"><img src='${imageHandler.login_id}' alt="" width="105" height="20" /></td>
																<td width="145"><input type="text" name="account" class="login-input-text" value="${account}" style="height: 17px;" tabindex="1"></td>
																<td width="105" rowspan="2" align="right"><img src="${imageHandler.login_login}" alt="" width="87" height="40" onclick="doLogin()" tabindex="3" value="로그인" /></td>
															</tr>
															<tr>
																<td>&nbsp;</td>
																<td><img src='${imageHandler.login_password}' alt="" width="105" height="20" /></td>
																<td><input type="password" name="password" class="login-input-text" style="height: 17px;" onclick="this.blur" tabindex="2"></td>
															</tr>
															<tr>
																<td colspan=4 class="login-error" height="20">${errormessage}</td>
															</tr>
														</table>

													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="74" align="center"><img src='${imageHandler.zadu_copyright}' width="241" height="15" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	

