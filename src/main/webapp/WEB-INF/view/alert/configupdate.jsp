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
			$('#alert_config_update_form').form('load', {
				"alertConfig.id": '<s:property value="alertConfig.id"/>',
				"alertConfig.targetType": '<s:property value="alertConfig.targetType"/>',
				"alertConfig.targetId": '<s:property value="alertConfig.targetId"/>',
				"alertConfig.type": '<s:property value="alertConfig.type"/>',
				"alertConfig.level": '<s:property value="alertConfig.level"/>',
				"alertConfig.properties.metric": '<s:property value="alertConfig.properties.metric"/>',
				"alertConfig.properties.thresholdSymbol": '<s:property value="alertConfig.properties.thresholdSymbol"/>',
				"alertConfig.properties.thresholdValue": '<s:property value="alertConfig.properties.thresholdValue"/>',
				"alertConfig.properties.keepTime": '<s:property value="alertConfig.properties.keepTime"/>',
				"alertConfig.properties.recoverTime": '<s:property value="alertConfig.properties.recoverTime"/>',
			});
			
			// 取消
			$('#alert_config_op_update_cancel').click(function(){
				window.location.href = '<%=ctp %>/alert/config/main.action';
			});
			
			// 确定
			$('#alert_config_op_update_submit').click(function(){
				if($('#alert_config_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#alert_config_update_form').ajaxSubmit({
						url: '<%=ctp %>/alert/config/updateconfig.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改告警配置成功！','info',function(){
								window.location.href = '<%=ctp %>/alert/config/main.action';
							});
						}
					});
				}
			});
			
			$("#alert_config_for_object_update").combobox({
				url: '<%=ctp %>/inventory/server/list.action',
				valueField:'id',
			    textField:'ip'
			});
			
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>修改告警配置</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="alert_config_update_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td width="150">目标类型</td>
						<td>
							<input class="easyui-combobox" data-options="required:true,editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '1',
								value: '服务器'
							}]"
							name="alertConfig.targetType" style="width: 300px; height: 25px;">
						</td>
					</tr>
					<tr>
						<td>告警目标</td>
						<td><input id="alert_config_for_object_update" class="easyui-textbox" data-options="editable:false" name="alertConfig.targetId" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>告警类型</td>
						<td>
							<input class="easyui-combobox" data-options="required:true,editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '1',
								value: '性能告警'
							}]" name="alertConfig.type" style="width: 300px; height: 25px;">
						</td>
					</tr>
					<tr>
						<td>告警级别</td>
						<td>
							<input class="easyui-combobox" data-options="editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '1',
								value: '警告'
							},{
								label: '2',
								value: '次要'
							},{
								label: '3',
								value: '重要'
							},{
								label: '4',
								value: '严重'
							}]" name="alertConfig.level" style="width: 300px; height: 25px;">
						</td>
					</tr>
					<tr>
						<td>性能指标</td>
						<td>
							<input class="easyui-combobox" data-options="required:true,editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: 'cpu_usage',
								value: 'CPU使用率'
							},{
								label: 'mem_usage',
								value: '内存使用率'
							},{
								label: 'disk_usage',
								value: '磁盘使用率'
							}]" name="alertConfig.properties.metric" style="width: 300px; height: 25px;">
						</td>
					</tr>
					<tr>
						<td>阀值表达式</td>
						<td>
							<input id="alert_config_thresholdSymbol_for_update" class="easyui-combobox" data-options="required:true,editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '1',
								value: '>'
							},{
								label: '2',
								value: '='
							},{
								label: '3',
								value: '<'
							}]" name="alertConfig.properties.thresholdSymbol" style="width: 300px; height: 25px;">
						</td>
					</tr>
					<tr>
						<td>性能阀值</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','numberSize[0,100]']" name="alertConfig.properties.thresholdValue" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>持续时间 (分钟)</td>
						<td><input class="easyui-textbox" data-options="required:true" name="alertConfig.properties.keepTime" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>自动恢复时间 (分钟)</td>
						<td><input class="easyui-textbox" data-options="required:true" name="alertConfig.properties.recoverTime" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
				<input type="hidden" name="alertConfig.id">
			</div>
		</form>
		<div style="margin-left: 50px;">
			<a id="alert_config_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="alert_config_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>