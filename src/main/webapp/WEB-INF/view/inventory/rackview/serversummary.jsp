<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>

<script type="text/javascript">
	$(function(){
		var monitorType = '<s:property value="server.monitorType" />';
		var status = '<s:property value="server.serverRuntime.status" />';
		
		var $summaryTable = $("#rackview_server_summary_<s:property value='server.id' />");
		
		// 状态
		if(status == '1') {
			$summaryTable.find('.rackview_server_summary_status').find('span').text('正常');
			$summaryTable.find('.rackview_server_summary_status').find('img').attr('src', '<%=ctp %>/images/device/status1.gif');
		}
		else {
			$summaryTable.find('.rackview_server_summary_status').find('span').text(monitorType == '1' ? '监控不可达' : '无监控心跳');
			$summaryTable.find('.rackview_server_summary_status').find('img').attr('src', '<%=ctp %>/images/device/status0.gif');
		}
		
		// cpu使用率
		var cpuRate = '<s:property value="server.properties.cpuRate" />';
		if (cpuRate != 'N/A') {
			$summaryTable.find('.rackview_server_summary_cpurate').find('.percentage').find('div').css('width', cpuRate + '%');
			$summaryTable.find('.rackview_server_summary_cpurate').find('.percentage').find('span').text(cpuRate + '%');
		} else {
			$summaryTable.find('.rackview_server_summary_cpurate').find('.percentage').find('span').text('N/A');
		}
		
		// memory使用率
		var memoryRate = '<s:property value="server.properties.memoryRate" />';
		if (memoryRate != 'N/A') {
			$summaryTable.find('.rackview_server_summary_memoryrate').find('.percentage').find('div').css('width', memoryRate + '%');
			$summaryTable.find('.rackview_server_summary_memoryrate').find('.percentage').find('span').text(memoryRate + '%');
		} else {
			$summaryTable.find('.rackview_server_summary_memoryrate').find('.percentage').find('span').text('N/A');
		}
		
		// 磁盘使用率
		var diskRate = '<s:property value="server.properties.diskRate" />';
		if (diskRate != 'N/A') {
			$summaryTable.find('.rackview_server_summary_diskrate').find('.percentage').find('div').css('width', diskRate + '%');
			$summaryTable.find('.rackview_server_summary_diskrate').find('.percentage').find('span').text(diskRate + '%');
		} else {
			$summaryTable.find('.rackview_server_summary_diskrate').find('.percentage').find('span').text('N/A');
		}
		
		// 监控类型
		var monitorType = '<s:property value="server.monitorType" />';
		if(monitorType == '1') {
			$summaryTable.find('.rackview_server_summary_monitortype').text('ICMP');
		} else if(monitorType == '2') {
			$summaryTable.find('.rackview_server_summary_monitortype').text('SSH');
		} else if(monitorType == '3') {
			$summaryTable.find('.rackview_server_summary_monitortype').text('AGENT');
		}
	});
</script>

<table id="rackview_server_summary_<s:property value='server.id' />" class="info_grid">
	<tr>
		<td width=100><span>状态</span></td>
		<td>
			<div class="rackview_server_summary_status">
				<img src="" style="vertical-align: middle;" /><span></span>
			</div>
		</td>
	</tr>
	<tr>
		<td><span>IP</span></td>
		<td><s:property value="server.ip" /></td>
	</tr>
	<tr>
		<td><span>主机名</span></td>
		<td><s:property value="server.hostname" /></td>
	</tr>
	<tr>
		<td><span>别名</span></td>
		<td><s:property value="server.alias" /></td>
	</tr>
	<tr>
		<td><span>CPU</span></td>
		<td>
			<div class="rackview_server_summary_cpurate">
				<div class="percentage">
					<div></div><span></span>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td><span>内存</span></td>
		<td>
			<div class="rackview_server_summary_memoryrate">
				<div class="percentage">
					<div></div><span></span>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td><span>磁盘</span></td>
		<td>
			<div class="rackview_server_summary_diskrate">
				<div class="percentage">
					<div></div><span></span>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td><span>操作系统</span></td>
		<td><s:property
				value="server.serverRuntime.metrics.os_name.value" /> <s:property
				value="server.serverRuntime.metrics.os_release.value" /></td>
	</tr>
	<tr>
		<td><span>监控类型</span></td>
		<td><div class="rackview_server_summary_monitortype"></div></td>
	</tr>
</table>
</div>