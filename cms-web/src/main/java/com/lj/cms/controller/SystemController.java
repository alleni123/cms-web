package com.lj.cms.controller;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lj.basic.model.SystemContext;
import com.lj.cms.service.IAttachmentService;
import com.lj.cms.service.IIndexPicService;
import com.lj.cms.service.IIndexService;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.BaseInfo;



/**
 * index.jsp页面底部的更新在updateBaseInfo方法中。
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/system")
public class SystemController
{	
	
	@Autowired
	private IAttachmentService attachmentService;
	
	@Autowired
	private IIndexPicService indexPicService; 
	
	@Autowired
	private IIndexService indexService;
	
	@RequestMapping("/baseinfo")
	public String showBaseInfo(HttpSession session, Model model){
		model.addAttribute("baseInfo", session.getServletContext().getAttribute("baseInfo"));
		return "system/showBaseInfo";
	}
	
	@RequestMapping(value="/baseinfo/update",method=RequestMethod.GET)
	public String updateBaseInfo(HttpSession session, Model model){
		model.addAttribute("baseInfo", session.getServletContext().getAttribute("baseInfo"));
		return "system/updateBaseInfo";
	}
	
	@RequestMapping(value="/baseinfo/update",method=RequestMethod.POST)
	public String updateBaseInfo(@Validated BaseInfo baseInfo,BindingResult br,HttpSession session, Model model){
		if(br.hasErrors()){
			return "system/updateBaseInfo";
		}
		BaseInfo bi=BaseInfoUtil.getInstance().write(baseInfo);
		session.getServletContext().setAttribute("baseInfo", bi);
		indexService.generateBottom();
		return "redirect:/admin/system/baseinfo";
	}
	
	
	
	//清理系统
	
	@RequestMapping("/cleans")
	public String listCleans(Model model){
		//attNums:要删除的没有被引用的附件的数量
		model.addAttribute("attNums",attachmentService.findNoUseAttachmentNum());
		
		//indexPicsNum:要删除的没有被使用的主页图片的数量
		model.addAttribute("indexPicsNum", listNoUseIndexPicNum(indexPicService.listAllIndexPicName()));
		
		 
		
		return "system/cleans";
	}
	

	
	@RequestMapping("/cleanList/{name}")
	public String cleanList(@PathVariable String name, Model model){
		if(name.equals("atts")){
			model.addAttribute("datas", attachmentService.findNoUseAttachment());
			return "system/cleanAtts";
		}else if(name.equals("pics")){
			//首先获取所有首页图片名称，然后获取所有没有被使用的
			model.addAttribute("pics", listNoUseIndexPic(indexPicService.listAllIndexPicName()));
			return "system/cleanPics";
		}
		
		return "";
	}
	
	@RequestMapping("/clean/{name}")
	public String clean(@PathVariable String name, Model model){
		if(name.equals("atts")){
			attachmentService.clearNoUseAttachment();
		}else if(name.equals("pics")){
			//首先获取所有首页图片名称，然后获取没有被使用的。 最后清楚掉这些没有被使用的。
			indexPicService.cleanNoUseIndexPic(listNoUseIndexPic(indexPicService.listAllIndexPicName()));
		}
		
		model.addAttribute("atts", attachmentService.findNoUseAttachment());
		return "redirect:/admin/system/cleans";
	}
	
	
	
	
	/**
	 * 获取/resources/indexPic下的所有主页图片的File对象。</br>
	 * 
	 * @return
	 */
	private File[] listPicFile(){
	String path=SystemContext.getRealPath();
		
		File f=new File(path+"/resources/indexPic");
		File[] fs=f.listFiles(new FileFilter(){

			@Override
			public boolean accept(File pathname)
			{
				if(pathname.isDirectory()){
				return false;}
				return true;
			}
			
		});
		
		return fs;
	}
	
	/**
	 * 获取没有被使用的图片的数量
	 * @param pics 已经被使用的图片名称List
	 * @return
	 */
	private int listNoUseIndexPicNum(List<String>pics){
		File[] fs=listPicFile();
		
		int count=0;
		for(File file:fs){
			if(!pics.contains(file.getName())){
				count++;
			}
		}
				
		return count;
	}
	
	/**
	 * 获取没有被使用的图片的名称List
	 * @param pics 已经被使用的图片名称List
	 * @return
	 */
	private List<String> listNoUseIndexPic(List<String>pics){
		File[] fs=listPicFile();
		List<String> npics=new ArrayList<String>();
		
		for(File f:fs){
			if(!pics.contains(f.getName()))
				{npics.add(f.getName());}
		}
		
		return npics;
	}
	
	
	
	
}
