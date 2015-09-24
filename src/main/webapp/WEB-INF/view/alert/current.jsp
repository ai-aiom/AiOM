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
	<script type="text/javascript" src="<%=ctp %>/js/constants.js"></script>
	<script type="text/javascript">
		
		$(function(){
			$('#alert_current_main_grid').datagrid({    
			    url:'<%=ctp %>/alert/current/list.action',
			    fit: true,
			    fitColumns: true,
			    columns:[[
			        {field: 'time', title: '告警时间', width: 150, align: 'center', formatter: function(value, row, index){
			        	return dateFormat(value);
			        }},
			        {field: 'level', title: '级别', width: 80, align: 'center'},
			        {field: 'targetType',title:'目标类型', width: 80, align: 'center', formatter: function(value, row, index){
			        	return ALERT_TARGET_TYPE[value] ? ALERT_TARGET_TYPE[value] : value;
			        }},
			        {field: 'targetId',title:'目标ID', width: 100, align: 'center'},
			        {field: 'description', title: '描述', width: 200, align: 'center'},
			        {field: 'source', title: '告警源', width: 100, align: 'center'},
			        {field: 'configId', title: '告警配置ID', width: 100, align: 'center'},
			        {field: 'status', title: '状态', width: 80, align: 'center', formatter: function(value, row, index){
			        	return value == 1 ? '已解决' : '未解决';
			        }}
			    ]]
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>当前告警</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="alert_current_main_grid"></table>
	</div>
</body>
</html>