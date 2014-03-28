package com.lj.cms.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lj.basic.util.JsonUtil;
import com.lj.cms.dto.AjaxObj;
import com.lj.cms.dto.IndexPicDto;
import com.lj.cms.service.IAttachmentService;
import com.lj.cms.service.IIndexPicService;
import com.lj.cms.service.IIndexService;
import com.lj.core.model.BaseInfo;
import com.lj.core.model.IndexPic;


/**
 * 导航->系统配置->首页图片管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/pic")
public class IndexPicController
{	
	public final static String FILE_PATH="/resources/indexPic";
	public final static int T_W = 120;
	
	@Autowired
	private IIndexPicService indexPicService;
	
	
	@Autowired
	private IAttachmentService attachmentService;
	@Autowired
	private IIndexService indexService;
	
	
	@RequestMapping("/indexPics")
	public String listIndexPic(Model model){
		Map<String,Integer>mm=indexPicService.getMaxAndMinPos();
		model.addAttribute("min", mm.get("min"));
		model.addAttribute("max", mm.get("max"));
		model.addAttribute("datas",indexPicService.findIndexPic());
		 
		return "pic/listIndexPic";
	
	}
	
	
	
	@RequestMapping(value="/addIndexPics",method=RequestMethod.GET)
	public String addIndexPic(Model model){
		IndexPic ip=new IndexPic();
		ip.setStatus(1);
		model.addAttribute(ip);
		return "pic/addIndexPic";
	}
	
	
	
	@RequestMapping(value="/addIndexPics",method=RequestMethod.POST)
	public String addIndexPic(@Validated IndexPic indexPic, BindingResult br){
		indexPicService.add(indexPic);
		if(indexPic.getStatus()!=0){
			indexService.generateBody();
		}
		return "redirect:/jsp/common/addSuc2.jsp";
	}
	
	
	
	@RequestMapping(value="/indexPic/{id}")
	public String showIndexPic(@PathVariable int id,Model model){
		model.addAttribute(indexPicService.load(id));
		return "pic/showIndexPic";
	}
	
	
	
	@RequestMapping("/deleteIndexPic/{id}")
	public String deleteIndexPic(@PathVariable int id){
		indexPicService.delete(id);
		indexService.generateBody();
		return "redirect:/admin/pic/indexPics";
	}
	
	
	
	@RequestMapping("/updateIndexPicStatus/{id}")
	public String updateIndexPicStatus(@PathVariable int id){
		indexPicService.updateStatus(id);
		return "redirect:/admin/pic/indexPics";
	}
	
	
	
	@RequestMapping(value="/updateIndexPic/{id}",method=RequestMethod.GET)
	public String updateIndexPic(@PathVariable int id,Model model){
		IndexPic pic=indexPicService.load(id);
		model.addAttribute(pic);
		return "pic/updateIndexPic";
	}
	
	
	
	@RequestMapping(value="/updateIndexPic/{id}",method=RequestMethod.POST)
	public String updateIndexPic(@PathVariable int id,IndexPic pic,BindingResult br){
		if(br.hasErrors()){
			return "pic/updateIndexPic";
			
		}
		
		IndexPic _pic=indexPicService.load(id);
		_pic.setNewName(pic.getNewName());
		_pic.setOriginalName(pic.getOriginalName());
		_pic.setStatus(pic.getStatus());
		_pic.setSubTitle(pic.getSubTitle());
		_pic.setLinkType(pic.getLinkType());
		_pic.setLinkUrl(pic.getLinkUrl());
		_pic.setTitle(pic.getTitle());
		indexPicService.update(_pic);
		indexService.generateBody();
		return "redirect:/admin/pic/indexPics";
	}
	
	/**
	 *
	 * @param session 为了通过ServletContext来获取baseinfo的首页图片宽度和高度的信息。 ServletContext是全局信息。
	 * @param res
	 * @param pic
	 */
	@RequestMapping(value="/uploadIndexPic",method=RequestMethod.POST)
	public void uploadIndexPic(HttpSession session, HttpServletResponse res, MultipartFile pic){
		System.out.println(pic.getName());
		res.setContentType("text/plain;charset=utf-8");
		
		String originalName=pic.getOriginalFilename();
		String newName=new Date().getTime()+"."+FilenameUtils.getExtension(originalName);
		String realPath=session.getServletContext().getRealPath(""); //D:\konghaoShopping\cms-web\src\main\webapp
		
		File f=new File(realPath+"/resources/indexPic/temp");
		if(!f.exists()){
			f.mkdirs();
		}
		
		//out is used for sending AjaxObj back to client
		PrintWriter out=null;
		AjaxObj ao=new AjaxObj();
		  
		try
		{
			out=res.getWriter();
			BaseInfo baseInfo=(BaseInfo) session.getServletContext().getAttribute("baseInfo");
			double w=baseInfo.getIndexPicWidth();
			double h=baseInfo.getIndexPicHeight();
			BufferedImage bi=ImageIO.read(pic.getInputStream());
			
			//uploaded file width
			double ufw=bi.getWidth();
			//uploaded file height
			double ufh=bi.getHeight();
			//这里w为490，h为120.  也就是要传图片宽度大于490，且宽高比小于4:1的。
			if(ufw>w&&(ufw/ufh<w/h)){
				//图片大小符合要求
				Builder<BufferedImage> builder=Thumbnails.of(bi);
				if(ufw-w>150){
					builder.scale((w+150)/ufw);
				}else{
					builder.scale(1.0);
				}
				BufferedImage bi2=builder.asBufferedImage();
				
				builder.toFile(realPath+"/resources/indexPic/temp/"+newName);
				
//				IndexPic indexPic=new IndexPic();
//				indexPic.setOriginalName(originalName);
//				indexPic.setNewName(newName);
				
				IndexPicDto indexPicDto=new IndexPicDto();
				indexPicDto.setOriginalName(originalName);
				indexPicDto.setNewName(newName);
				indexPicDto.setIndexPicHeight(new Double(h).intValue());
				indexPicDto.setIndexPicWidth(new Double(w).intValue());
				indexPicDto.setImgWidth(bi2.getWidth());
				indexPicDto.setImgHeight(bi2.getHeight());
				
				//上传成功就把IndexPic对象放入AjaxObj，并设定result为1
				ao.setObj(indexPicDto);
				ao.setResult(1);
				
			} 
			else{
				ao.setResult(0);
				
				if(ufw<w){
				ao.setMessage("不能上传，图片宽度不能小于 "+w+"px");}
				else if(ufw/ufh>w/h){
					ao.setMessage("不能上传，图片宽高比不能大于"+w/h);
				}else{
					ao.setMessage("不能上传，请检查图片尺寸和比例");
				}
				
			}
			
		}
		catch (IOException e)
		{
			ao.setResult(0);
			ao.setMessage(e.getMessage());
		}
		
		out.println(JsonUtil.getInstance().obj2json(ao));
	}
	
	
	/**
	 *  接受被裁剪出来的首页图片
	 * @param x 横坐标
	 * @param y 纵坐标
	 * @param w 宽度
	 * @param h 高度
	 */
	@RequestMapping(value="/confirmPic",method=RequestMethod.GET)
	public @ResponseBody AjaxObj confirmPic(HttpSession session,int x, int y, int w, int h,String newName){
		AjaxObj ao=new AjaxObj();
	
		try
		{	
			BaseInfo baseInfo=(BaseInfo) session.getServletContext().getAttribute("baseInfo");
			int pw=baseInfo.getIndexPicWidth(); //490
			int ph=baseInfo.getIndexPicHeight(); //120
			
			
			String path=session.getServletContext().getRealPath(""); //D:\konghaoShopping\cms-web\src\main\webapp
			String tempPath=path+FILE_PATH+"/temp/"+newName;  //D:\konghaoShopping\cms-web\src\main\webapp/resources/indexPic/temp/1389873866208.jpg
			File tempFile=new File(tempPath);
			String newPath=path+FILE_PATH+"/"+newName;
			BufferedImage bi=ImageIO.read(tempFile);
			
			Builder<BufferedImage> builder=Thumbnails.of(bi);
			
			//写原图
			
			
			String thumb_path=path+FILE_PATH+"/thumbnail";  //D:\konghaoShopping\cms-web\src\main\webapp/resources/indexPic/thumbnail1389874296543.jpg
			BufferedImage bi2=builder.sourceRegion(x,y,w,h).size(pw, ph).asBufferedImage();
			builder.toFile(newPath);
		
			
			//写缩略图
			File f=new File(thumb_path);
			if(!f.exists()){
				f.mkdirs();
			}
			thumb_path+="/"+newName;
			
			Thumbnails.of(bi2).scale((double)T_W/(double)pw).toFile(thumb_path);
			tempFile.delete();
			ao.setResult(1);
			return ao;
			
			
		}
		catch (IOException e)
		{
			ao.setResult(0);
			ao.setMessage(e.getMessage());
		}
		return null;
	}
	
	
	
	@RequestMapping("/newsPics")
	public String listNewPic(Model model){
		model.addAttribute("datas",attachmentService.listAllPic());
		 
		return "pic/listNewsPic";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
