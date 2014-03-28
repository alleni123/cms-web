package com.lj.cms.controller.pic;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.lj.basic.model.Pager;
import com.lj.basic.model.SystemContext;
import com.lj.basic.util.JsonUtil;
import com.lj.cms.dto.AjaxObj;
import com.lj.cms.service.pic.GalleryPicService;
import com.lj.cms.service.pic.IGalleryPicService;
import com.lj.core.model.User;
import com.lj.core.model.pic.GalleryPic;


/**
 * 导航->文章图片管理->图片信息管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/galleryPic")
public class GallaryPicController
{
	public final static String FILE_PATH="/resources/user/gallary";

	@Autowired
	private IGalleryPicService galleryPicService;
	
	@RequestMapping(value="/addGalleryPic",method=RequestMethod.GET)
	public String addGalleryPic(Model model){
		GalleryPic gp=new GalleryPic();
		gp.setStatus(1);
		model.addAttribute(gp);
		return "backend/gallery_pic/addGalleryPic";
	}
	
	@RequestMapping(value="/addGalleryPic",method=RequestMethod.POST)
	public String addGalleryPic(Model model,HttpServletRequest req){
		GalleryPic gp=new GalleryPic();
		gp.setStatus(1);
		model.addAttribute(gp);
		String[] pic_ids=req.getParameterValues("pic_id");
	
		return "backend/gallery_pic/list";
	}
	
	
	@RequestMapping(value="/list")
	public String list(Model model,HttpServletRequest req){
		req.setAttribute("curPage", 1);
		model.addAttribute("datas", galleryPicService.find());
		return "backend/gallery_pic/list";
	}
	
	@RequestMapping(value="/listByPage/{pageOffset}/{tarPage}")
	public String listByPage(Model model,@PathVariable Integer pageOffset, @PathVariable Integer tarPage){
		SystemContext.setPageOffset(pageOffset);
		
		Pager<GalleryPic>pics=galleryPicService.find();
		model.addAttribute("datas", pics);
		
		// res.setAttribute("curPage", tarPage);
		model.addAttribute("curPage",tarPage);
		 
		return "backend/gallery_pic/list";
	}
	
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	public String delete(@PathVariable int id){
		galleryPicService.delete(id);
		return "redirect:/admin/galleryPic/list";
	}
	
	@RequestMapping(value="/updateStatus/{id}",method=RequestMethod.GET)
	public String updateStatus(@PathVariable int id){
		galleryPicService.updateStatus(id);
		return "redirect:/admin/galleryPic/list";
	}
	
 
	
	
	@RequestMapping(value="/uploadGalleryPic",method=RequestMethod.POST)
	public void uploadGalleryPic(HttpSession session, HttpServletResponse res,
			MultipartFile pic) throws IOException{
		res.setContentType("text/plain;charset=utf-8");
		AjaxObj obj;
		
		String originalName=pic.getOriginalFilename();
		String newName=new Date().getTime()+"."+FilenameUtils.getExtension(originalName);
		String realPath=session.getServletContext().getRealPath("");
		
		//File f=new File(real)
		
		PrintWriter out=null;
		
		try
		{	
			//1. 获取文件信息，写入到resource中
			out=res.getWriter();
			
			
			//ImageIO.write(bi,"JPEG",new File(realPath+"/resources/user/gallary/"+newName));
			FileUtils.copyInputStreamToFile(pic.getInputStream(), new File(realPath+"/resources/user/gallery/"+newName));
			
			
			
			//2. 生成缩略图，放入temp中。
			BufferedImage bi=ImageIO.read(pic.getInputStream());
			double ufw=bi.getWidth();
			double ufh=bi.getHeight();
			Builder<BufferedImage> builder=Thumbnails.of(bi);
			
			builder.scale(150/ufh);
			
			builder.toFile(realPath+"/resources/user/gallery/thumbnail/"+newName);
			
			
			
			
			
			
			//3. 将文件信息写入数据库。
			String ext=FilenameUtils.getExtension(pic.getOriginalFilename()).toLowerCase();
			String title=FilenameUtils.getBaseName(pic.getOriginalFilename());
			
			GalleryPic gp=new GalleryPic();
			gp.setNewName(newName);
			gp.setOriginalName(FilenameUtils.getBaseName(pic.getOriginalFilename()));
			gp.setStatus(1);
			gp.setTitle(title);
			gp.setCreateDate(new Date());
			gp.setImgSize(pic.getSize());
			galleryPicService.add(gp);
			
			obj=new AjaxObj(1,null,gp);
			
		}
		catch (IOException e)
		{
			e.printStackTrace();
			obj=new AjaxObj(0,e.getMessage());
		}
		
		res.getWriter().write(JsonUtil.getInstance().obj2json(obj));
		
	}
	
}
