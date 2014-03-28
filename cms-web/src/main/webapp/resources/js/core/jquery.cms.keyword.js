(function($) {

	var setting;

	$.fn.keywordinput = function(opts) {
		setting = $.extend({
			number : 5,
			msg : "请输入关键字",
			autocomplete:{
				enable:false,
				url:"#",
				minLength:1
			},
			exists_id:"existKeyword" //孔浩写的是keyword-exists
			 
		}, opts || {});
		init(this);
		
		
		if(setting.autocomplete.enable){
			$(this).autocomplete({
				source:setting.autocomplete.url,
				minLength:setting.autocomplete.minLength
			});
		}
		
		//设置为keydown的时候触发事件， 这样防止form直接被提交。
		$(this).keydown(inputKeyword);
	 
	};

	// 初始化节点
	function init(input) {
		
		$(input).val(setting.msg);
		$(input).addClass("keyword-input");

		// 在目标对象前面增加放治关键字的div
		// 首先用wrap加入一个最外层的container， 然后再加入keywords-wrap负责存放关键字
		$(input).wrap("<div id='keyword-container'></div>").before(
				"<div id='keywords-wrap'></div>");
		
		
		initAddKeyword();
		
		$(input).focus(function() {
			$(this).val("");
		});

		$("#keyword-input").blur(function() {
			if ($(this).val().length == 0) {
				$(this).val("请输入关键字，通过逗号或者回车确认");
			}
		});
		
		$("#keywords-wrap").on("click", "a.keyword-shut", function() {
			$(this).parent(".keyword-in").remove();
			event.preventDefault();
		});
	}
	
	
	
	function inputKeyword(event){
		var code = event.keyCode;
		var add = true;
		if (code == 188 || code == 13) {
			// c是要添加的关键字
			var c = $(this).val();

			if (c != "") {
				if ($(".keyword-in").length >= setting.number) {
					alert("最多只能添加" + setting.number + "个关键字");
					event.preventDefault();
					return;
				}

				var aks = $("input[name='added_keywords']");
				for ( var i = 0; i < aks.length; i++) {
					console.log(aks[i]);
					if (aks[i].value == c) {
						alert("关键字已经存在");
						add = false;
						return false;
					}
				}

				if (add) {
					var ki = createKeyword(c);
					$("#keywords-wrap").append(ki);
					$(this).val("");
					event.preventDefault();
				}
			}
		}
	}
	
	
	//在更新文章中，将关键字放入已存在关键字的input节点中
	function initAddKeyword(){
		//得到span对象
		$("#"+setting.exists_id+" span").each(function(){
			var ki=createKeyword($(this).html());
		
			$("#keywords-wrap").append(ki);
		});
	}
	
	
	
	function createKeyword(val) {
		return "<div class='keyword-in'><span>"
				+ val
				+ "</span><a href='add.jsp#' class='keyword-shut'>&nbsp;X</a>"
				+"<input type='hidden' name='added_keywords' value='"+val+"'/></div>";
	}
	
	
	


})(jQuery);