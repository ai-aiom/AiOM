<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>

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
	})
</script>

<div>
	<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
		<tr>
			<td width="40%" style="padding-right: 5px;">
				<div id="server_summary_info_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>IP</span></td>
							<td>172.16.102.11</td>
						</tr>
						<tr>
							<td><span>主机名</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>别名</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>CPU</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>内存</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>硬盘</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>操作系统</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>监控类型</span></td>
							<td>sdf</td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_machine_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>一体机</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>模块</span></td>
							<td>sdf</td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_asset_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>厂商</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>型号</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>序列号</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>联系人</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>联系电话</span></td>
							<td>sdf</td>
						</tr>
					</table>
				</div>
				<br/>
				<div id="server_summary_note_panel">
					asdasf
				</div>
			</td>
			<td style="vertical-align: top; padding-left: 5px;">
				<div id="server_summary_perfermance_panel">
					<s:property value="#parameters.serverId" />
				</div>
				<br/>
				<div id="server_summary_status_panel">
					<table class="info_grid">
						<tr>
							<td width=100><span>启动时间</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>运行时常</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>CPU使用率</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>负载</span></td>
							<td>sdf</td>
						</tr>
						<tr>
							<td><span>交换分区</span></td>
							<td></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>
