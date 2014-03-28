$(function() {
	/* 让content的高度和content_con的高度一样 */
	$("#content").height($("#content_con").height());

	/* 调用myInput */
	$("#search input").myInput();

	$("#rollpic").cycle({
		fx : 'fade',
		speed : 2000,
		timeout : 1500
	});
	$(".cycle-slide").click(function() {
		var href = $(this).attr("href");
		window.open(href);
	});
	$(".cycle-slide").hover(function() {
		$(this).css("cursor", "pointer");
	});

	 

	$("#chief_keyword span").hover(function() {
		$(this).css("background-color", "#a32");
	}, function() {
		$(this).css("background-color", "#698911");
	});

	 
	 

});