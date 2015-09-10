var getContextPath = function(){
	return window.top.getCtp();
}

var commonSorter = function(a, b){
	if(!a) {
		return -1;
	}
	else if(!b) {
		return 1;
	}
	else {
		return a > b ? 1 : -1;
	}
}

//date format
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function dateFormat(value, format){
	if(format == null){
		format = "yyyy-MM-dd hh:mm:ss";
	}
	if (value == null) {
		return null;
	}
	return new Date(value).Format(format);
}

$(function(){
	$(document).ajaxError(function(event, xhr){
		$.messager.progress('close');
		if(xhr.status == 401) {
			window.top.location.href = getCtp() + '/main.action';
		}
		else if(xhr.status == 409) {
			$.messager.alert('错误', xhr.responseText, 'error');
		}
		else {
			try {
				var fault = $.parseJSON(xhr.responseText);
				$.messager.alert('错误', fault.errorCode + ' , ' + fault.message, 'error');
			}
			catch (e) {
				$.messager.alert('错误', xhr.responseText, 'error');
			}
		}
	});
	
	$.ajaxSetup({
		method: 'POST',
		dataType: 'json'
	});
});


//date format
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}


function dateTimeBoxFormat(value, format){
	if(format == null){
		format = "MM/dd/yyyy hh:mm:ss";
	}
	if (value == null) {
		return null;
	}
	return new Date(value).Format(format);
}
