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
	<link rel="stylesheet" type="text/css" href="<%=ctp %>/css/aiom/default/rack.css">
	<script type="text/javascript" src="<%=ctp %>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=ctp %>/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			$('[rackId]').each(function(){
				var size = parseInt($(this).attr('rackSize'));
				for(var i = size; i > 0; i--) {
					var $tr = $('<tr></tr>').attr('index', i);
					$tr.append($('<td/>').addClass('leftside').text(i));
					$tr.append($('<td/>').addClass('center'));
					$tr.append($('<td/>').addClass('rightside').text(i));
					$(this).append($tr);
				}
			});
			
			$('div[rack]').each(function(){
				if($(this).attr('slot') && $(this).attr('size')) {
					var slot = parseInt($(this).attr('slot'));
					var size = parseInt($(this).attr('size'));
					
					var $rack = $('[rackId=' + $(this).attr('rack') + ']');
					var $serverContainerTD = null;
					
					if(size > 1) {
						$serverContainerTD = $rack.find('[index=' + (slot + size - 1) + ']').find('td:eq(1)');
						$serverContainerTD.attr('rowspan', size);
						for(var i = 0; i < (size - 1); i++) {
							$rack.find('[index=' + (slot + i) + ']').find('td:eq(1)').remove();
						}
					} else {
						$serverContainerTD = $rack.find('[index=' + slot + ']').find('td:eq(1)');
					}
					
					$serverContainerTD.append($(this));
				}
			});
			
			$('div[rack]').find('a').tooltip({
				position: 'right',
				content: '<div class="server_summary_tooltip"></div>',
				//hideEvent: 'click',
				onShow: function(){
					var serverId = $(this).attr('serverId');
					var $content = $(this).tooltip('tip').find('.server_summary_tooltip');
					if(!$content.html()) {
						$content.load('<%=ctp %>/inventory/rackview/loadserversummary.action?server.id=' + serverId);
					}
				}
			});
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table>
			<tr>
				<s:iterator value="cabinets" var="rack">
					<td style="padding: 0px 10px 90px 10px; text-align: center;" valign="bottom">
						<table class="racktable" rackId="<s:property value='#rack.id'/>" rackSize="<s:property value='#rack.size'/>">
							<tr>
								<td class="leftside"></td>
								<td class="center"><s:property value='#rack.name'/></td>
								<td class="rightside"></td>
							</tr>
						</table>
					</td>
				</s:iterator>	
			</tr>
		</table>	
	</div>
	<div id="servers">
		<s:iterator value="servers" var="server">
			<div class="server_<s:property value='#server.site.size'/>u" size="<s:property value='#server.site.size'/>" slot="<s:property value='#server.site.slot'/>" rack="<s:property value='#server.site.rack'/>">
				<a href="javascript:void(0)" serverId="<s:property value='#server.id'/>"></a>
			</div>
		</s:iterator>
	</div>
</body>
</html>