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
		
		$(function(){
			$('#user_main_grid').datagrid({    
			    url:'<%=ctp %>/system/user/list.action',
			    fit: true,
			    fitColumns: true,
			    columns:[[
			        {field: 'account',title:'帐号', width: 100, align: 'center'},
			        {field: 'name', title: '名称', width: 100, align: 'center'},
			        {field: 'description', title: '描述', width: 300, align: 'center'},
			        {field: 'email', title: '邮箱', width: 200, align: 'center'},
			        {field: 'state', title: '状态', width: 100, align: 'center', formatter: function(value, row, index){
			        	return value == 1 ? '正常' : '未知';
			        }},
			        {field: 'id', title: '操作', width: 100, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation userid="' + value + '" style="text-align: left"></div>';
			        }}
			    ]],
			    onLoadSuccess: function(data){
			    	$('[grid_operation]').each(function(){
			    		if ($(this).attr('userid') != 1 && $(this).attr('userid') != 2){
				    		var $editButton = $('<span></span>').addClass('operation_icon_black');
				    		$editButton.css('background-position', '-64px -112px');
				    		$editButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
				    		$editButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
				    		$editButton.appendTo($(this));
				    		
				    		var $deleteButton = $('<span></span>').addClass('operation_icon_black');
				    		$deleteButton.css('background-position', '-176px -96px');
				    		$deleteButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
				    		$deleteButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
				    		$deleteButton.appendTo($(this));
				    		
				    		var $editPasswordButton = $('<span></span>').addClass('operation_icon_black');
				    		$editPasswordButton.css('background-position', '-176px -112px');
				    		$editPasswordButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
				    		$editPasswordButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
				    		$editPasswordButton.appendTo($(this));
				    		
				    		$editButton.click(function(){
				    			var userIdforEdit = $(this).parent().attr('userid');
				    			window.location.href = '<%=ctp %>/system/user/touserupdate.action?id=' + userIdforEdit;
				    		});
				    		
				    		$editPasswordButton.click(function(){
				    			var userIdforEdit = $(this).parent().attr('userid');
				    			window.location.href = '<%=ctp %>/system/user/touserupdatepassword.action?id=' + userIdforEdit;
				    		});
				    		
				    		$deleteButton.click(function(){
				    			var userIdforDelete = $(this).parent().attr('userid');
				    			if (userIdforDelete == 1){
				    				$.messager.alert('失败','admin账号不允许删除！','warning');
				    			}else{
					    			$.messager.confirm('确认删除', '确认要删除此账号', function(r){
					    				if (r){
					    					$.messager.progress({text: '正在处理，请稍后...'});
					    					$.ajax({
					    						url: '<%=ctp %>/system/user/deleteuser.action?id=' + userIdforDelete,
					    						dataType: 'json',
					    						success: function(){
					    							$.messager.progress('close');
					    							$('#user_main_grid').datagrid('reload');
					    						}
					    					});
					    				}
					    			});
				    			}
				    		});
			    		}
			    		
			    	});
			    },
				onClickRow: function (rowIndex, rowData) {
	                $(this).datagrid('unselectRow', rowIndex);
	            }
			});
		});
		
	</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north', border: false" style="height:50px;">
		<div class="content_title">
			<div>用户管理</div>
			<div class="content_title_operation">
				<a href="touseradd.action" style="color: #000000">
					<span class="operation_icon_black" style="background-position: 0px -190px"></span>
					<span>添加用户</span>
				</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="user_main_grid"></table>
	</div>
</body>
</html>