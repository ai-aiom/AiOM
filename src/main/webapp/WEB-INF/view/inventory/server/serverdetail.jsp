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
	<script type="text/javascript" src="<%=ctp %>/js/constants.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/echarts/dist/echarts.js"></script>
	<script type="text/javascript">
		
		$(function(){
			
			var serverId = '<s:property value="#parameters.serverId" />';
			$('#server_detail_summary').load('<%=ctp %>/inventory/server/summary.action?serverId=' + serverId);
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center', border: false" style="padding: 10px">
		<div id="tt" class="easyui-tabs" data-options="fit: true, border: false">   
		    <div id="server_detail_summary" title="概况" data-options="closable: false" style="padding-top: 10px;">   
		    </div>   
		    <div title="性能" data-options="closable: false">   
		        tab2    
		    </div>   
		    <div title="告警" data-options="closable: false"> 
		        tab3    
		    </div>   
		</div>  
	</div>
</body>
</html>