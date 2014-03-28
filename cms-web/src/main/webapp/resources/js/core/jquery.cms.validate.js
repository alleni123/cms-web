(function($) {
	var __validate = $.fn.validate;
	$.fn.cmsvalidate = function(opts) {
		var __defaultOpts = {
			errorPlacement : function(error, element) {
				// console.log(element.parent().next().html());
				// console.log(error);
				error.appendTo(element.parent().next());
			},

			rules : {
				username : "required",
				roleType : "required",
				password : {
					required : true,
					minlength : 3
				},
				confirmPwd : {
					equalTo : "#password"
				},
				email:"email",
				name : "required"
			},

			messages : {
				username : "用户名不能为空",
				roleType : "必须选择角色类型",
				password : {
					required : "密码不能为空",
					minlength : "长度不能少于3个字符"
				},
				confirmPwd : "密码必须一致",
				email:"邮件格式不正确",
				name : "名称不能为空"

			}
		};

		$.extend($.fn.validate.prototype, __defaultOpts);
		__validate.call(this, __defaultOpts);

	};

	$.fn.confirmOperator = function(opts) {
		var settings = $.extend({
			msg : "改操作不可逆，确定进行改操作吗？",
			eventName : "click"
		}, opts || {});

		$(this).on(settings.eventName, function(event) {
			if (!confirm(settings.msg)) {
				event.preventDefault();
			}
		});

	}

})(jQuery);