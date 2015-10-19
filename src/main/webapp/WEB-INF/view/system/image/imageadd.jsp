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
			$('#image_op_create_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/image/main.action';
			});
			
			// 确定
			$('#image_op_create_submit').click(function(){
				if($('#image_create_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#image_create_form').ajaxSubmit({
						url: '<%=ctp %>/system/image/createimage.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','添加镜像成功！','info',function(){
								window.location.href = '<%=ctp %>/system/image/main.action';
							});
						}
					});
				}
			});
			
			$('#select_iso_file').combobox({
				url: '<%=ctp %>/system/image/listisofile.action',
				required: true,
				editable:false,
				valueField:'filePath',
			    textField:'fileName'
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>添加镜像</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="image_create_form">
			<div class="form_fieldset">
				<span>镜像信息</span>
				<table>
					<tr>
						<td width="150">名称</td>
						<td><input class="easyui-textbox" data-options="required:true" name="image.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td width="150">描述</td>
						<td><input class="easyui-textbox" data-options="required:false" name="image.desc" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td width="150">系统类型</td>
						<td><select class="easyui-combobox" data-options="required:true,editable:false" name="image.osType" style="width: 300px; height: 25px;">
							<option value='centos'>CentOS</option>
							<option value='rhel'>RHEL</option>
						</select></td>
					</tr>
					<tr>
						<td width="150">系统版本</td>
						<td><select class="easyui-combobox" data-options="required:true,editable:false" name="image.osVersion" style="width: 300px; height: 25px;">
							<option value='6.5'>6.5</option>
							<option value='6.6'>6.6</option>
						</select></td>
					</tr>
					<tr>
						<td width="150">系统架构</td>
						<td><select class="easyui-combobox" data-options="required:false,editable:false" name="image.osArch" style="width: 300px; height: 25px;">
							<option value='x86_64'>x86_64</option>
						</select></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>文件信息</span>
				<table>
					<tr>
						<td width="150">选择镜像文件</td>
						<td><input id="select_iso_file" name="image.isoFile" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="image_op_create_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="image_op_create_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>