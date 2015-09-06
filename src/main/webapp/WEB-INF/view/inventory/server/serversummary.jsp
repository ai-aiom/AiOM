<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>
<script type="text/javascript">
require.config({
    paths: {
        echarts: '<%=ctp %>/js/echarts/dist'
    }
});

require(
    [
        'echarts',
        'echarts/chart/gauge' 
    ],
    function (ec) {
        // 基于准备好的dom，初始化echarts图表
        var cpuChart = ec.init(document.getElementById('main_cpuRate'));
        var memoryChart = ec.init(document.getElementById('main_memoryRate'));
        var diskChart = ec.init(document.getElementById('main_diskRate'));
        
        var option = {
        	    tooltip : {
        	        formatter: "{a} <br/>{b} : {c}%"
        	    },
        	    series : [
        	        {
        	            name:'使用率',
        	            type:'gauge',
        	            center : ['50%', '50%'],    // 默认全局居中
        	            radius : [0, '75%'],
        	            startAngle: 140,
        	            endAngle : -140,
        	            min: 0,                     // 最小值
        	            max: 100,                   // 最大值
        	            precision: 0,               // 小数精度，默认为0，无小数点
        	            splitNumber: 10,            // 分割段数，默认为5
        	            axisLine: {            // 坐标轴线
        	                show: true,        // 默认显示，属性show控制显示与否
        	                lineStyle: {       // 属性lineStyle控制线条样式
        	                    color: [[0.8, 'skyblue'],[1, '#ff4500']], 
        	                    width: 30
        	                }
        	            },
        	            axisTick: {            // 坐标轴小标记
        	                show: true,        // 属性show控制显示与否，默认不显示
        	                splitNumber: 5,    // 每份split细分多少段
        	                length :8,         // 属性length控制线长
        	                lineStyle: {       // 属性lineStyle控制线条样式
        	                    color: '#eee',
        	                    width: 1,
        	                    type: 'solid'
        	                }
        	            },
        	            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
        	                show: false,
        	                formatter: function(v){
        	                    switch (v+''){
        	                        case '10': return '弱';
        	                        case '30': return '低';
        	                        case '60': return '中';
        	                        case '90': return '高';
        	                        default: return '';
        	                    }
        	                },
        	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
        	                    color: '#333'
        	                }
        	            },
        	            splitLine: {           // 分隔线
        	                show: true,        // 默认显示，属性show控制显示与否
        	                length :30,         // 属性length控制线长
        	                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
        	                    color: '#eee',
        	                    width: 2,
        	                    type: 'solid'
        	                }
        	            },
        	            pointer : {
        	                length : '80%',
        	                width : 8,
        	                color : 'auto'
        	            },
        	            title : {
        	                show : true,
        	                offsetCenter: ['-65%', -10],       // x, y，单位px
        	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
        	                    color: '#333',
        	                    fontSize : 15
        	                }
        	            },
        	            detail : {
        	                show : true,
        	                backgroundColor: 'rgba(0,0,0,0)',
        	                borderWidth: 0,
        	                borderColor: '#ccc',
        	                width: 100,
        	                height: 40,
        	                offsetCenter: ['-60%', 10],       // x, y，单位px
        	                formatter:'{value}%',
        	                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
        	                    color: 'auto',
        	                    fontSize : 30
        	                }
        	            },
        	            data:[{value: '', name: ''}]
        	        }
        	    ]
        };

        // 为echarts对象加载数据 
        var cpuRate = '<s:property value="server.properties.cpuRate"/>';
        if (cpuRate == "N/A"){
        	cpuRate = 0;
        }
      	option.series[0].data[0].value = cpuRate;
      	option.series[0].data[0].name = 'CPU';
        cpuChart.setOption(option);
        
        var memoryRate = '<s:property value="server.properties.memoryRate"/>';
        if (memoryRate == "N/A"){
        	memoryRate = 0;
        }
        option.series[0].data[0].value = memoryRate;
      	option.series[0].data[0].name = '内存';
        memoryChart.setOption(option);
        
        var diskRate = '<s:property value="server.properties.diskRate"/>';
        if (diskRate == "N/A"){
        	diskRate = 0;
        }
        option.series[0].data[0].value = diskRate;
      	option.series[0].data[0].name = '硬盘';
        diskChart.setOption(option);
    }
);
</script>
<script type="text/javascript">
	$(function(){
		
		$('#server_summary_info_panel').panel({
			title: '服务器详情',
			tools: [{
				iconCls:'icon-edit',
				handler:function(){alert('edit')}
			}]
		});
		
		$('#server_summary_machine_panel').panel({
			title: '一体机'
		});
		
		$('#server_summary_asset_panel').panel({
			title: '资产信息'
		});
		
		$('#server_summary_ssh_panel').panel({
			title: 'SSH信息'
		});
		
		$('#server_summary_ipmi_panel').panel({
			title: 'IPMI信息'
		});
		
		$('#server_summary_cabinet_panel').panel({
			title: '机架信息'
		});
		
		$('#server_summary_note_panel').panel({
			title: '备注',
			height: 100
		});
		
		$('#server_summary_perfermance_panel').panel({
			title: '使用率'
		});
		
		$('#server_summary_status_panel').panel({
			title: '运行状态'
		});
		
		var monitorType = <s:property value="server.monitorType"/>;
		switch (monitorType) {
		case 1:
			$('#server_monitorType').text("ICMP");
			break;
		case 2:
			$('#server_monitorType').text("SSH");
			break;
		case 3:
			$('#server_monitorType').text("AGENT");
			break;
		default:
			$('#server_monitorType').text("");
			break;
		}
		
		var machineId = <s:property value="server.properties.machineId"/>;
		switch (machineId) {
		case 1:
			$('#server_machineId').text("大数据通用一体机");
			break;
		case 2:
			$('#server_machineId').text("ADB数据库一体机");
			break;
		case 3:
			$('#server_machineId').text("ORACLE数据库一体机");
			break;
		case 4:
			$('#server_machineId').text("DACP数据资产管理一体机");
			break;
		default:
			$('#server_machineId').text("");
			break;
		}
		
		var moduleId = <s:property value="server.properties.moduleId"/>;
		switch (moduleId) {
		case 1:
			$('#server_moduleId').text("NAMENODE");
			break;
		case 2:
			$('#server_moduleId').text("DATANODE");
			break;
		default:
			$('#server_moduleId').text("");
			break;
		}
		
		var swapFreeValue = '<s:property value="server.serverRuntime.metrics.swap_free.value"/>'; 
		var swapFreeUnit = '<s:property value="server.serverRuntime.metrics.swap_free.unit"/>';
		if (swapFreeUnit == "KB"){
			swapFreeValue = Math.round(swapFreeValue/1024);
			$('#swap_free').text(swapFreeValue + "M");
		}else{
			$('#swap_free').text(swapFreeValue + swapFreeUnit);
		}
		
		var cpuNumValue = '<s:property value="server.serverRuntime.metrics.cpu_num.value"/>'; 
		var cpuNumUnit = '<s:property value="server.serverRuntime.metrics.cpu_num.unit"/>';
		if (cpuNumUnit == "CPUs"){
			cpuNumValue = Math.round(cpuNumValue);
		}
		$('#cpu_num').text(cpuNumValue + " " + cpuNumUnit);
		
		var memoryTotalValue = '<s:property value="server.serverRuntime.metrics.mem_total.value"/>';   
		var memoryTotalUnit = '<s:property value="server.serverRuntime.metrics.mem_total.unit"/>';
		if (memoryTotalUnit == "KB"){
			memoryTotalValue = Math.round(memoryTotalValue / 1024);
			$('#memory_size').text(memoryTotalValue + "M");
		}else{
			$('#memory_size').text(memoryTotalValue + memoryTotalUnit);
		}
		
		/* var monitorType = <s:property value="server.monitorType"/>;
		var status = <s:property value="server.serverRuntime.status"/>; */
	})
