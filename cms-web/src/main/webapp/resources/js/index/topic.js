$(function() {
	/* 让content的高度和content_con的高度一样 */
//	$(".attch_img").load(function(){
//		$("#content").height($("#content_con").height());
//	});
	
	$(".attch_img").on("load",function(){
		$("#content").height($("#content_con").height());
	});
	//document.getElementsByTagName("attach_img").onload = function() {}; 
	
	 $("#content").height($("#content_con").height());

     
 
	

});