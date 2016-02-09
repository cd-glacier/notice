$(function() {
	$(window).on('scroll', function() {
		if ($(document).scrollTop() > 100) {
			$('.fixbar').addClass('fixed');
		} else {
			$('.fixbar').removeClass('fixed');
		}
	});
});

