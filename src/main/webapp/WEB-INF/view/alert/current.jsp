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
			        {field: 'time', title: '告警时间', width: 150, fixed: true, align: 'center', formatter: function(value, row, index){
			        	return dateFormat(value);
			        }},
			        {field: 'level', title: '级别', width: 100, fixed: true, align: 'center', formatter: function(value, row, index){
						return ALERT_LEVEL[value] ? ALERT_LEVEL[value] : value;
					}},
			        {field: 'targetType',title:'目标类型', width: 120, fixed: true, align: 'center', formatter: function(value, row, index){
			        	return ALERT_TARGET_TYPE[value] ? ALERT_TARGET_TYPE[value] : value;
			        }},
			        {field: 'properties.targetDisplay',title:'目标', width: 200, fixed: true, align: 'center'},
			        {field: 'description', title: '描述', width: 200, align: 'center'},
			        {field: 'id', title: '操作', width: 150, fixed: true, fixed: true, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation alertId="' + value + '" style="text-align: left"></div>';
			        }}
			    ]],
			    onLoadSuccess: function(data){
			    	$('[grid_operation]').each(function(){
			    		var $confirmButton = $('<span title="确认告警"></span>').addClass('operation_icon_black');
			    		$confirmButton.css('background-position', '-48px -240px');
			    		$confirmButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$confirmButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$confirmButton.appendTo($(this));
			    		
			    		$confirmButton.click(function(){
			    			var alertIdforConfirm = $(this).parent().attr('alertId');
			    			$.messager.confirm('确认', '确认此告警', function(r){
			    				if (r){
			    					$.messager.progress({text: '正在处理，请稍后...'});
			    					$.ajax({
			    						url: '<%=ctp %>/alert/current/confirm.action?id=' + alertIdforConfirm,
			    						dataType: 'json',
			    						success: function(){
			    							$.messager.progress('close');
			    							$('#alert_current_main_grid').datagrid('reload');
			    						}
			    					});
			    				}
			    			});
			    		});
			    	});
			    }
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