<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String ctp = request.getContextPath();
%>
<script type="text/javascript">
	$(function() {
		$('#cpu_metirc_panel').panel({
			title : 'CPU'
		});
		$('#memory_metirc_panel').panel({
			title : '内存'
		});
		$('#disk_metirc_panel').panel({
			title : '硬盘'
		});
		$('#network_metirc_panel').panel({
			title : '网络'
		});
		$('#start_time').datetimebox({showSeconds:true, editable:false});
		$('#end_time').datetimebox({showSeconds:true, editable:false});
		$('#query_button').linkbutton();
		$($('.quick_select').get(0)).addClass("quick_selected");
		
		var option = {
			tooltip : {
				trigger : 'axis',
			},
			legend : {
				data : []
			},
			noDataLoadingOption : {
				text : '暂无数据',
				effect : 'bubble',
				effectOption : {
					effect : {n : 0} 
				},
				textStyle : {
					fontSize : 32,
					fontWeight : 'blod'
				}
			},
			xAxis : [ {
				type : 'category',
				boundaryGap : false,
				data : []
			} ],
			yAxis : [ {
				type : 'value'
			} ],
			series : []
		};
		
		
		var charts = {};
		charts['cpu_idle'] = echarts.init(document.getElementById('cpu_idle'));
		charts['cpu_system'] = echarts.init(document.getElementById('cpu_system'));
		charts['cpu_user'] = echarts.init(document.getElementById('cpu_user'));
		charts['cpu_wio'] = echarts.init(document.getElementById('cpu_wio'));
		
		charts['mem_cached'] = echarts.init(document.getElementById('mem_cached'));
		charts['mem_buffers'] = echarts.init(document.getElementById('mem_buffers'));
		charts['mem_free'] = echarts.init(document.getElementById('mem_free'));
		charts['mem_shared'] = echarts.init(document.getElementById('mem_shared'));
		charts['swap_free'] = echarts.init(document.getElementById('swap_free'));
		
		charts['disk_free'] = echarts.init(document.getElementById('disk_free'));
		charts['part_max_used'] = echarts.init(document.getElementById('part_max_used'));
		
		charts['bytes_in'] = echarts.init(document.getElementById('bytes_in'));
		charts['bytes_out'] = echarts.init(document.getElementById('bytes_out'));
		charts['pkts_in'] = echarts.init(document.getElementById('pkts_in'));
		charts['pkts_out'] = echarts.init(document.getElementById('pkts_out'));
		
		var loadData = function(startTime, endTime){
			$.ajax({
				url : '<%=ctp %>/metric/listMetric.action',
		        type : 'POST',
		        data: {
		        	ip : '<s:property value="#parameters.ip" />',
		        	startTime : startTime,
		        	endTime : endTime
		        },
		        dataType : 'json',
		        success : function(resultMap) {
		        	//这边要得到time
		        	for(var key in resultMap){
		        		var series = resultMap[key];
		        		option.legend.data = [key];
		        		option.noDataLoadingOption.text = key + '  暂无数据';
		   	         	option.xAxis[0].data = resultMap[key].xdata;
		   	         	option.yAxis[0].name = '('+ series.unit +')';
		   	            series.itemStyle = {normal: {areaStyle: {type: 'default'}}};
		   	            series.type = "line";
		   	            series.stack = "总量";
		   	         	option.series[0] = series;
		   	         	if(charts[key]) {
		   	         		charts[key].setOption(option);
		   	         	}
		        	}
		        }
		   });
		}
		
		loadData();
		
		$('#query_button').click(function(){
			var startTime = $('#start_time').datetimebox('getValue');
			var endTime = $('#end_time').datetimebox('getValue');
			if(startTime == "" || endTime == ""){
				alert("请选择时间段！");
				return;
			}
			var startTimeLong = new Date(startTime).getTime();
			var endTimeLong = new Date(endTime).getTime();
			if(startTimeLong > endTimeLong){
				alert("开始时间大于结束时间");
				return;
			}
			$('.quick_select').removeClass('quick_selected');
			loadData(startTimeLong, endTimeLong);
		});  
		$('.quick_select').click(function(){
			$('#start_time').datetimebox('setValue', "");
			$('#end_time').datetimebox('setValue', "");
			$('.quick_select').removeClass('quick_selected');
			$('.quick_select').addClass('quick_select');
			$(this).addClass('quick_selected');
			var hour = $(this).attr("target");
			var endTime = new Date().getTime();
			var startTime = endTime - hour*3600*1000;
			loadData(startTime, endTime);
		});
	});

</script>
<div>
    <div id="time_div" style="height: 30px; margin-top: 5px; padding-left: 70px;">
        <div id="time_select_div" style="float: left; margin-left: 10px; margin-right: 10px;">
           <div class="quick_select" target="1">1小时</div>
           <div class="quick_select" target="6">6小时</div>
           <div class="quick_select" target="12">12小时</div>
           <div class="quick_select" target="24">1天</div>
           <div class="quick_select" target="168">1周</div>
           <div class="quick_select" target="720">1个月</div>
        </div>
        <div style="float: left; margin-left: 10px; margin-right: 10px;">
                               开始时间：<input type="input" id="start_time" style="width: 150px;">
        </div>
        <div style="float: left; margin-left: 10px; margin-right: 10px;">
                               结束时间：<input type="input" id="end_time" style="width: 150px;">
        </div>
        <button id="query_button" style="width: 100px; height: 25px;" >查询</button>
    </div>
	<div id="cpu_metirc_panel">
	    <div id="cpu_idle" class="metric_chart"></div>
	    <div id="cpu_system" class="metric_chart"></div>
	    <div style="clear: both;"></div>
	    <div id="cpu_user" class="metric_chart"></div>
	    <div id="cpu_wio" class="metric_chart"></div>
	</div>
	<div id="memory_metirc_panel">
	    <div id="mem_cached" class="metric_chart"></div>
	    <div id="mem_buffers" class="metric_chart"></div>
	    <div style="clear: both;"></div>
	    <div id="mem_free" class="metric_chart"></div>
	    <div id="mem_shared" class="metric_chart"></div>
	    <div style="clear: both;"></div>
	    <div id="swap_free" class="metric_chart"></div>
	</div>
	<div id="disk_metirc_panel">
	    <div id="disk_free" class="metric_chart"></div>
	    <div id="part_max_used" class="metric_chart"></div>
	</div>
	<div id="network_metirc_panel">
	    <div id="bytes_in" class="metric_chart"></div>
	    <div id="bytes_out" class="metric_chart"></div>
	    <div id="pkts_in" class="metric_chart"></div>
	    <div id="pkts_out" class="metric_chart"></div>
	</div>
</div>

