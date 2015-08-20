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
			// 初始化数据
			$('#user_update_form').form('load', {
				"user.id": '<s:property value="user.id"/>',
				"user.account": '<s:property value="user.account"/>',
				"user.password": '<s:property value="user.password"/>',
				"user.name": '<s:property value="user.name"/>',
				"user.email": '<s:property value="user.email"/>',
				"user.state": '<s:property value="user.state"/>',
				"user.description": '<s:property value="user.description"/>',
			});
			
			// 取消
			$('#user_op_update_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/user/main.action';
			});
			
			// 确定
			$('#user_op_update_submit').click(function(){
				if($('#user_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#user_update_form').ajaxSubmit({
						url: '<%=ctp %>/system/user/updateuser.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改用户成功！','info',function(){
								window.location.href = '<%=ctp %>/system/user/main.action';
							});
						}
					});
				}
			});
			
			$('#select_role_update').combobox({
				url: '<%=ctp %>/system/role/list.action',
				valueField:'id',
			    textField:'name',
			    onLoadSuccess: function(){
			    	$('#select_role_update').combobox('setValue', '<s:property value="user.role.id"/>');
			    }
			});
			
			//用户账号唯一不可变
			$('#user_update_account').textbox({
			    disabled: true
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>修改用户</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="user_update_form">
			<div class="form_fieldset">
				<span>登录信息</span>
				<table>
					<tr>
						<td width="150">登录帐号</td>
						<td><input id="user_update_account" class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="user.account" style="width: 300px; height: 25px;"></td>
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
						<td><input id="select_role_update" class="easyui-textbox" data-options="required: true,editable:false" name="user.role.id" style="width: 300px; height: 25px;"></td>
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
			<input type="hidden" name="user.id">
			<input type="hidden" name="user.group.id" value="1">
			<input type="hidden" name="user.state" value="1">
		</form>
		<div style="margin-left: 50px;">
			<a id="user_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="user_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>