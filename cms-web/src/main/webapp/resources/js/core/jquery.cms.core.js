//Ϊ�հ���һ������$�� ��jQuery����
(function($) {

	// 这里用来验证返回结果是否没有问题。
	// 如果没有问题，那么data.result就是1.（在后台被设置为1）
	//
	$.ajaxCheck = function(data) {
		if (data.result) {
			return 1;
		} else {
			alert(data.message);
		}
	};

	$.fn.mytree = function(opts) {
		var setting = $.extend({
			data : {
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "pid",
					rootPid : -1
				}
			},
			view : {
				dbClickExpand : false,
				selectedMulti : false
			},

			callback : {
			// onClick:function(event, treeId, treeNode){
			// console.log(treeId);
			// console.log(treeNode);
			// }
			},
			async : {
				enable : true,
				// url:"admin/channel/treeAll",
				url : opts ? (opts.url || "admin/channel/treeAll")
						: "admin/channel/treeAll"
			},

			/**
			 * 这里孔浩写的是mime
			 */
			_custom : {
				listChild : 1,
				srcElement : "#cc"
			}

		}, opts || {});// 最后的opts代表如果有传入参数，则会替换掉上面的默认参数

		var my_custom = setting._custom;
		console.log(my_custom);

		// 这里必须要注意这里输入的对象是#tree，当因此会导致莫名的错误
		// var t=$.fn.zTree.init($("#tree"),setting);
		// 必须修改成下面的：
		var t = $.fn.zTree.init($(this), setting);

		if (my_custom.listChild) {
			t.setting.callback.onClick = listChild;
		}

		/**
		 * 将my_custom，也就是setting._custom的srcElement所包含的id的节点，换成admin/channel/channels/{id}请求所获取的页面
		 */
		function listChild(event, treeId, treeNode) {
			$(my_custom.srcElement).attr("src",
					"admin/channel/channels/" + treeNode.id);
		}

		console.log("mytree");
		return t;

	};

	$.fn.myaccordion = function(opts) {

		var settings = $.extend({
			selectedClz : "navSelected",
			titleTagName : "h3",
			color : "#e3e6f6"
		}, opts || {});
		var titleNode = $(this).find("ul>" + settings.titleTagName);
		var selectedNode = $(this).find(
				"ul." + settings.selectedClz + ">" + settings.titleTagName);
		// titleNode.nextAll().css("display","none");

		titleNode.css("cursor", "pointer");
		selectedNode.nextAll().css("display", "block");

		titleNode.click(function() {
			var checked = $(this).parent().hasClass("navSelected");

			if (checked) {
				$(this).parent().removeClass("navSelected");
				$(this).nextAll().slideUp();

			} else {
				$(this).parent().addClass("navSelected");
				$(this).nextAll().slideDown();
			}

		});

		// $(this).find(settings.titleTagName).css("cursor","pointer");

	};

	$.fn.changeColor = function(opts) {
		var settings = $.extend({
			original_color : "black",
			expect_color : "green",
			color_attr : "color"
		}, opts || {});

		$(this).mouseenter(function() {
			$(this).css(settings.color_attr, settings.expect_color);
		});
		$(this).mouseleave(function() {
			$(this).css(settings.color_attr, settings.original_color);
		});

	};

	$.fn.trColorChange = function(opts) {
		var settings = $.extend({
			evenColor : "#9fbeee"
		}, opts || {});

		$(this).find("tbody tr:even").css("background-color",
				settings.evenColor);
	};

	$.fn.confirmOperator = function(opts) {
		var settings = $.extend({
			msg : "该操作不可逆，确定进行该操作么",
			eventName : "click"
		}, opts || {});

		$(this).on(settings.eventName, function(event) {

			if (!confirm(settings.msg)) {
				event.preventDefault();
			}
		});
	};

	$.getHexColor = function(rgb_arr) {
		var r_g_b = rgb_arr.match(/\d+/g);

		return toHexColor(r_g_b[0], r_g_b[1], r_g_b[2]);
	};

	function toHexColor(r, g, b) {
		var hex = "#";
		var hexStr = "0123456789ABCDEF";

		var cal = function(oct) {
			low = oct % 16;
			high = (oct - low) / 16;
			var result = hexStr.charAt(high) + hexStr.charAt(low);
			return result;
		};

		hex += (cal(r) + cal(g) + cal(b));
		return hex;
	}

})(jQuery);