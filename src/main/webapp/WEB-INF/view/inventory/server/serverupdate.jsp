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
			$('#server_update_form').form('load', {
				"server.id": '<s:property value="server.id"/>',
				"server.ip": '<s:property value="server.ip"/>',
				"server.mac": '<s:property value="server.mac"/>',
				"server.monitorType": '<s:property value="server.monitorType"/>',
				"server.netmask": '<s:property value="server.netmask"/>',
				"server.properties.moduleId": '<s:property value="server.properties.moduleId"/>',
				"server.properties.machineId": '<s:property value="server.properties.machineId"/>'
			});
			
			// 取消
			$('#server_op_update_cancel').click(function(){
				window.location.href = '<%=ctp %>/inventory/server/main.action';
			});
			
			// 确定
			$('#server_op_update_submit').click(function(){
				if($('#server_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#server_update_form').ajaxSubmit({
						url: '<%=ctp %>/inventory/server/updateserver.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改服务器成功！','info',function(){
								window.location.href = '<%=ctp %>/inventory/server/main.action';
							});
						}
					});
				}
			});
			
			$('#select_machine_module_update').combobox({
				url: '<%=ctp %>/system/machineModule/list.action',
				valueField:'id',
			    textField:'name'
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>添加服务器</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="server_update_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td width="150">IP</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','checkIp']" name="server.ip" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>所属模块</td>
						<td><input id="select_machine_module_update" class="easyui-textbox" data-options="required: true,editable:false" name="server.properties.moduleId" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>mac</td>
						<td><input class="easyui-textbox" data-options="" name="server.mac" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>掩码</td>
						<td><input class="easyui-textbox" data-options="" name="server.netmask" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
				<input type="hidden" name="server.id">
				<input type="hidden" name="server.monitorType">
				<input type="hidden" name="server.properties.machineId">
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="server_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="server_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>