$(function() {
	$(".button-collapse").sideNav();
});

////home////

$(function() {
	$(window).on('scroll', function() {
		if ($(document).scrollTop() > 135) {
			$('.fixbar').addClass('fixed');
		} else {
			$('.fixbar').removeClass('fixed');
		}
	});
});

$(function() {
	$(".link").click(function(e){
		e.preventDefault();
		var target = $(this).attr("href");
		var offset = $(target).offset().top;
		
		$("body, html").animate({
			scrollTop: offset - 160 
		}, 1000);
	});
});

$(function() {
	$("side_link").click(function(e){
		e.preventDefault();
		window.location.href = "/";
		var target = $(this).attr("href");
		var offset = $(target).offset().top;
		
		$("body, html").animate({
			scrollTop: offset - 160 
		}, 1000);                     
	});
});

$(function(){
	$('#notice_button').click(function(e){
		e.preventDefault();
		var js_keyword = $(":text[id='keyword']").val();
		var js_url = $("#url").val();
		var js_email = $("#email").val();
				console.log(js_keyword);
				console.log(js_url);
				console.log(js_email);
		$.ajax({
			type: 'POST',
			url: '/notice',
			data: {
				keyword: js_keyword,
				url: js_url,
				email: js_email
			},
			success: function(json){
				//alert("正常に操作が完了しました。");

				var notification = document.querySelector('.mdl-js-snackbar');
				var data = {
					message: '正常に操作が完了しました。',
					actionHandler: function(event) {},
					//actionText: 'Undo',
					actionText: 'OK',
					timeout: 10000
				};
				notification.MaterialSnackbar.showSnackbar(data);

			}
		});
	});
});

$(function(){
	$('#contact_button').click(function(e){
		e.preventDefault();
		var js_contact_email = $("#contact_email").val();
		var js_message = $("#message").val();
		$.ajax({
			type: 'POST',
			url: '/contact',
			data: {
				contact_email: js_contact_email,
				message: js_message
			},
			success: function(json){
				//alert("製作者にメッセージを送信しました。");

				var notification = document.querySelector('.mdl-js-snackbar');
				var data = {
					message: '製作者にメッセージを送信しました。',
					actionHandler: function(event) {},
					actionText: 'OK',
					timeout: 10000
				};
				notification.MaterialSnackbar.showSnackbar(data);

			}
		});
	});
});

////config/////

$(function(){
	$('.url').click(function(e){
		e.preventDefault();
  	var url = $(this).attr("href");
		window.open(url);
	});
});


//汚いので変えたい、でもめんどい
$(function(){
	$('#update_button').click(function(e){
		e.preventDefault();
		var js_notice_box = [];
		var js_notice_box_id = [];
		var js_delete_box = [];
		var js_length = $("#update_button").data("length")
		var js_email = $("#update_button").data("email")
		
		for(var i = 0; i < js_length; i++){
			if ($("#notice_box" + i).is(":checked")){
				//checked = 通知してない = 0
				js_notice_box.push(0);	
			}else{
				js_notice_box.push(1);	
			}
			js_notice_box_id.push($("#notice_box" + i).data("notice_id"));	

			if($("#delete_box" + i).is(":checked")){
				js_delete_box.push($("#delete_box" + i).data("delete_id"));
			}	
			
		}
		console.log(js_notice_box);
		console.log(js_delete_box);
		$.ajax({
			type: 'POST',
			url: '/config',
			data: {
				notice_box: js_notice_box,
				delete_box: js_delete_box,
				email: js_email,
				notice_box_id: js_notice_box_id
			},
			success: function(json){
				alert("正常に操作が完了しました。");
			}
		});
	});
});

////config_start////
$(function(){
	$('#sys_button').click(function(e){
		e.preventDefault();
		config = "/config/" + $("#config_email").val();
		window.location.href = config;
	});
});

