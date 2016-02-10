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
			scrollTop: offset - 180 
		}, 1000);
	});
});


