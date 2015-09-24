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
	<script type="text/javascript" src="<%=ctp %>/js/echarts/dist/echarts-all.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/echarts/dist/theme/blue.js"></script>
	<script type="text/javascript">
		
		$(function(){

	        var serverStatusChart = echarts.init(document.getElementById('overview_server_status_distribution_view'),blueTheme);
	        
	        var option = {
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{a} <br/>{b} : {c} ({d}%)"
        	    },
        	    legend: {
        	        orient : 'vertical',
        	        x : 'left',
        	        y : 'center',
        	        data:['正常','监控不可达','关机','开机','未知','未配IPMI']
        	    },
        	    calculable : false,
        	    series : [
        	        {
        	            name:'监控状态',
        	            type:'pie',
        	            radius : ['0%','40%'],
        	            center: ['60%', '55%'],
        	            itemStyle : {
        	                normal : {
        	                    label : {
        	                        position : 'outer'
        	                    },
        	                    labelLine : {
        	                        show : true,
        	                        length : 50
        	                    }
        	                }
        	            },
        	            data:[
        	                {value:"", name:'正常'},
        	                {value:"", name:'监控不可达'}
        	            ]
        	        },
        	        {
        	            name:'电源状态',
        	            type:'pie',
        	            radius : ['50%', '75%'],
        	            center: ['60%', '55%'],
        	            data:[
        	                {value:"", name:'关机'},
        	                {value:"", name:'开机'},
        	                {value:"", name:'未知'},
        	                {value:"", name:'未配IPMI'}
        	            ]
        	        }
        	    ]
        	};
			
	        var serverStatus = [<s:property value="rates.serverStatus"/>];
	        option.series[0].data[0].value = serverStatus[0] == 0 ? '-' : serverStatus[0];
	        option.series[0].data[1].value = serverStatus[1] == 0 ? '-' : serverStatus[1];
	        
	        var serverPowerStatus = [<s:property value="rates.serverPowerStatus"/>];
	        option.series[1].data[0].value = serverPowerStatus[0] == 0 ? '-' : serverPowerStatus[0];
	        option.series[1].data[1].value = serverPowerStatus[1] == 0 ? '-' : serverPowerStatus[1];
	        option.series[1].data[2].value = serverPowerStatus[2] == 0 ? '-' : serverPowerStatus[2];
	        option.series[1].data[3].value = serverPowerStatus[3] == 0 ? '-' : serverPowerStatus[3];
	        
	        serverStatusChart.setOption(option);
			
	        var cpuRateChart = echarts.init(document.getElementById('overview_server_cpu_distribution_view'),blueTheme);
	        var memoryRateChart = echarts.init(document.getElementById('overview_server_memory_distribution_view'),blueTheme);
	        var diskRateChart = echarts.init(document.getElementById('overview_server_disk_distribution_view'),blueTheme);
	        
	        var option2 = {
        	    tooltip : {
        	        trigger: 'item',
        	        formatter: "{b} : {c} (台)"
        	    },
        	    calculable : false,
        	    xAxis : [
        	        {
        	            type : 'category',
        	            name : '%',
        	            data : ['0-20','21-40','41-60','61-80','81-100','未知'],
        	            axisLabel : {
        	            	interval : '0'
        	            }
        	        }
        	    ],
        	    yAxis : [
        	        {
        	            type : 'value',
        	        }
        	    ],
        	    series : [
        	        {
        	            type : 'bar',
        	            barWidth: 25,
        	            itemStyle : {
        	            	normal: {
        	            		barBorderRadius : [5, 5, 0, 0]
        	                }
        	            },
        	            data : []
        	        }
        	    ]
        	};
	        
	        option2.series[0].data = [<s:property value="rates.cpuRate"/>];
	        cpuRateChart.setOption(option2);
	        
 	        option2.series[0].data = [<s:property value="rates.memoryRate"/>];
	        memoryRateChart.setOption(option2);
	        
	        option2.series[0].data = [<s:property value="rates.diskRate"/>];
	        diskRateChart.setOption(option2);
	        
			$('#overview_server_status_distribution').panel({
				title: '服务器状态分布',
				height: 250
			});
			
			$('#overview_server_cpu_distribution').panel({
				title: '服务器CPU使用率分布',
				height: 250
			});
			
			$('#overview_server_memory_distribution').panel({
				title: '服务器内存使用率分布',
				height: 250
			});
			
			$('#overview_server_disk_distribution').panel({
				title: '服务器磁盘使用率分布',
				height: 250
			});
			
			$('#overview_server_cpu_top5').panel({
				title: '服务器CPU使用TOP5',
				height: 179
			});
			
			$('#overview_server_memory_top5').panel({
				title: '服务器内存使用TOP5',
				height: 179
			});
			
			$('#overview_server_disk_top5').panel({
				title: '服务器磁盘使用TOP5',
				height: 179
			});
			
			$('#overview_server_network_top5').panel({
				title: '服务器网络带宽使用TOP5',
				height: 179
			});
			
			$('#overview_server_load_top5').panel({
				title: '服务器负载使用TOP5',
				height: 179
			});
			
			$('#overview_server_cpu_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserverscputop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 150, align: 'center', fixed: true},
					{field: 'serverRuntime.metrics.cpu_system.value', title: 'SYSTEM', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return percentageView(value);
			        	}
			        }},
			        {field: 'serverRuntime.metrics.cpu_user.value', title: 'USER', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return percentageView(value);
			        	}
			        }},
			        {field: 'serverRuntime.metrics.cpu_wio.value', title: 'WIO', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return percentageView(value);
			        	}
			        }}
				]]
			});
			
			$('#overview_server_memory_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserversmemorytop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 150, align: 'center', fixed: true},
					{field: 'properties.memoryRate', title: '使用率', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return percentageView(value);
			        	}
			        }},
					{field: 'serverRuntime.metrics.mem_shared.value', title: 'SHARED (KB)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.mem_buffers.value', title: 'BUFFERS (KB)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.mem_cached.value', title: 'CACHED (KB)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.mem_free.value', title: 'FREE (KB)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }}
				]]
			});
			
			$('#overview_server_disk_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserversdisktop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 150, align: 'center', fixed: true},
					{field: 'properties.diskRate', title: '使用率', width: 100, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return percentageView(value);
			        	}
			        }},
					{field: 'serverRuntime.metrics.disk_total.value', title: '总大小(GB)', width: 120, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.disk_free.value', title: '空闲大小(GB)', width: 120, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }}
				]]
			});
			
			$('#overview_server_network_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserversnetworktop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 150, align: 'center', fixed: true},
					{field: 'serverRuntime.metrics.bytes_out.value', title: '出口速率 (B/S)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.bytes_in.value', title: '入口速率 (B/S)', width: 60, halign: 'center', align: 'right', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }}
				]]
			});
			
			$('#overview_server_load_top5_table').datagrid({    
			    url:'<%=ctp %>/overview/getserversloadtop.action',
			    fit: true,
			    remoteSort: false,
			    fitColumns: true,
			    columns:[[
					{field: 'ip', title: 'IP', width: 150, align: 'center', fixed: true},
					{field: 'serverRuntime.metrics.load_one.value', title: '一分钟负载', width: 60, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.load_five.value', title: '五分钟负载', width: 60, align: 'center', formatter: function(value, row, index){
			        	if(row.monitorType == 1){
			        		return "N/A";
			        	} else {
			        		return value;
			        	}
			        }},
			        {field: 'serverRuntime.metrics.load_fifteen.value', title: '十五分钟负载', width: 60, align: 'center', formatter: function(value, row, index){
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
					<div id="overview_server_cpu_distribution">
						<div id="overview_server_cpu_distribution_view" style="height: 220px"></div>
					</div>
					<br>
					<div id="overview_server_memory_distribution">
						<div id="overview_server_memory_distribution_view" style="height: 220px"></div>
					</div>
					<br>
					<div id="overview_server_disk_distribution">
						<div id="overview_server_disk_distribution_view" style="height: 220px"></div>
					</div>
				</td>
				<td width="10"></td>
				<td style="vertical-align: top;">
					<div id="overview_server_cpu_top5">
						<table id="overview_server_cpu_top5_table" border="0"></table>
					</div>
					<br>
					<div id="overview_server_memory_top5">
						<table id="overview_server_memory_top5_table" border="0"></table>
					</div>
					<br>
					<div id="overview_server_disk_top5">
						<table id="overview_server_disk_top5_table" border="0"></table>
					</div>
					<br>
					<div id="overview_server_network_top5">
						<table id="overview_server_network_top5_table" border="0"></table>
					</div>
					<br>
					<div id="overview_server_load_top5">
						<table id="overview_server_load_top5_table" border="0"></table>
					</div>
				</td>
			</tr>
		</table>	
	</div>
</body>
</html>