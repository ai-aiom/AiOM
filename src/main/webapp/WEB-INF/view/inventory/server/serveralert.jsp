<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>
<script type="text/javascript">
	$(function(){
		$.parser.parse();
		var serverId = '<s:property value="#parameters.serverId"/>';
		$('#server_alert_main_grid').datagrid({    
		    url:'<%=ctp %>/inventory/server/listalerts.action?alertQueryParam.targetId=' + serverId,
		    fit: true,
		    fitColumns: true,
		    pagination: true,
		    pageSize : 20,
		    pageList : [20],
		    columns:[[
		        {field: 'time', title: '告警时间', width: 150, align: 'center', formatter: function(value, row, index){
		        	return dateFormat(value);
		        }},
		        {field: 'level', title: '级别', width: 100, fixed: true, align: 'center', formatter: function(value, row, index){
					return ALERT_LEVEL[value] ? ALERT_LEVEL[value] : value;
				}},
		        {field: 'targetType',title:'目标类型', width: 80, align: 'center', formatter: function(value, row, index){
		        	return ALERT_TARGET_TYPE[value] ? ALERT_TARGET_TYPE[value] : value;
		        }},
		        {field: 'properties.targetDisplay',title:'告警目标', width: 150, align: 'center'},
		        {field: 'description', title: '描述', width: 200, align: 'center'},
		        {field: 'status', title: '状态', width: 80, align: 'center', formatter: function(value, row, index){
		        	return value == 1 ? '已解决' : '未解决';
		        }},
		        {field: 'id', title: '操作', width: 150, fixed: true, fixed: true, align: 'center', formatter: function(value, row, index){
		        	if(row.status == 0){
		        		return '<div grid_operation alertId="' + value + '" style="text-align: left"></div>'; 
		        	}else{
		        		return '';
		        	}
		        }} 
		    ]],
		    onLoadSuccess: function(data){
		    	$('[grid_operation]').each(function(){
		    		var $confirmButton = $('<span></span>').addClass('operation_icon_black');
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
		    							$('#server_alert_main_grid').datagrid('reload');
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
<div data-options="fit: true, border: false" class="easyui-layout">
	<div data-options="region:'center', border: false" style="padding: 10px;">
		<table id="server_alert_main_grid"></table>
	</div>
</div>

