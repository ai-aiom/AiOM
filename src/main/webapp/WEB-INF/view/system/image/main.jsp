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
			$('#image_main_grid').datagrid({    
			    url:'<%=ctp %>/system/image/listimage.action',
			    fit: true,
			    fitColumns: true,
			    columns:[[
			        {field: 'name',title:'名称', width: 200, align: 'center'},
			        {field: 'desc', title: '描述', width: 300, align: 'center'},
			        {field: 'osType', title: '系统类型', width: 100, align: 'center'},
			        {field: 'osVersion', title: '系统版本', width: 100, align: 'center'},
			        {field: 'osArch', title: '系统架构', width: 100, align: 'center'},
			        {field: 'id', title: '操作', width: 200, align: 'center', formatter: function(value, row, index){
			        	return '<div grid_operation imageid="' + value + '" style="text-align: left"></div>';
			        }}
			    ]],
			    onLoadSuccess: function(data){
			    	$('[grid_operation]').each(function(i){
			    		var $deleteButton = $('<span title="删除"></span>').addClass('operation_icon_black');
			    		$deleteButton.css('background-position', '-176px -96px');
			    		$deleteButton.mouseover(function(){$(this).addClass('operation_icon_blue')});
			    		$deleteButton.mouseout(function(){$(this).removeClass('operation_icon_blue')});
			    		$deleteButton.appendTo($(this));
			    		
			    		$deleteButton.click(function(){
			    			var imageId = $(this).parent().attr('imageid');
			    			$.messager.confirm('确认删除', '确认要删除此镜像', function(r){
			    				if (r){
			    					$.messager.progress({text: '正在处理，请稍后...'});
			    					$.ajax({
			    						url: '<%=ctp %>/system/image/deleteimage.action?imageId=' + imageId,
			    						dataType: 'json',
			    						success: function(){
			    							$.messager.progress('close');
			    							$('#image_main_grid').datagrid('reload');
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
			<div>镜像管理</div>
			<div class="content_title_operation">
				<a href="addimage.action" style="color: #000000">
					<span class="operation_icon_black" style="background-position: 0px -190px"></span>
					<span>添加镜像</span>
				</a>
			</div>
		</div>
	</div>
	<div data-options="region:'center', border: false" style="padding: 10px">
		<table id="image_main_grid"></table>
	</div>
</body>
</html>