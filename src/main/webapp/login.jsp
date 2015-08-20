<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ctp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AiOM亚信一体机管理平台</title>
<link type="text/css" rel="stylesheet" href="<%=ctp %>/css/login.css" />
<script type="text/javascript" src="<%=ctp %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=ctp %>/js/jquery.form.js"></script>
<script type="text/javascript">
	$(function(){
		if(window != window.top){
			window.top.location.href = "<%=ctp %>/login.jsp";
		}
		
		var clientWidth = document.documentElement.clientWidth;
		var clientHeight = document.documentElement.clientHeight;
		var left = (clientWidth-404)/2 + 'px';
		var top = (clientHeight-254)/2 + 'px';
		$('#login_panel').css({left:left});
		$('#login_panel').css({top:top});
		
		$('#btn_reset').click(function(){
			$('#login_form').get(0).reset();
		});
		
		$('input').click(function(){$('.error').empty()});
		
		$('#btn_submit').click(function(){
			$('.input_username').val($.trim($('.input_username').val()));
			$('.input_password').val($.trim($('.input_password').val()))
			
			if($('.input_username').val() == "" || $('.input_password').val() == "") {
				$('.error').empty().text('用户名和密码不能为空');
			} else {
				$('#login_form').ajaxSubmit({
					url: '<%=ctp %>/login.action',
					success: function(){
						window.location.href = '<%=ctp %>/main.action';
					},
					error: function(request, textStatus, errorThrown){
						if(request.status == 401) {
							$('.error').empty().text('用户名或者密码错误');
						} else {
							$('.error').empty().text('系统错误');
						}
					}
				});
			}
		});
	});
</script>
</head>
<body>
	<div id="login_panel">
		<form id="login_form">
		<div>
			<img src="<%=ctp%>/images/login/logo.png">
		</div>
		<div>
			<input type="text" name="username" class="input_username">
			<input type="password" name="password" class="input_password">
		</div>
		<div style="margin-top: 20px;">
			<input id="btn_submit" class="btn" value="登录" type="button" /> 
			<input id="btn_reset" class="btn" value="重置" type="button" />
		</div>
		<div class="error"></div>
		</form>
	</div>
</body>
</html>