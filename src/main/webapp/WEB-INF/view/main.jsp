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
	<script type="text/javascript">
		function getCtp()
		{
			return '<%=ctp %>';
		}
		
		$(function(){
			$('#main_select_machine').combobox({
				width: 200,
				onSelect: function(param) {
					window.location.href = "<%=ctp %>/main.action?machineId=" + param.value;
				}
			});
			$('#main_select_machine').combobox('setValue', '<s:property value="#session.machine.id"/>');
			
			$('#main_menu').find('li').each(function(){
				if($(this).attr('type') == '0' || $(this).attr('type') == '<s:property value="#session.machine.type"/>') {
					$(this).css('display', 'block');
				}
			});
			
			$('#main_menu').find('li').click(function(){
				var link = $(this).attr('link');
				if(link) {
					window.main_frame.location.href = link;
				}
			});
			
			$('#main_menu li:eq(0)').click();
			
			// 菜单控制
			$('#main_button_show_user_menu').click(function(){
				$('#main_user_menu').css('display', 'block');
			});
			
			$('#main_user_menu').mouseleave(function(){
				$(this).css('display', 'none');
			});
			
			$('#user_update_own_password').click(function(){
				window.main_frame.location.href = '<%=ctp %>/system/user/touserupdateownpassowrd.action';
			});
			
			$('#main_user_menu_exit').click(function(){
				$.messager.confirm('确认退出', '确认退出当前账号？', function(r){
					if (r){
						window.location.href = '<%=ctp %>/logout.action';
					}
				});
			});
			
			$('#main_user_menu_system').click(function(){
				window.main_frame.location.href = "<%=ctp %>/system/main.action";
			});
		});
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:60px;">
		<div id="main_header">
			<div style="float: left; width: 200px;">
				<img src="<%=ctp %>/images/main/icon_logo.png" style="margin: 20px 0px 0px 10px;">
			</div>
			<div style="float: right; display: inline-block;">
				<div style="margin-top: 30px; margin-right: 20px; color: #FFFFFF;">
					<span>
						<select id="main_select_machine">
							<s:iterator value="machines" var="machine">
								<option value="<s:property value='#machine.id' />"><s:property value="#machine.name" /></option>
							</s:iterator>
						</select>
					</span>
					<span style="margin-left: 10px;">
						<span>欢迎</span>
						<span>
							<a id="main_button_show_user_menu" href="javascript: void(0)" style="color: #FFFFFF;">
								<span><s:property value="#session.user.account" /></span>
								<img src="<%=ctp %>/images/main/icon_sj2.png" style="vertical-align: middle;">
							</a>
						</span>
					</span>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'west', border: false" style="width:60px; overflow: hidden;">
		<div id="main_menu">
			<ul>
				<li type="0" link="<%=ctp %>/overview/main.action">
					<div><img src="<%=ctp %>/images/main/icon_summary.png"></div>
					<div>概览</div>
				</li>
				<li type="0" link="<%=ctp %>/inventory/main.action">
					<div><img src="<%=ctp %>/images/main/icon_inventory.png"></div>
					<div>资源清单</div>
				</li>
				<li type="0" link="<%=ctp %>/alert/main.action">
					<div><img src="<%=ctp %>/images/main/icon_alert.png"></div>
					<div>告警</div>
				</li>
				<li type="2" link="<%=ctp %>/apps/adb/main.action">
					<div><img src="<%=ctp %>/images/main/icon_database.png"></div>
					<div>数据库</div>
				</li>
				<li type="1" link="<%=ctp %>/apps/ocdp/main.action">
					<div><img src="<%=ctp %>/images/main/icon_database.png"></div>
					<div>OCDP</div>
				</li>
			</ul>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="overflow: hidden;">
		<iframe id="main_frame" name="main_frame" src="" width="100%" height="100%" frameborder="0"></iframe>
	</div>
	<div id="main_user_menu">
		<span></span>
		<div id="user_update_own_password">修改密码</div>
		<div id="main_user_menu_system">系统设置</div>
		<div id="main_user_menu_exit">退出</div>
	</div>
</body>
</html>