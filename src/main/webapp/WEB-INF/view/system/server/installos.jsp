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
			$('#server_installos_cancel').click(function(){
				window.location.href = '<%=ctp %>/inventory/server/main.action';
			});
			
			// 确定
			$('#server_installos_submit').click(function(){
				if($('#server_installos_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#server_installos_form').ajaxSubmit({
						url: '<%=ctp %>/system/server/installos.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						traditional: true,
						success: function(data){
							$.messager.progress('close');
							if(data.success){
								$.messager.alert('成功','已开始安装操作系统！','info',function(){
									window.location.href = '<%=ctp %>/inventory/server/main.action';
								});
							}else{
								$.messager.alert('错误',data.message,'error');
							}
						}
					});
				}
			});
			
			$('#id_image_combobox').combobox({
				url:'<%=ctp %>/system/image/listimage.action',
				valueField:'imagename',
				textField:'imagename',
				required: true,
				editable:false
			});
			
			$('#id_template_combobox').combobox({
				url:'<%=ctp %>/system/template/listtemplate.action',
				valueField:'templateId',
				textField:'name',
				editable:false
			});
			
			$('#id_bootscripts_combobox').combobox({
				url:'<%=ctp %>/system/postscripts/listpostscripts.action',
				valueField:'id',
				textField:'name',
				multiple:true,
				editable:false
			});
			
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>操作系统安装</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="server_installos_form">
			<div class="form_fieldset">
				<span>服务器信息</span>
				<table>
					<tr>
						<td width="150">主机名</td>
						<td><input class="easyui-textbox" data-options="required: true" name="node.name" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>镜像信息</span>
				<table>
					<tr>
						<td width="150">选择镜像</td>
						<td><input id="id_image_combobox" name="node.osimage" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td width="150">选择模板</td>
						<td><input id="id_template_combobox" name="templateId" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<div class="form_fieldset">
				<span>脚本信息</span>
				<table>
					<tr>
						<td width="150">选择安装后执行脚本</td>
						<td><input id="id_bootscripts_combobox" name="node.bootScriptIds" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="serverId" value="<s:property value='#parameters.serverId' />">
		</form>	
		<div style="margin-left: 50px;">
			<a id="server_installos_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="server_installos_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>