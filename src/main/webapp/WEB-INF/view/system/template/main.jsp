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
			$('#template_main_grid').datagrid({    
			    url:'<%=ctp %>/system/template/listtemplate.action',
			    fit: true,
			    fitColumns: true,
			    columns:[[
			        {field: 'name',title:'模板名称', width: 150, align: 'center'},
			        {field: 'createTime', title: '创建时间', width: 150, align: 'center', formatter: function(value, row, index){
			        	return dateFormat(value);
			        }},
			        {field: 'desc', title: '描述', width: 300, align: 'center'},
			        {field: 'type', title: '类型', width: 100, align: 'center'},
			        {field: 'templateId', title: '操作', width: 100, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation templateId="' + value + '" style="text-align: left"></div>';
			        }}
			    ]],
			    onLoadSuccess: function(data){
			    	$('[grid_operation]').each(function(i){	
			    		var $editButton = $('<span title="编辑"></span>').addClass('operation_icon_black');
			    		$editButton.css('background-position', '-64px -112px');
			    		$editButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$editButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$editButton.appendTo($(this));
			    		
			    		var $deleteButton = $('<span title="删除"></span>').addClass('operation_icon_black');
			    		$deleteButton.css('background-position', '-176px -96px');
			    		$deleteButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$deleteButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$deleteButton.appendTo($(this));
			    		
			    		$editButton.click(function(){
			    			var templateId = $(this).parent().attr('templateId');
			    			window.location.href = '<%=ctp %>/system/template/updatetemplate.action?templateId=' + templateId;
			    		});
			    		
			    		$deleteButton.click(function(){
			    			var templateId = $(this).parent().attr('templateId');
			    			$.messager.confirm('确认删除', '确认要删除此模板', function(r){
			    				if (r){
			    					$.messager.progress({text: '正在处理，请稍后...'});
			    					$.ajax({
			    						url: '<%=ctp %>/system/template/deletetemplate.action?templateId=' + templateId,
			    						dataType: 'json',
			    						success: function(){
			    							$.messager.progress('close');
			    							$('#template_main_grid').datagrid('reload');
			    						}
			    					});
			    				}
			    			});
			    		});
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
			<div>模板配置管理</div>
			<div class="content_title_operation">
				<a href="addtemplate.action" style="color: #000000">
					<span class="operation_icon_black" style="background-position: 0px -190px"></span>
					<span>添加模板</span>
				</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="template_main_grid"></table>
	</div>
</body>
</html>