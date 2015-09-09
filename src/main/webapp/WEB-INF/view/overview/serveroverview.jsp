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
	<script type="text/javascript" src="<%=ctp %>/js/echarts/dist/echarts-all.js"></script>
	<script type="text/javascript">
		
		$(function(){

	        var cpuChart = echarts.init(document.getElementById('overview_server_status_distribution_view'));
	        
	        var option = {
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient : 'vertical',
        	        x : 'left',
        	        data:['正常','监控不可达']
        	    },
        	    calculable : true,
        	    series : [
        	        {
        	            name:'访问来源',
        	            type:'pie',
        	            radius : '55%',
        	            center: ['50%', '60%'],
        	            data:[
        	                {value:"", name:'正常'},
        	                {value:"", name:'监控不可达'}
        	            ]
        	        }
        	    ]
        	};
			
	        var statusOn = '<s:property value="properties.statusOn"/>';
	        var statusOff = '<s:property value="properties.statusOff"/>';
	        option.series[0].data[0].value = statusOn;
	        option.series[0].data[1].value = statusOff;
	        cpuChart.setOption(option);
			
			$('#overview_server_status_distribution').panel({
				title: '服务器状态分布',
				height: 250
			});
			
			$('#overview_server_cpu_distribution').panel({
				title: '服务器CPU使用率分布',
				height: 200
			});
			
			$('#overview_server_memory_distribution').panel({
				title: '服务器内存使用率分布',
				height: 200
			});
			
			$('#overview_server_disk_distribution').panel({
				title: '服务器磁盘使用率分布',
				height: 200
			});
			
			$('#overview_server_cpu_top5').panel({
				title: '服务器CPU使用TOP5',
				height: 181
			});
			
			$('#overview_server_memory_top5').panel({
				title: '服务器内存使用TOP5',
				height: 200
			});
			
			$('#overview_server_disk_top5').panel({
				title: '服务器磁盘使用TOP5',
				height: 200
			});
			
			$('#overview_server_network_top5').panel({
				title: '服务器网络带宽使用TOP5',
				height: 200
			});
			
			$('#overview_server_cpu_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserverscputop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 100, align: 'center'},
					{field: 'serverRuntime.metrics.cpu_system.value', title: 'CPU_SYSTEM', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.cpu_user.value', title: 'CPU_USER', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.cpu_wio.value', title: 'CPU_WIO', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }}
				]]
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center', border: false" style="padding: 10px;">
		<table width="100%">
			<tr>
				<td width="40%" style="vertical-align: top;">
					<div id="overview_server_status_distribution">
						<div id="overview_server_status_distribution_view" style="height: 200px"></div>
					</div>
					<br>
					<div id="overview_server_cpu_distribution"></div>
					<br>
					<div id="overview_server_memory_distribution"></div>
					<br>
					<div id="overview_server_disk_distribution"></div>
				</td>
				<td width="10"></td>
				<td style="vertical-align: top;">
					<div id="overview_server_cpu_top5">
						<table id="overview_server_cpu_top5_table"></table>
					</div>
					<br>
					<div id="overview_server_memory_top5"></div>
					<br>
					<div id="overview_server_disk_top5"></div>
					<br>
					<div id="overview_server_network_top5"></div>
				</td>
			</tr>
		</table>	
	</div>
</body>
</html>