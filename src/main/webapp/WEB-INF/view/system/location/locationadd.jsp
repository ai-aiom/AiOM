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
			$('#location_op_create_cancel').click(function(){
				window.location.href = '<%=ctp %>/system/location/main.action';
			});
			
			// 确定
			$('#location_op_create_submit').click(function(){
				if($('#location_create_form').form('validate')) {
					$.messager.progress({text: '正在处理，请稍后...'});
					$('#location_create_form').ajaxSubmit({
						url: '<%=ctp %>/system/location/addlocation.action',
						type: 'POST',
						method: 'POST',
						dataType: 'json',
						success: function(data){
							$.messager.progress('close');
							$.messager.alert('成功','添加机房成功！','info',function(){
								window.location.href = '<%=ctp %>/system/location/main.action';
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
			<div>添加机房</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<form id="location_create_form">
			<div class="form_fieldset">
				<table>
					<tr>
						<td width="150">名称</td>
						<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="location.name" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>位置</td>
						<td><input class="easyui-textbox" data-options="" name="location.site" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>楼层</td>
						<td><input class="easyui-textbox" data-options="" name="location.floor" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>房间号</td>
						<td><input class="easyui-textbox" data-options="" name="location.room" style="width: 300px; height: 25px;"></td>
					</tr>
					<tr>
						<td>描述</td>
						<td><input class="easyui-textbox" data-options="" name="location.description" style="width: 300px; height: 25px;"></td>
					</tr>
				</table>
			</div>
		</form>	
		<div style="margin-left: 50px;">
			<a id="location_op_create_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">确定</a>  
			<a id="location_op_create_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 60px;">取消</a>
		</div>
	</div>
</body>
</html>