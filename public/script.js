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

$(function(){
	$('#notice_button').click(function(e){
		e.preventDefault();
		var js_keyword = $(":text[id='keyword']").val();
		var js_url = $("#url").val();
		var js_email = $("#email").val();
		$.ajax({
			type: 'POST',
			url: '/notice',
			data: {
				keyword: js_keyword,
				url: js_url,
				email: js_email
			},
			success: function(json){
				console.log(js_keyword);
				console.log(js_url);
				console.log(js_email);
				alert("正常に操作が完了しました。");
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
				alert("製作者にメッセージを送信しました。");
			}
		});
	});
});

