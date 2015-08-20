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
		function getCtp()
		{
			return '<%=ctp %>';
		}
		
		$(function(){
			
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'west', border: false" style="width:150px; overflow: hidden;">
		<div class="sub_menu">
			<div class="sub_menu_title">资源清单</div>
			<div class="sub_menu_group">
				<span>视图</span>
				<div class="sub_menu_item">机架视图</div>
				<div class="sub_menu_item">拓扑结构</div>
			</div>
			<div class="sub_menu_group">
				<span>设备清单</span>
				<div class="sub_menu_item">服务器</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="overflow: hidden;">
		<iframe id="content_frame" name="content_frame" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
</body>
</html>