/**
 * main.js里面应该包含一些所有页面都被使用的脚本，比如top.jsp和bottom.jsp页面的。
 */
$(function() {
	/* 让content的高度和content_con的高度一样 */
   //	$("#content").height($("#content_con").height());
	
	$("#content_con").ready(function(){
		$("#content").height($("#content_con").height());
	});
 
	 
	 
	/* 搜索开始. 调用myInput */
	$("#search input").myInput();
	
	
	var search_func=function(){
		var sv=$("#search_con").val();
		if(sv=="Search.."||sv==""){
			
		}else{
			 window.location.href=$("#contextPath").val()+"/search/"+sv;
		}
	};
	
	$("#search input").keyup(function(event){
		if(event.keyCode==13){
			search_func();
		};
	});
	
	$("#search_btn").click(search_func);
	 
	$("#search_btn").hover(function(){
		$(this).css("cursor","pointer");
	});
	
	$("#search_btn").mousedown(function(){
		$(this).parent().css("background","url(resources/css/index/img/search_bg_2.jpg)");
	});
	
  
	$("#search_btn").on("mouseup mouseout",function(){
		$(this).parent().css("background","url(resources/css/index/img/search_bg.jpg)");
		
	});
	
	
	

	
	/*搜索结束*/


	$("#nav_con ul li").hover(function() {
		$(this).addClass("nav_hover");
		$(this).find("span").css("color", "#20a056");
	}, function() {
		$(this).removeClass("nav_hover");
		$(this).find("span").css("color", "#fff");
	});

	

	$("#nav_con ul li").click(function() {
		window.location.href = $(this).children("span").attr("href");
		event.preventDefault();
	});

	$("#logo").hover(function() {
		$(this).css("cursor", "pointer");
	});
	$("#logo").click(function() {

		window.location.href = $("#contextPath").val();
	});
	 

});