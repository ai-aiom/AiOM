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
	<script type="text/javascript" src="<%=ctp %>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/common.js"></script>
	<script type="text/javascript">
		
		$(function(){
			$('.sub_menu_item').click(function(){
				window.content_frame.location.href = $(this).attr('link');
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west', border: false" style="width:150px; overflow: hidden;">
		<div class="sub_menu">
			<div class="sub_menu_title">系统</div>
			<div class="sub_menu_group">
				<div class="sub_menu_item">基本设置</div>
				<div class="sub_menu_item" link="<%=ctp %>/system/user/main.action">用户管理</div>
				<div class="sub_menu_item" link="<%=ctp %>/system/machine/main.action">一体机管理</div>
			</div>
			<div class="sub_menu_group">
				<span>位置</span>
				<div class="sub_menu_item" link="<%=ctp %>/system/location/main.action">机房管理</div>
				<div class="sub_menu_item" link="<%=ctp %>/system/cabinet/main.action">机柜管理</div>
			</div>
			<div class="sub_menu_group">
				<span>配置</span>
				<div class="sub_menu_item" link="<%=ctp %>/system/image/main.action">系统镜像管理</div>
				<div class="sub_menu_item" link="<%=ctp %>/system/template/main.action">系统模板配置</div>
				<div class="sub_menu_item" link="<%=ctp %>/system/postscripts/main.action">脚本配置管理</div>
				<div class="sub_menu_item">邮箱配置</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="overflow: hidden;">
		<iframe id="content_frame" name="content_frame" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
</body>
</html>