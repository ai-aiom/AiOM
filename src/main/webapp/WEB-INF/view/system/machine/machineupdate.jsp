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
			$('#machine_update_form').form('load', {
				"machine.id": '<s:property value="machine.id"/>',
				"machine.name": '<s:property value="machine.name"/>',
				"machine.description": '<s:property value="machine.description"/>',
				"machine.type": '<s:property value="machine.type"/>',
				"machine.serviceEndpoint": '<s:property value="machine.serviceEndpoint"/>',
			});
			
			// 取消
			$('#machine_op_update_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/machine/main.action';
			});
			
			// 确定
			$('#machine_op_update_submit').click(function(){
				if($('#machine_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#machine_update_form').ajaxSubmit({
						url: '<%=ctp %>/system/machine/updatemachine.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改一体机成功！','info',function(){
								window.location.href = '<%=ctp %>/system/machine/main.action';
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
			<div>修改一体机</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="machine_update_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td width="150">名称</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="machine.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>类型</td>
						<td>
							<select class="easyui-combobox" name="machine.type" style="width: 300px; height: 25px;">
								<option value="1">大数据通用一体机</option>
								<option value="2">ADB数据库一体机</option>
								<option value="3">ORACLE数据库一体机</option>
								<option value="4">DACP数据资产管理一体机</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>服务端点</td>
						<td><input class="easyui-textbox" data-options="" name="machine.serviceEndpoint" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>描述</td>
						<td><input class="easyui-textbox" data-options="" name="machine.description" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
				<input type="hidden" name="machine.id">
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="machine_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="machine_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>