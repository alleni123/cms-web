$(function() {
	var path = $("#contextPath").val();
	var uploadPath=$("#contextPath").val()+"/resources/upload/";
	
	
	mt = $("#mytree").mytree({
		callback : {
			onClick : choose,
			beforeClick : beforeChoose,
			onAsyncSuccess : function() {
				mt.expandAll(true);
			}
		},
		_custom : {
			listChild : 0
		},
		url:$("#ctx").val()+"/admin/channel/treeEnabled"
	});

	$("#channel_name").click(showMenu);
	
	
	//文件上传 uplodify开始
	$("#attach").uploadify({
		swf : path + "/resources/uploadify/uploadify.swf",
		uploader : path+"/admin/topic/upload",
		fileObjName : "attach",
		height : 30,
		width : 120,
		auto : false,
		fileSizeLimit : '50MB',
		fileTypeExts : "*.jpg;*.avi;*.wmv;*.txt;*.doc",
		onUploadSuccess : function(file, data, response) {
			var ao = $.parseJSON(data);
			var suc=$.ajaxCheck(ao); //$.ajaxCheck定义在jquery.cms.core.js里面。 如果ao.result==1,则返回1，否则返回ao.message
			console.log(ao);
			console.log(suc);
			if (ao.result == 1) {
				alert("文件 " + file.name + " 成功上传");
			}
			if(suc){
				//如果成功上传，则创建node到文件信息的table中。
				var node=createAttachNode(ao.obj);
				$("#ok_attach").find("tbody").append(node);
			}
		}
	});

	$("#uploadFile").click(function() {
		$("#attach").uploadify("upload", "*");

	});
	
	//文件上传 uploadify结束

	$("#keyword").autocomplete({

		source : path + "/admin/topic/searchKeyword"
	});

	$("#keyword").keywordinput();

	$("#publishDate").datepicker({
		dateFormat : "yy-mm-dd",// 设置日期的格式
		maxDate : 0, // 最大日期为1年后
		changeMonth : true,
		changeYear : true,
		changeDay : false

	});

	$("#ui-datepicker-div").css('font-size', '0.9em'); // 改变大小

	var editor=$('#content').xheditor({
		tools : "full"
	});
	
	
	//点击附件信息，更新附件开始
	$("#ok_attach").on("click",".indexPic",function(){
		
			//alert($(this).val()); value值已被设置为attach.id
			dwrService.updateIndexPic($(this).val());
	});
	
	$("#ok_attach").on("click",".isAttach",function(){
		//alert($(this).val());
		dwrService.updateAttachInfo($(this).val());
	});
	
	//附件删除从视频69 52分钟开始
	$("#ok_attach").on("click",".deleteAttach",function(){
		var conf=confirm("确定删除附件信息吗？");
		alert("conf= "+conf);
		if(conf){
		var ad=this;
		var id=$(this).attr("title");
		console.log("id="+id);
		dwrService.deleteAttach($(this).attr("title"),function(data){
			$(ad).parent("td").parent("tr").remove();
		});
		} 
	});
	
	//视频70 5分钟开始
	$("#ok_attach").on("click",".insertAttach",function(){
	  
		if($(this).attr("isImg")==1){
		//	alert($(this).attr("name"));
			//这里选择upload/thumb/name就会在文章中显示缩略图。
			node="<img src='"+$("#contextPath").val()+"/resources/upload/"+$(this).attr("name")+
			"' id='img_"+$(this).attr("title")+"' class='attch_img' path='"+path+"/resources/upload/"+$(this).attr("name")+"'/>";
		} else{
		//	alert($(this).attr("isImg"));
			node="<a href='"+uploadPath+$(this).attr("name")+"' id='link_"+$(this).attr("title")+"'>"+$(this).attr("oldName")+"</a>";
		}
		editor.pasteHTML(node);//在demo的demo05中。
		
		
	});
	
	
	
	//点击附件信息，更新附件结束 
});
//$(function)结束

/**
 * 创建附件信息节点。 用户可以根据附件信息节点来更新修改附件内容
 * @param attach
 * @returns {String}
 */
function createAttachNode(attach){
	var node="<tr>";
	
	//alert("path= "+path); 这里是/cms/admin/topic,而不是需要的cms
	if(attach.isImg){
		//!!这里不能用path代替$("#contextPath").val(),  path会等于/cms/admin/topic，我也不知道为什么
		node+="<td><img src='"+$("#contextPath").val()+"/resources/upload/thumbnail/"+attach.newName+"'/></td>";
		
		
	}else{
		//不是图片， 就显示一个普通附件类型+两个空td
		node+="<td>普通附件类型</td>";
	 
	}
	
	node+="<td>"+attach.originalName+"</td>";
	node+="<td>"+((attach.fileSize/1024).toFixed(1))+"K</td>";
	
	
	if(attach.isImg){
		//是否是主页图片
		node+="<td><input type='checkbox' class='indexPic' value='"+attach.id+"' name='indexPic'></td>";
		//是否是栏目图片
		node+="<td><input type='radio' value='"+attach.id+"' name='channelPicId'></td>";
	}else{
		node+="<td>&nbsp;</td><td>&nbsp;</td>";
	}
	
 
	//是否是附件
	node+="<td><input type='checkbox' class='isAttach' value='"+attach.id+"' name='isAttach'><input type='hidden' name='aids' value='"+attach.id+"'/></td>";
	//点击插入附件，附件便会被放入xheditor的文章内容中。 这里调用了$("#ok_attach").on("click",".insertAttach",function(){来完成该功能。（该方法在上面）
	node+="<td><a href='javascript:void(0)' class='list_op insertAttach' name='"+attach.newName+"' oldName='"+attach.originalName+"' title='"+attach.id+"' isImg='"+attach.isImg+"'>插入附件</a>&nbsp;<a href='javascript:void(0)' id='"+attach.id+"' title='"+attach.id+"' class='list_op deleteAttach'>删除附件</a></td>";
	//这里要注意， 这里加入的节点的事件委派必须由$("#ok_attach").on("click",".isAttach",function(){这种格式来完成。
	
	 
	node+="</tr>";
	return node;
	
	 
}

function choose(event, treeId, treeNode) {

	$("#channel_name").val(treeNode.name);
	$("#channel_id").val(treeNode.id);
	hideMenu();
}

function beforeChoose(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check)
		return check;
}

function showMenu() {
	var channelObj = $("#channel_name");
	var channelOffset = $("#channel_name").offset();

	$("#menuContent").css({
		left : channelOffset.left + "px",
		top : channelOffset.top + channelObj.outerHeight() + "px"
	}).slideDown("fast");
	$("body").bind("mousedown", onBodyDown);

}

function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(
			event.target).parents("#menuContent").length > 0)) {
		hideMenu();
	}
}

function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}
