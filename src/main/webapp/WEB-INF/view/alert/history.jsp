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
			$('#alert_history_main_grid').datagrid({    
			    url:'<%=ctp %>/alert/history/list.action',
			    fit: true,
			    fitColumns: true,
			    pagination: true,
			    pageSize : 20,
			    pageList : [20],
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
			
			$('#alert_history_query_submit').click(function(){
				var param = {};
				if ($('#alert_history_query_target_type').combobox('getValue') != null && $('#alert_history_query_target_type').combobox('getValue') != "")
				{
					param['alertQueryParam.targetType'] = $('#alert_history_query_target_type').combobox('getValue');
				}
				if ($('#alert_history_query_start_time').datebox('getValue') != null && $('#alert_history_query_start_time').datebox('getValue') != "")
				{
					param['alertQueryParam.startTime'] = $('#alert_history_query_start_time').datetimebox('getValue');
				}
				if ($('#alert_history_query_end_time').datebox('getValue') != null && $('#alert_history_query_end_time').datebox('getValue') != "")
				{
					param['alertQueryParam.endTime'] = $('#alert_history_query_end_time').datetimebox('getValue');
				}
	    		$('#alert_history_main_grid').datagrid('load', param);
			});
			
			
			$('#alert_history_query_cancel').click(function(){
				$('#alert_history_query_target_type').textbox('clear');
				$('#alert_history_query_start_time').datetimebox('clear');
				$('#alert_history_query_end_time').datetimebox('clear');
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:80px;">
		<div class="content_title">
			<div>历史告警</div>
		</div>
		<div style="font-weight: bold;font-size: 12px;">
			<table>
				<tr>
					<td style="text-align: center;">
						&nbsp;&nbsp;
						告警目标类型 
						<input id="alert_history_query_target_type" class="easyui-combobox" style="width:80px;" data-options="editable:false,
							valueField: 'label',
							textField: 'value',
							data: [{
								label: '1',
								value: '服务器'
							}]" 
						/>
						&nbsp;&nbsp;
						开始时间
						<input id="alert_history_query_start_time" class="easyui-datetimebox" data-options="editable:false" style="width:150px;" />
						&nbsp;&nbsp;
						结束时间
						<input id="alert_history_query_end_time" class="easyui-datetimebox" data-options="editable:false" style="width:150px;" />
						&nbsp;&nbsp;
						<a id="alert_history_query_submit" href="#" class="easyui-linkbutton" style="width: 80px;">搜索</a>
						<a id="alert_history_query_cancel" href="#" class="easyui-linkbutton" style="width: 80px;">重置</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="alert_history_main_grid"></table>
	</div>
</body>
</html>