var getContextPath = function(){
	return window.top.getCtp();
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
		
		try {
			var fault = $.parseJSON(xhr.responseText);
			$.messager.alert('错误', fault.errorCode + ' , ' + fault.message, 'error');
		}
		catch (e) {
			$.messager.alert('错误', xhr.responseText, 'error');
		}
	});
	
	$.ajaxSetup({
		method: 'POST',
		dataType: 'json'
	});
});