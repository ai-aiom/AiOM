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
	<script type="text/javascript">
		
		$(function(){
			
			$('#server_main_grid').datagrid({    
			    url:'<%=ctp %>/inventory/server/list.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
			        {field: 'ip', title: 'IP', sortable: true, sorter: commonSorter, width: 100, align: 'center', formatter: function(value, row, index){
			        	return '<a href = <%=ctp%>/inventory/server/detail.action?serverId='+row.id+' style="text-align: left">'+value+'</a>';
			        }},
			        {field: 'serverRuntime.status', title: '监控状态', sortable: true, sorter: commonSorter, width: 100, align: 'center', formatter: function(value, row, index){
			        	if(value == 1){
			        		return '<div><img src="<%=ctp%>/images/device/status1.gif" style="vertical-align: middle; margin-right: 5px;">正常</div>';
			        	} else {
			        		var message = row.monitorType == '1' ? '监控不可达' : '无监控心跳';
			        		return '<div><img src="<%=ctp%>/images/device/status0.gif" style="vertical-align: middle; margin-right: 5px;">' + message + '</div>';
			        	}
			        }},
			        {field: 'monitorType', title: '监控类型', sortable: true, sorter: commonSorter, width: 80, align: 'center', formatter: function(value, row, index){
			        	if(value == 1){
			        		return 'ICMP';
			        	} else if(value == 2) {
			        		return 'SSH';
			        	} else if(value == 3) {
			        		return 'AGENT';
			        	}
			        }},
			        {field: 'powerStatus', title: '电源状态', sortable: true, sorter: commonSorter, width: 100, align: 'center', formatter: function(value, row, index){
			        	if(value == 1){
			        		return '<div><img src="<%=ctp%>/images/device/status1.gif" style="vertical-align: middle; margin-right: 5px;">开机</div>';
			        	} else {
			        		var message = SERVER_POWER_STATUS[value] ? SERVER_POWER_STATUS[value] : value;
			        		return '<div><img src="<%=ctp%>/images/device/status0.gif" style="vertical-align: middle; margin-right: 5px;">' + message + '</div>';
			        	}
			        }},
			        {field: 'hostname', title: '主机名', sortable: true, sorter: commonSorter, width: 100, align: 'center'},
			        {field: 'properties.moduleId', title: '所属模块', sortable: true, sorter: commonSorter, width: 100, align: 'center', formatter: function(value, row, index){
			        	return MACHINE_SERVER_MOUDLE[value] ? MACHINE_SERVER_MOUDLE[value] : value;
			        }},
			        {field: 'properties.cpuRate', title: 'cpu使用率', width: 100, align: 'center', formatter: function(value, row, index){
						return percentageView(value);
					}},
			        {field: 'properties.memoryRate', title: '内存使用率', width: 100, align: 'center', formatter: function(value, row, index){
						return percentageView(value);
					}},
			        {field: 'properties.diskRate', title: '磁盘使用率', width: 100, align: 'center', formatter: function(value, row, index){
						return percentageView(value);
					}},
			        {field: 'id', title: '操作', width: 100, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation serverId="' + value + '" style="text-align: left"></div>';
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
			    			var serverIdforUpdate = $(this).parent().attr('serverId');
			    			window.location.href = '<%=ctp %>/inventory/server/toserverupdate.action?id=' + serverIdforUpdate;
			    		});
			    		
			    		$deleteButton.click(function(){
			    			var serverIdforDelete = $(this).parent().attr('serverId');
			    			$.messager.confirm('确认删除', '确认要删除此服务器', function(r){
			    				if (r){
			    					$.messager.progress({text: '正在处理，请稍后...'});
			    					$.ajax({
			    						url: '<%=ctp %>/inventory/server/deleteserver.action?id=' + serverIdforDelete,
			    						dataType: 'json',
			    						success: function(){
			    							$.messager.progress('close');
			    							$('#server_main_grid').datagrid('reload');
			    						}
			    					});
			    				}
			    			});
			    		});
			    	});
			    },
				onClickRow: function (rowIndex, rowData) {
	                $(this).datagrid('unselectRow', rowIndex);
	            },
	            onDblClickRow: function(rowIndex, rowData){
	            	window.location.href = '<%=ctp%>/inventory/server/detail.action?serverId=' + rowData.id;
	            }
			});
			
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>服务器管理</div>
			<div class="content_title_operation">
				<a href="toserveradd.action" style="color: #000000">
					<span class="operation_icon_black" style="background-position: 0px -190px"></span>
					<span>添加服务器</span>
				</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="server_main_grid"></table>
	</div>
</body>
</html>