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
			$('#template_op_create_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/template/main.action';
			});
			
			// 确定
			$('#template_op_create_submit').click(function(){
				if($('#template_create_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					var users = {};
					$('#id_users_table tr').each(function(i){
						users['template.tempUserList['+i+'].name'] = $(this).find("[attr='name']").val();
						users['template.tempUserList['+i+'].groups'] = $(this).find("[attr='group']").val();
						users['template.tempUserList['+i+'].password'] = $(this).find("[attr='passwd']").val();
					});
					console.log(users);
					$('#template_create_form').ajaxSubmit({
						url: '<%=ctp %>/system/template/createorupdate.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						data:users,
						success: function(data){
							$.messager.progress('close');
							if(data.success){
								$.messager.alert('成功','添加模板成功！','info',function(){
									window.location.href = '<%=ctp %>/system/template/main.action';
								});
							}else{
								$.messager.alert('错误',data.message,'error');
							}
						}
					});
				}
			});
			
			$('#id_add_user').click(function(){
				var namelabel = '<td>用户名</td>';
				var nameinput = '<td><input attr="name" class="easyui-textbox" data-options="required:true" style="width: 105px;height: 25px;"></td>';
				var grouplabel = '<td>组</td>';
				var groupinput = '<td><input attr="group" class="easyui-textbox" style="width: 105px;height: 25px;"></td>';
				var passwdlabel = '<td>密码</td>';
				var passwdinput = '<td><input attr="passwd" class="easyui-textbox" data-options="type:\'password\'" style="width: 105px;height: 25px;"></td>';
				var operation = '<td><span delete_user class="operation_icon_black" style="background-position: -16px -190px"></span></td>';
				$tr = $('<tr></tr>');
				$tr.append(namelabel).append(nameinput).append(grouplabel).append(groupinput).append(passwdlabel).append(passwdinput).append(operation);
				$tr.appendTo($('#id_users_table'));
				$.parser.parse();
			});
			
			$(document).delegate('[delete_user]', 'click', function() {
				$(this).parent().parent().remove();
			}); 

		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>添加模板</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="template_create_form">
			<div class="form_fieldset">
				<span>模板信息</span>
				<table>
					<tr>
						<td width="150">模板名称</td>
						<td><input class="easyui-textbox" data-options="required: true" name="template.tempInfo.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td width="150">模板类型</td>
						<td><select class="easyui-combobox" data-options="required:true,editable:false" name="template.tempInfo.type" style="width: 300px; height: 25px;">
							<option value='kickstart'>kickstart</option>
						</select></td>
					</tr>
					<tr>
						<td width="150">模板描述</td>
						<td><input class="easyui-textbox" data-options="" name="template.tempInfo.desc" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>基本配置信息</span>
				<table>
					<tr>
						<td width="150">选择语言</td>
						<td><select class="easyui-combobox" data-options="required:true,editable:false" name="template.templateBasic.language" style="width: 300px; height: 25px;">
							<option value='en_US'>en_US</option>
							<option value='zh_CN'>zh_CN</option>
						</select></td>
					</tr>
					<tr>
						<td width="150">选择时区</td>
						<td><select class="easyui-combobox" data-options="required:true,editable:false" name="template.templateBasic.timezone" style="width: 300px; height: 25px;">
							<option value='Asia/Shanghai'>Asia/Shanghai</option>
						</select></td>
					</tr>
					<tr>
						<td width="150">root密码</td>
						<td><input id="txtpasswd" class="easyui-textbox" data-options="required:true,type:'password'" name="template.templateBasic.rootPw" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<table style="margin: 0px 0px 0px 0px; ">
					<tr>
						<td width="430"><span>用户信息</span></td>
						<td align="right"><div>
								<a id="id_add_user" href="#" style="color: #000000">
									<span class="operation_icon_black" style="background-position: 0px -190px"></span>
									添加用户
								</a>
						</div></td>
					</tr>
				</table>
				<table id="id_users_table">
				</table>
				
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="template_op_create_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="template_op_create_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>