</script>

<div>
	<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
		<s:set name="serverMonitorType" value="%{server.monitorType}" />
		<s:set name="serverStatus" value="%{server.serverRuntime.status}" />
		<tr>
			<td width="40%" style="padding-right: 5px;">
				<div id="server_summary_info_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>IP</span></td>
							<td><s:property value="server.ip"/></td>
						</tr>
						<tr>
							<td><span>主机名</span></td>
							<td><s:property value="server.hostname"/></td>
						</tr>
						<tr>
							<td><span>别名</span></td>
							<td><s:property value="server.alias"/></td>
						</tr>
						<tr>
							<td><span>CPU</span></td>
							<td><div id="cpu_num"></div></td>
						</tr>
						<tr>
							<td><span>内存</span></td>
							<td><div id="memory_size"></div></td>
						</tr>
						<tr>
							<td><span>硬盘</span></td>
							<td><s:property value="server.serverRuntime.metrics.disk_total.value"/>   <s:property value="server.serverRuntime.metrics.disk_total.unit"/></td>
						</tr>
						<tr>
							<td><span>操作系统</span></td>
							<td><s:property value="server.serverRuntime.metrics.os_name.value"/>  <s:property value="server.serverRuntime.metrics.os_release.value"/></td>
						</tr>
						<tr>
							<td><span>监控类型</span></td>
							<td><div id="server_monitorType"></div></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_machine_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>一体机</span></td>
							<td><div id="server_machineId"></div></td>
						</tr>
						<tr>
							<td><span>模块</span></td>
							<td><div id="server_moduleId"></div></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_asset_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>厂商</span></td>
							<td><s:property value="server.asset.manufacturer"/></td>
						</tr>
						<tr>
							<td><span>型号</span></td>
							<td><s:property value="server.asset.modal"/></td>
						</tr>
						<tr>
							<td><span>序列号</span></td>
							<td><s:property value="server.asset.serialsNo"/></td>
						</tr>
						<tr>
							<td><span>联系人</span></td>
							<td><s:property value="server.asset.contacter"/></td>
						</tr>
						<tr>
							<td><span>联系电话</span></td>
							<td><s:property value="server.asset.telephone"/></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_ssh_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>主机</span></td>
							<td><s:property value="server.ssh.host"/></td>
						</tr>
						<tr>
							<td><span>端口</span></td>
							<td><s:property value="server.ssh.port"/></td>
						</tr>
						<tr>
							<td><span>账号</span></td>
							<td><s:property value="server.ssh.username"/></td>
						</tr>
						<%-- <tr>
							<td><span>密码</span></td>
							<td><s:property value="server.ssh.password"/></td>
						</tr> --%>
					</table>
				</div>
				<br/>
				<div id="server_summary_ipmi_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>主机</span></td>
							<td><s:property value="server.ipmi.host"/></td>
						</tr>
						<tr>
							<td><span>账号</span></td>
							<td><s:property value="server.ipmi.username"/></td>
						</tr>
						<%-- <tr>
							<td><span>密码</span></td>
							<td><s:property value="server.ipmi.password"/></td>
						</tr> --%>
					</table>
				</div>
				<br/>
				<div id="server_summary_cabinet_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>机架</span></td>
							<td><s:property value="server.properties.cabinetName"/></td>
						</tr>
						<tr>
							<td><span>大小</span></td>
							<td><s:property value="server.site.size"/></td>
						</tr>
						<tr>
							<td><span>槽位</span></td>
							<td><s:property value="server.site.slot"/></td>
						</tr>
					</table>
				</div>
			</td>
			<td style="vertical-align: top; padding-left: 5px;">
				<div id="server_summary_perfermance_panel">
					<table>
						<tr>
							<td><div id="main_cpuRate" style="height:270px;width:222px"></div></td>
							<td><div id="main_memoryRate" style="height:270px;width:222px"></div></td>
							<td><div id="main_diskRate" style="height:270px;width:222px"></div></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_status_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>启动时间</span></td>
							<td><s:property value="server.properties.boottime"/></td>
						</tr>
						<tr>
							<td><span>运行时常</span></td>
							<td><s:property value="server.properties.runtime"/></td>
						</tr>
						<tr>
							<td><span>CPU使用率</span></td>
							<td>
								<s:if test="#serverMonitorType == 3 && #serverStatus == 1">
								系统   <s:property value="server.serverRuntime.metrics.cpu_system.value"/>   <s:property value="server.serverRuntime.metrics.cpu_system.unit"/>  
								用户   <s:property value="server.serverRuntime.metrics.cpu_user.value"/>   <s:property value="server.serverRuntime.metrics.cpu_user.unit"/>   
								等待IO   <s:property value="server.serverRuntime.metrics.cpu_wio.value"/>   <s:property value="server.serverRuntime.metrics.cpu_wio.unit"/>   
								</s:if>
							</td>
						</tr>
						<tr>
							<td><span>负载</span></td>
							<td>
								<s:if test="#serverMonitorType == 3 && #serverStatus == 1">
								1秒负载   <s:property value="server.serverRuntime.metrics.load_one.value"/>         
								5秒负载   <s:property value="server.serverRuntime.metrics.load_five.value"/>          
								15秒负载   <s:property value="server.serverRuntime.metrics.load_fifteen.value"/>         
								</s:if>
							</td>
						</tr>
						<tr>
							<td><span>交换分区</span></td>
							<td><div id="swap_free"></div></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_note_panel">
					<s:property value="server.asset.note"/>
				</div>
			</td>
		</tr>
	</table>
</div>