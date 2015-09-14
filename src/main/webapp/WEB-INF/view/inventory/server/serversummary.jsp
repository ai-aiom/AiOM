<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>
<script type="text/javascript">
	$(function(){
		$.parser.parse('#server_summary_main_body');
		
        // 基于准备好的dom，初始化echarts图表
        var cpuChart = echarts.init(document.getElementById('main_cpuRate'));
        var memoryChart = echarts.init(document.getElementById('main_memoryRate'));
        var diskChart = echarts.init(document.getElementById('main_diskRate'));
        
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
		
		
		
		$('#server_summary_info_panel').panel({
			title: '服务器详情',
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_info_edit').show();
					$('#server_summary_info_show').hide();
				}
			}]
		});
		
		//编辑服务器详情 取消
		$('#server_summary_info_edit_cancel').click(function(){
			$('#server_summary_info_show').show();
			$('#server_summary_info_edit').hide();
		});
		
		//编辑服务器详情 确认
		$('#server_summary_info_edit_submit').click(function(){
			if($('#server_summary_info_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_info_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateserverinfo.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改服务器详情成功！','info',function(){
							$('#server_summary_info_show_table tr:eq(1) td:nth-child(2)').text(data.ip);
							$('#server_summary_info_show_table tr:eq(3) td:nth-child(2)').text(data.alias);
							$('#server_summary_info_show_table tr:eq(8) td:nth-child(2)').text($('#server_monitor_type_edit').combobox('getText'));
							
							$('#server_summary_info_show').show();
							$('#server_summary_info_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_machine_panel').panel({
			title: '一体机'
		});

		$('#server_summary_site_panel').panel({
			title: '机架信息',
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_site_edit').show();
					$('#server_summary_site_show').hide();
				}
			}]
		});
		
		$('#server_edit_site').combobox({
			url: '<%=ctp %>/system/cabinet/list.action',
			valueField:'id',
		    textField:'name'
		});
		
		//编辑机架信息 取消
		$('#server_summary_site_edit_cancel').click(function(){
			$('#server_summary_site_show').show();
			$('#server_summary_site_edit').hide();
		});
		
		//编辑机架信息 确认
		$('#server_summary_site_edit_submit').click(function(){
			if($('#server_summary_site_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_site_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateserversite.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改机架信息成功！','info',function(){
							$('#server_summary_site_show_table tr:eq(0) td:nth-child(2)').text(data.properties.cabinetName);
							$('#server_summary_site_show_table tr:eq(1) td:nth-child(2)').text(data.site.size);
							$('#server_summary_site_show_table tr:eq(2) td:nth-child(2)').text(data.site.slot);
							
							$('#server_summary_site_show').show();
							$('#server_summary_site_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_asset_panel').panel({
			title: '资产信息',
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_asset_edit').show();
					$('#server_summary_asset_show').hide();
				}
			}]
		});
		
		//编辑资产信息 取消
		$('#server_summary_asset_edit_cancel').click(function(){
			$('#server_summary_asset_show').show();
			$('#server_summary_asset_edit').hide();
		});
		
		//编辑资产信息 确认
		$('#server_summary_asset_edit_submit').click(function(){
			if($('#server_summary_asset_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_asset_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateserverasset.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改资产信息成功！','info',function(){
							$('#server_summary_asset_show_table tr:eq(0) td:nth-child(2)').text(data.asset.manufacturer);
							$('#server_summary_asset_show_table tr:eq(1) td:nth-child(2)').text(data.asset.modal);
							$('#server_summary_asset_show_table tr:eq(2) td:nth-child(2)').text(data.asset.serialsNo);
							$('#server_summary_asset_show_table tr:eq(3) td:nth-child(2)').text(data.asset.contacter);
							$('#server_summary_asset_show_table tr:eq(4) td:nth-child(2)').text(data.asset.telephone);
							
							$('#server_summary_asset_show').show();
							$('#server_summary_asset_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_ssh_panel').panel({
			title: 'SSH信息',
			closed: true,
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_ssh_edit').show();
					$('#server_summary_ssh_show').hide();
				}
			}]
		});
		
		//编辑SSH信息 取消
		$('#server_summary_ssh_edit_cancel').click(function(){
			$('#server_summary_ssh_show').show();
			$('#server_summary_ssh_edit').hide();
		});
		
		//编辑SSH信息 确认
		$('#server_summary_ssh_edit_submit').click(function(){
			if($('#server_summary_ssh_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_ssh_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateserverssh.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改SSH信息成功！','info',function(){
							$('#server_summary_ssh_show_table tr:eq(0) td:nth-child(2)').text(data.ssh.host);
							$('#server_summary_ssh_show_table tr:eq(1) td:nth-child(2)').text(data.ssh.port);
							$('#server_summary_ssh_show_table tr:eq(2) td:nth-child(2)').text(data.ssh.username);
							
							$('#server_summary_ssh_show').show();
							$('#server_summary_ssh_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_ipmi_panel').panel({
			title: 'IPMI信息',
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_ipmi_edit').show();
					$('#server_summary_ipmi_show').hide();
				}
			}]
		});
		
		//编辑IPMI信息 取消
		$('#server_summary_ipmi_edit_cancel').click(function(){
			$('#server_summary_ipmi_show').show();
			$('#server_summary_ipmi_edit').hide();
		});
		
		//编辑IPMI信息 确认
		$('#server_summary_ipmi_edit_submit').click(function(){
			if($('#server_summary_ipmi_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_ipmi_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateserveripmi.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改IPMI信息成功！','info',function(){
							$('#server_summary_ipmi_show_table tr:eq(0) td:nth-child(2)').text(data.ipmi.host);
							$('#server_summary_ipmi_show_table tr:eq(1) td:nth-child(2)').text(data.ipmi.username);
							
							$('#server_summary_ipmi_show').show();
							$('#server_summary_ipmi_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_note_panel').panel({
			title: '备注',
			height: 100,
			tools: [{
				iconCls:'icon-edit-panel',
				handler:function(){
					$('#server_summary_note_panel_edit').show();
					$('#server_summary_note_panel_show').hide();
				}
			}]
		});
		
		//编辑备注信息 取消
		$('#server_summary_note_panel_edit_cancel').click(function(){
			$('#server_summary_note_panel_show').show();
			$('#server_summary_note_panel_edit').hide();
		});
		
		//编辑备注信息 确认
		$('#server_summary_note_panel_edit_submit').click(function(){
			if($('#server_summary_note_panel_edit_form').form('validate')) {
				$.messager.progress({text: '正在处理，请稍后...'});
				$('#server_summary_note_panel_edit_form').ajaxSubmit({
					url: '<%=ctp %>/inventory/server/updateservernote.action',
					type: 'POST',
					method: 'POST',
					dataType: 'json',
					success: function(data){
						$.messager.progress('close');
						$.messager.alert('成功','修改备注信息成功！','info',function(){
							$('#server_summary_note_panel_show_table tr:eq(0) td:nth-child(1)').text(data.asset.note);
							
							$('#server_summary_note_panel_show').show();
							$('#server_summary_note_panel_edit').hide();
						});
					}
				});
			}
		});
		
		$('#server_summary_perfermance_panel').panel({
			title: '使用率'
		});
		
		$('#server_summary_status_panel').panel({
			title: '运行状态'
		});
		
		var serverRuntimeStatus = '<s:property value="server.serverRuntime.status"/>';
		if (serverRuntimeStatus == 1){
			$('#server_runtime_status').text("正常");
		}else{
			$('#server_runtime_status').text("不可达");
		}
		
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
		var moduleName = MACHINE_SERVER_MOUDLE[moduleId] ? MACHINE_SERVER_MOUDLE[moduleId] : value;
		$('#server_moduleId').text(moduleName);
		
		var cpuNumValue = '<s:property value="server.serverRuntime.metrics.cpu_num.value"/>'; 
		var cpuSpeedValue = '<s:property value="server.serverRuntime.metrics.cpu_speed.value"/>'; 
		var cpuSpeedUnit = '<s:property value="server.serverRuntime.metrics.cpu_speed.unit"/>';
		if (cpuSpeedUnit == "MHz"){
			cpuNumValue = Math.round(cpuNumValue);
			cpuSpeedValue = Math.round(cpuSpeedValue);
			$('#cpu_num').text(cpuNumValue + " x " + cpuSpeedValue + " " + cpuSpeedUnit);
		}
		
		var memoryTotalValue = '<s:property value="server.serverRuntime.metrics.mem_total.value"/>';   
		var memoryTotalUnit = '<s:property value="server.serverRuntime.metrics.mem_total.unit"/>';
		if (memoryTotalUnit == "KB"){
			memoryTotalValue = Math.round(memoryTotalValue / 1024);
			$('#memory_size').text(memoryTotalValue + "M");
		}else{
			$('#memory_size').text(memoryTotalValue + memoryTotalUnit);
		}
		
		var swapFreeValue = '<s:property value="server.serverRuntime.metrics.swap_free.value"/>'; 
		var swapFreeUnit = '<s:property value="server.serverRuntime.metrics.swap_free.unit"/>';
		if (swapFreeUnit == "KB"){
			swapFreeValue = Math.round(swapFreeValue/1024);
			$('#swap_free').text(swapFreeValue + "M");
		}else{
			$('#swap_free').text(swapFreeValue + swapFreeUnit);
		}
		
		var procRun = '<s:property value="server.serverRuntime.metrics.proc_run.value"/>';
		var procTotal = '<s:property value="server.serverRuntime.metrics.proc_total.value"/>';
		if (procRun != "" && procTotal != ""){
			procRun = Math.round(procRun);
			procTotal = Math.round(procTotal);
			$('#server_proc').text(procRun + " / " + procTotal);
		}
	})
</script>

<div id="server_summary_main_body">
	<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
		<s:set name="serverMonitorType" value="%{server.monitorType}" />
		<s:set name="serverStatus" value="%{server.serverRuntime.status}" />
		<tr>
			<td width="40%" style="padding-right: 5px;">
				<div id="server_summary_info_panel">
					<div id="server_summary_info_show" style="display: block">
						<table id="server_summary_info_show_table" class="info_grid">
							<tr>
								<td width=100><span>状态</span></td>
								<td><div id="server_runtime_status"></div></td>
							</tr>
							<tr>
								<td><span>IP</span></td>
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
					<div id="server_summary_info_edit" style="display: none">
						<form id="server_summary_info_edit_form">
							<table class="info_grid">
								<tr>
									<td><span>IP</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['blank','maxLength[128]']" name="server.ip" value="<s:property value="server.ip"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>别名</span></td>
									<td><input class="easyui-textbox" data-options="" name="server.alias" value="<s:property value="server.alias"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>监控类型</span></td>
									<td>
										<input id="server_monitor_type_edit" class="easyui-combobox" data-options="editable:false,
											valueField: 'label',
											textField: 'value',
											data: [{
												label: '1',
												value: 'ICMP'
											},{
												label: '2',
												value: 'SSH'
											},{
												label: '3',
												value: 'AGENT'
											}]" name="server.monitorType" value="<s:property value="server.monitorType"/>" style="width: 150px">
									</td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_info_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_info_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
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
				<div id="server_summary_site_panel">
					<div id="server_summary_site_show" style="display: block">
						<table id="server_summary_site_show_table" class="info_grid">
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
					<div id="server_summary_site_edit" style="display: none">
						<form id="server_summary_site_edit_form">
							<table class="info_grid">
								<tr>
									<td width=100><span>机架</span></td>
									<td><input id="server_edit_site" class="easyui-textbox" data-options="editable:false" name="site.rack" value="<s:property value="server.site.rack"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>大小</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="site.size" value="<s:property value="server.site.size"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>槽位</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="site.slot" value="<s:property value="server.site.slot"/>" style="width: 150px"></td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_site_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_site_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
				</div>
				<br/>
				<div id="server_summary_asset_panel">
					<div id="server_summary_asset_show" style="display: block">
						<table id="server_summary_asset_show_table" class="info_grid">
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
					<div id="server_summary_asset_edit" style="display: none">
						<form id="server_summary_asset_edit_form">
							<table class="info_grid">
								<tr>
									<td width=100><span>厂商</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="asset.manufacturer" value="<s:property value="server.asset.manufacturer"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>型号</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="asset.modal" value="<s:property value="server.asset.modal"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>序列号</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="asset.serialsNo" value="<s:property value="server.asset.serialsNo"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>联系人</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="asset.contacter" value="<s:property value="server.asset.contacter"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>联系电话</span></td>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[40]']" name="asset.telephone" value="<s:property value="server.asset.telephone"/>" style="width: 150px"></td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_asset_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_asset_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
				</div>
				<br/>
				<div id="server_summary_ipmi_panel">
					<div id="server_summary_ipmi_show" style="display: block">
						<table id="server_summary_ipmi_show_table" class="info_grid">
							<tr>
								<td width=100><span>主机</span></td>
								<td><s:property value="server.ipmi.host"/></td>
							</tr>
							<tr>
								<td><span>账号</span></td>
								<td><s:property value="server.ipmi.username"/></td>
							</tr>
						</table>
					</div>
					<div id="server_summary_ipmi_edit" style="display: none">
						<form id="server_summary_ipmi_edit_form">
							<table class="info_grid">
								<tr>
									<td width=100><span>主机</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['maxLength[40]']" name="ipmi.host" value="<s:property value="server.ipmi.host"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>账号</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['maxLength[40]']" name="ipmi.username" value="<s:property value="server.ipmi.username"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>密码</span></td>
									<td><input class="easyui-textbox" type="password" data-options="required:true,validType:['maxLength[40]']" name="ipmi.password" value="<s:property value="server.ipmi.password"/>" style="width: 150px"></td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_ipmi_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_ipmi_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
				</div>
				<br/>
				<div id="server_summary_ssh_panel">
					<div id="server_summary_ssh_show" style="display: block">
						<table id="server_summary_ssh_show_table" class="info_grid">
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
						</table>
					</div>
					<div id="server_summary_ssh_edit" style="display: none">
						<form id="server_summary_ssh_edit_form">
							<table class="info_grid">
								<tr>
									<td width=100><span>主机</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['maxLength[40]']" name="ssh.host" value="<s:property value="server.ssh.host"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>端口</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['maxLength[12]']" name="ssh.port" value="<s:property value="server.ssh.port"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>账号</span></td>
									<td><input class="easyui-textbox" data-options="required:true,validType:['maxLength[40]']" name="ssh.username" value="<s:property value="server.ssh.username"/>" style="width: 150px"></td>
								</tr>
								<tr>
									<td><span>密码</span></td>
									<td><input class="easyui-textbox" type="password" data-options="required:true,validType:['maxLength[40]']" name="ssh.password" value="<s:property value="server.ssh.password"/>" style="width: 150px"></td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_ssh_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_ssh_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
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
								system <s:property value="server.serverRuntime.metrics.cpu_system.value"/> <s:property value="server.serverRuntime.metrics.cpu_system.unit"/>&nbsp&nbsp&nbsp   
								user <s:property value="server.serverRuntime.metrics.cpu_user.value"/> <s:property value="server.serverRuntime.metrics.cpu_user.unit"/>&nbsp&nbsp&nbsp    
								wio <s:property value="server.serverRuntime.metrics.cpu_wio.value"/> <s:property value="server.serverRuntime.metrics.cpu_wio.unit"/>   
								</s:if>
							</td>
						</tr>
						<tr>
							<td><span>负载</span></td>
							<td>
								<s:property value="server.serverRuntime.metrics.load_one.value"/>&nbsp&nbsp&nbsp         
								<s:property value="server.serverRuntime.metrics.load_five.value"/>&nbsp&nbsp&nbsp        
							    <s:property value="server.serverRuntime.metrics.load_fifteen.value"/>       
							</td>
						</tr>
						<tr>
							<td><span>交换分区</span></td>
							<td><div id="swap_free"></div></td>
						</tr>
						<tr>
							<td><span>进程</span></td>
							<td><div id="server_proc"></div></td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_note_panel">
					<div id="server_summary_note_panel_show" style="display: block">
						<table id="server_summary_note_panel_show_table">
							<tr>
								<td><s:property value="server.asset.note"/></td>
							</tr>
						</table>
					</div>
					<div id="server_summary_note_panel_edit" style="display: none">
						<form id="server_summary_note_panel_edit_form">
							<table>
								<tr>
									<td><input class="easyui-textbox" data-options="validType:['maxLength[250]']" name="note" value="<s:property value="server.asset.note"/>" style="width: 650px"></td>
								</tr>
							</table>
							<input type="hidden" name="id" value="<s:property value="#parameters.serverId"/>">
						</form>
						<div style="text-align: right;padding: 5px">
							<a id="server_summary_note_panel_edit_submit" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">确定</a>  
							<a id="server_summary_note_panel_edit_cancel" href="javascript: void(0)" class="easyui-linkbutton" style="width: 70px;">取消</a>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
