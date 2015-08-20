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
			$('#user_op_create_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/user/main.action';
			});
			
			// 确定
			$('#user_op_create_submit').click(function(){
				if($('#user_create_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#user_create_form').ajaxSubmit({
						url: '<%=ctp %>/system/user/adduser.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','添加用户成功！','info',function(){
								window.location.href = '<%=ctp %>/system/user/main.action';
							});
						}
					});
				}
			});
			
			$('#select_role').combobox({
				url: '<%=ctp %>/system/role/list.action',
				valueField:'id',
			    textField:'name'
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>添加用户</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="user_create_form">
			<div class="form_fieldset">
				<span>登录信息</span>
				<table>
					<tr>
						<td width="150">登录帐号</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="user.account" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>登录密码</td>
						<td><input id="txtpasswd" class="easyui-textbox" data-options="required: true,validType:['blank','length[8,128]']" name="user.password" type="password" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>重复登录密码</td>
						<td><input class="easyui-textbox" data-options="required: true,validType:'equalTo[\'txtpasswd\']'" name="repeatPassword" type="password" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>联系人信息</span>
				<table>
					<tr>
						<td width="150">名称</td>
						<td><input class="easyui-textbox" data-options="required:false,validType:'maxLength[32]'" name="user.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>邮箱</td>
						<td><input class="easyui-textbox" data-options="required:false,validType:'email'" name="user.email" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>权限控制</span>
				<table>
					<tr>
						<td width="150">用户角色</td>
						<td><input id="select_role" class="easyui-textbox" data-options="required: true,editable:false" name="user.role.id" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>描述信息</span>
				<table>
					<tr>
						<td width="150">用户描述</td>
						<td><input class="easyui-textbox" data-options="multiline: true,required:false,validType:'maxLength[256]'" name="user.description" style="width: 300px; height: 100px;"></td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="user.state" value="1">
		</form>	
		<div style="margin-left: 50px;">
			<a id="user_op_create_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="user_op_create_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>