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
			$('#cabinet_update_form').form('load', {
				"cabinet.id": '<s:property value="cabinet.id"/>',
				"cabinet.name": '<s:property value="cabinet.name"/>',
				"cabinet.size": '<s:property value="cabinet.size"/>',
				"cabinet.locationId": '<s:property value="cabinet.locationId"/>',
			});
			
			
			// 取消
			$('#cabinet_op_update_cancel').click(function(){
				window.cabinet.href = '<%=ctp %>/system/cabinet/main.action';
			});
			
			// 确定
			$('#cabinet_op_update_submit').click(function(){
				if($('#cabinet_update_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#cabinet_update_form').ajaxSubmit({
						url: '<%=ctp %>/system/cabinet/updatecabinet.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','修改机柜成功！','info',function(){
								window.location.href = '<%=ctp %>/system/cabinet/main.action';
							});
						}
					});
				}
			});
			
			$('#select_location_update').combobox({
				url: '<%=ctp %>/system/location/list.action',
				valueField:'id',
			    textField:'name'
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>修改机柜</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="cabinet_update_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td width="150">名称</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="cabinet.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>所属机房</td>
						<td><input id="select_location_update" class="easyui-textbox" data-options="required: true,editable:false" name="cabinet.locationId" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>大小</td>
						<td><input class="easyui-textbox" data-options="" name="cabinet.size" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
				<input type="hidden" name="cabinet.id">
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="cabinet_op_update_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="cabinet_op_update_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>