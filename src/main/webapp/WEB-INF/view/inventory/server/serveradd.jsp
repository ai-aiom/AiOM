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
			$('#server_op_create_cancel').click(function(){
				window.location.href = '<%=ctp %>/inventory/server/main.action';
			});
			
			// 确定
			$('#server_op_create_submit').click(function(){
				var val=$('input:radio[name="type"]:checked').val();
				if (val == 1) {
					if($('#server_create_form').form('validate')) {
						$.messager.progress({text: '正在处理，请稍后...'});
						$('#server_create_form').ajaxSubmit({
							url: '<%=ctp %>/inventory/server/addserver.action',
							type: 'POST',
							method: 'POST',
							dataType: 'json',
							success: function(data){
								$.messager.progress('close');
								$.messager.alert('成功','添加服务器成功！','info',function(){
									window.location.href = '<%=ctp %>/inventory/server/main.action';
								});
							}
						});
					}
				}else{
					if($('#server_select_form').form('validate')) {
						$.messager.progress({text: '正在处理，请稍后...'});
						$('#server_select_form').ajaxSubmit({
							url: '<%=ctp %>/inventory/server/serveraddbyexist.action',
							type: 'POST',
							method: 'POST',
							dataType: 'json',
							success: function(data){
								$.messager.progress('close');
								$.messager.alert('成功','添加服务器成功！','info',function(){
									window.location.href = '<%=ctp %>/inventory/server/main.action';
								});
							}
						});
					}
				}
			});
			
			$("input[name=type]").click(function(){
				var val=$('input:radio[name="type"]:checked').val();
				if(val == 1){
					$('#server_create_div1').show();
					$('#server_create_div2').hide();
	            }else{
	            	$('#server_create_div2').show();
					$('#server_create_div1').hide();
	            }
			});
			
			$("#select_module_for_server1").combobox({
				url: '<%=ctp %>/system/machineModule/list.action',
				valueField:'id',
			    textField:'name'
			});
			
			$("#select_module_for_server2").combobox({
				url: '<%=ctp %>/system/machineModule/list.action',
				valueField:'id',
			    textField:'name'
			});
			
			$("#select_server_for_add").combobox({
				multiple: true,
				url: '<%=ctp %>/inventory/server/listserveroutofmachine.action',
				valueField:'id',
			    textField:'ip'
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
		<div class="form_fieldset">
			<table>
				<tr>
					<td width="155">类型</td>
					<td><input type="radio" checked="checked" name="type" value="1"/>手动添加     <input type="radio" name="type" value="2"/>从已有的服务器中选择</td>
				</tr>
			</table>
		</div>
		
		<div id="server_create_div1" style="display: block">
			<form id="server_create_form">
				<div class="form_fieldset">
					<table>
						<tr>
							<td width="150">IP</td>
							<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="server.ip" style="width: 300px; height: 25px;"></td>
						</tr>
						<tr>
							<td>所属模块</td>
							<td><input id="select_module_for_server1" class="easyui-textbox" data-options="required: true,editable:false" name="server.properties.moduleId" style="width: 300px; height: 25px;"></td>
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
				</div>
			</form>
		</div>
		
		<div id="server_create_div2" style="display: none">
			<form id="server_select_form">
				<div class="form_fieldset">
					<table>
						<tr>
							<td width="150">所属模块</td>
							<td><input id="select_module_for_server2" class="easyui-textbox" data-options="required: true,editable:false" name="server.properties.moduleId" style="width: 300px; height: 25px;"></td>
						</tr>
						<tr>
							<td>服务器</td>
							<td><input id="select_server_for_add" class="easyui-textbox" data-options="required: true,editable:false" name="server.id" style="width: 300px; height: 25px;"></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		
		<div style="margin-left: 50px;">
			<a id="server_op_create_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="server_op_create_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>