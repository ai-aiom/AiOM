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
			$('#scripts_update_form').form('load', {
				"postScripts.id": '<s:property value="postScripts.id"/>',
				"postScripts.name": '<s:property value="postScripts.name"/>',
				"postScripts.desc": '<s:property value="postScripts.desc"/>'
			});
			
			// 取消
			$('#scripts_op_update_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/postscripts/main.action';
			});
			
			// 确定
			$('#scripts_op_update_submit').click(function(){
				if($('#scripts_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#scripts_update_form').ajaxSubmit({
						url: '<%=ctp %>/system/postscripts/updatepostscripts.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							if(data.success){
								$.messager.alert('成功','编辑脚本成功！','info',function(){
									window.location.href = '<%=ctp %>/system/postscripts/main.action';
								});
							}else{
								$.messager.alert('错误',data.message,'error');
							}
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
			<div>编辑脚本</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="scripts_update_form">
			<div class="form_fieldset">
				<span>脚本信息</span>
				<table>
					<tr>
						<td width="150">脚本名称</td>
						<td><input class="easyui-textbox" data-options="required: true" name="postScripts.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td width="150">脚本描述</td>
						<td><input class="easyui-textbox" data-options="" name="postScripts.desc" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="postScripts.id">
		</form>	
		<div style="margin-left: 50px;">
			<a id="scripts_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="scripts_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>