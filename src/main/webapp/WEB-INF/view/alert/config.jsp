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
			$('#alert_config_main_grid').datagrid({    
			    url:'<%=ctp %>/alert/config/list.action',
			    fit: true,
			    fitColumns: true,
			    columns:[[
					{field: 'targetType',title:'目标类型', width: 80, align: 'center', formatter: function(value, row, index){
						return ALERT_TARGET_TYPE[value] ? ALERT_TARGET_TYPE[value] : value;
					}},
					{field: 'targetId',title:'告警目标', width: 150, align: 'center', formatter: function(value, row, index){
						if(row.targetType == 1){
							return row.properties.targetName;
						}else{
							return value;
						}
					}},
					{field: 'level', title: '告警级别', width: 60, align: 'center', formatter: function(value, row, index){
						return ALERT_LEVEL[value] ? ALERT_LEVEL[value] : value;
					}},
					{field: 'properties.metric', title: '性能指标', width: 80, align: 'center', formatter: function(value, row, index){
						return ALERT_METRIC[value] ? ALERT_METRIC[value] : value;
					}},
					{field: 'properties.thresholdSymbol', title: '阀值表达式', width: 50, align: 'center', formatter: function(value, row, index){
						return ALERT_THRESHOLDSYMBOL[value] ? ALERT_THRESHOLDSYMBOL[value] : value;
					}},
					{field: 'properties.thresholdValue', title: '性能阀值', width: 50, align: 'center'},
					{field: 'properties.keepTime', title: '持续时间 (分钟)', width: 80, align: 'center'},
					{field: 'properties.recoverTime', title: '自动恢复时间 (分钟)', width: 80, align: 'center'},
			        {field: 'id', title: '操作', width: 100, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation alertConfigId="' + value + '" style="text-align: left"></div>';
			        }}
			    ]],
			    onLoadSuccess: function(data){
			    	$('[grid_operation]').each(function(){
			    		var $editButton = $('<span></span>').addClass('operation_icon_black');
			    		$editButton.css('background-position', '-64px -112px');
			    		$editButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$editButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$editButton.appendTo($(this));
			    		
			    		var $deleteButton = $('<span></span>').addClass('operation_icon_black');
			    		$deleteButton.css('background-position', '-176px -96px');
			    		$deleteButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$deleteButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$deleteButton.appendTo($(this));
			    		
			    		$editButton.click(function(){
			    			var alertConfigIdforUpdate = $(this).parent().attr('alertConfigId');
			    			window.location.href = '<%=ctp %>/alert/config/toconfigupdate.action?id=' + alertConfigIdforUpdate;
			    		});
			    		
			    		$deleteButton.click(function(){
			    			var alertConfigIdforDelete = $(this).parent().attr('alertConfigId');
			    			$.messager.confirm('确认删除', '确认要删除此告警配置', function(r){
			    				if (r){
			    					$.messager.progress({text: '正在处理，请稍后...'});
			    					$.ajax({
			    						url: '<%=ctp %>/alert/config/deleteconfig.action?id=' + alertConfigIdforDelete,
			    						dataType: 'json',
			    						success: function(){
			    							$.messager.progress('close');
			    							$('#alert_config_main_grid').datagrid('reload');
			    						}
			    					});
			    				}
			    			});
			    		});
			    	});
			    },
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>告警配置</div>
			<div class="content_title_operation">
				<a href="toconfigadd.action" style="color: #000000">
					<span class="operation_icon_black" style="background-position: 0px -190px"></span>
					<span>添加告警配置</span>
				</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="alert_config_main_grid"></table>
	</div>
</body>
</html>