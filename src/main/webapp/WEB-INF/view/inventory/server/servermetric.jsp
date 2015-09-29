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
			title : '磁盘'
		});
		$('#network_metirc_panel').panel({
			title : '网络'
		});
		$('#start_time').datetimebox({showSeconds:true, editable:false});
		$('#end_time').datetimebox({showSeconds:true, editable:false});
		$('#query_button').linkbutton();
		$('.quick_select:eq(0)').addClass("quick_selected");
		
		//通过body计算出图标div的宽度
		var bodyWidth = $(document.body).width();
		$('.metric_chart').width(bodyWidth * 0.48);
		
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
				axisLabel : {
					rotate : 45,
					interval : 0
				},
				data : [],
			} ],
			yAxis : [ {
				type : 'value',
				splitNumber : 2
			} ],
			grid : {
				x2 : 20,
				y2 : 120
			},
			series : []
		};
		
		
		var chartsDom = {};
		chartsDom['cpu_idle'] = document.getElementById('cpu_idle');
		chartsDom['cpu_system'] = document.getElementById('cpu_system');
		chartsDom['cpu_user'] = document.getElementById('cpu_user');
		chartsDom['cpu_wio'] = document.getElementById('cpu_wio');
		
		chartsDom['mem_used_per'] = document.getElementById('mem_used_per');
		chartsDom['mem_cached'] = document.getElementById('mem_cached');
		chartsDom['mem_buffers'] = document.getElementById('mem_buffers');
		chartsDom['mem_free'] = document.getElementById('mem_free');
		chartsDom['mem_shared'] = document.getElementById('mem_shared');
		chartsDom['swap_free'] = document.getElementById('swap_free');
		
		chartsDom['disk_free'] = document.getElementById('disk_free');
		chartsDom['part_max_used'] = document.getElementById('part_max_used');
		
		chartsDom['bytes_in'] = document.getElementById('bytes_in');
		chartsDom['bytes_out'] = document.getElementById('bytes_out');
		chartsDom['pkts_in'] = document.getElementById('pkts_in');
		chartsDom['pkts_out'] = document.getElementById('pkts_out');
		
		var xdataTimeFormat = function(value, format){
			if(format == null){
				format = "MM-dd hh:mm";
			}
			if (value == null) {
				return null;
			}
			return new Date(value).Format(format);
		}
		
		var loadData = function(startTime, endTime){
			$.ajax({
				url : '<%=ctp %>/inventory/server/listMetric.action',
		        type : 'POST',
		        data: {
		        	serverId : '<s:property value="#parameters.serverId"/>',
		        	startTime : startTime,
		        	endTime : endTime
		        },
		        dataType : 'json',
		        success : function(metricDataMap) {
		        	for(var metricName in metricDataMap){
		        		var series = metricDataMap[metricName];
		        		option.legend.data = [metricName];
		        		//无数据的时候显示格式：指标名称+' 暂无数据'
		        		option.noDataLoadingOption.text = metricName + '  暂无数据';
		        		var xdata = metricDataMap[metricName].xdata;
		        		var xdataLength = xdata.length;
		        		for(var time in xdata){
		        			xdata[time] = xdataTimeFormat(xdata[time]);
		        		}
		        		//控制x轴显示8个节点
		        		option.xAxis[0].axisLabel.interval = (xdataLength/8).toFixed(0);
		   	         	option.xAxis[0].data = xdata;
		   	         	option.yAxis[0].name = '('+ series.unit +')';
		   	         	//设置为面积图
		   	            series.itemStyle = {normal: {areaStyle: {type: 'default'}}};
		   	            series.type = "line";
		   	            series.stack = "总量";
		   	         	option.series[0] = series;
		   	         	if(chartsDom[metricName]) {
		   	         	 	echarts.init(chartsDom[metricName], blueTheme).setOption(option);
		   	         	}
		        	}
		        }
		   });
		}
		
		//默认初始是一个小时之前的数据
		loadData(new Date().getTime() - 3600*1000, new Date().getTime());
		
		$('#query_button').click(function(){
			var startTime = $('#start_time').datetimebox('getValue');
			var endTime = $('#end_time').datetimebox('getValue');
			if(startTime == "" || endTime == ""){
				alert("请选择时间段！");
				return;
			}
			//火狐和IE浏览器不能解析中文版easyui_CN的日期格式
			var regax = /\-/g;
			var startTimeLong = new Date(startTime.replace(regax, "/")).getTime();
			var endTimeLong = new Date(endTime.replace(regax, "/")).getTime();
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
			$(this).addClass('quick_selected');
			var hour = $(this).attr("target");
			var endTime = new Date().getTime();
			var startTime = endTime - hour*3600*1000;
			loadData(startTime, endTime);
		});
	});

</script>
    <div id="main"style="min-width: 1100px;">
    	<div style="height: 30px; margin-top: 5px; padding-left: 13%;" >
        	<div style="float: left; margin-left: 10px; margin-right: 10px">
           		<div class="quick_select" target="1" style="border-top-left-radius:0.5em;
                	border-bottom-left-radius:0.5em;">1小时</div>
           		<div class="quick_select" target="6">6小时</div>
           		<div class="quick_select" target="12">12小时</div>
           		<div class="quick_select" target="24">1天</div>
           		<div class="quick_select" target="168">1周</div>
           		<div class="quick_select" target="720" style="border-top-right-radius:0.5em;
                border-bottom-right-radius:0.5em;">1个月</div>
        	</div>
        	<div style="float: left; margin-left: 10px; margin-right: 10px;">
                               	开始时间：<input type="input" id="start_time" style="width: 150px;">
        	</div>
        	<div style="float: left; margin-left: 10px; margin-right: 10px;">
                              	 结束时间：<input type="input" id="end_time" style="width: 150px;">
        	</div>
        	<button id="query_button" style="float: left; width: 60px; height: 25px;" >查询</button>
    	</div>
    	<div id="cpu_metirc_panel" style="margin-bottom: 60px;" >
        	<div id="cpu_idle" class="metric_chart"></div>
	    	<div id="cpu_system" class="metric_chart"></div>
	    	<div style="clear: both;"></div>
	    	<div id="cpu_user" class="metric_chart"></div>
	    	<div id="cpu_wio" class="metric_chart"></div>
    	</div>
		<div id="memory_metirc_panel" style="margin-bottom: 60px;" >
		 	<div id="mem_used_per" class="metric_chart"></div>
	    	<div id="mem_cached" class="metric_chart"></div>
	    	<div id="mem_buffers" class="metric_chart"></div>
	    	<div id="mem_free" class="metric_chart"></div>
	    	<div id="mem_shared" class="metric_chart"></div>
			<div id="swap_free" class="metric_chart"></div>
		</div>
		<div id="disk_metirc_panel" style="margin-bottom: 60px;" >
	    	<div id="disk_free" class="metric_chart"></div>
	    	<div id="part_max_used" class="metric_chart"></div>
		</div>
		<div id="network_metirc_panel" style="margin-bottom: 60px;">
	    	<div id="bytes_in" class="metric_chart"></div>
	    	<div id="bytes_out" class="metric_chart"></div>
	    	<div id="pkts_in" class="metric_chart"></div>
	    	<div id="pkts_out" class="metric_chart"></div>
		</div>
	</div>


