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
	<script type="text/javascript" src="<%=ctp %>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/common.js"></script>
	<script type="text/javascript">
		
		$(function(){
			$('.sub_menu_item').click(function(){
				window.content_frame.location.href = $(this).attr('link');
			});
			
			$('.sub_menu_item:eq(0)').click();
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west', border: false" style="width:150px; overflow: hidden;">
		<div class="sub_menu">
			<div class="sub_menu_title">概览</div>
			<div class="sub_menu_group">
				<div class="sub_menu_item" link="<%=ctp %>/overview/serveroverview.action">服务器概览</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="overflow: hidden;">
		<iframe id="content_frame" name="content_frame" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
</body>
</html>