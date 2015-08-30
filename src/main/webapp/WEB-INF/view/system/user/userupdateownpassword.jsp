<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>亚信一体机管理系统</title>
	<link rel="stylesheet" type="text/css" href="<%=ctp %>/js/easyui/themes/gray/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=ctp %>/css/aiom/default/aiom.css">
	<script type="text/javascript" src="<%=ctp %>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/easyui/validatebox.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/common.js"></script>
	<script type="text/javascript">
		
		$(function(){
			
			// 取消
			$('#user_op_update_own_password_cancel').click(function(){
				window.location.href = '<%=ctp %>/main.action';
			});
			
			// 确定
			$('#user_op_update_own_password_submit').click(function(){
				if($('#user_update_own_password_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#user_update_own_password_form').ajaxSubmit({
						url: '<%=ctp %>/system/user/updateuserownpassword.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改个人密码成功！','info',function(){
								window.location.href = '<%=ctp %>/main.action';
							});
						}
					});
				}
			});
			
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>修改个人密码</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="user_update_own_password_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td>原始密码</td>
						<td><input class="easyui-textbox" data-options="required: true,validType:['blank','length[8,128]']" name="oldPassword" type="password" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>登录密码</td>
						<td><input id="txtpasswd" class="easyui-textbox" data-options="required: true,validType:['blank','length[8,128]']" name="newPassword" type="password" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>重复登录密码</td>
						<td><input class="easyui-textbox" data-options="required: true,validType:'equalTo[\'txtpasswd\']'" name="repeatPassword" type="password" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
		</form>
		<div style="margin-left: 50px;">
			<a id="user_op_update_own_password_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="user_op_update_own_password_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>