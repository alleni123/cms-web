package com.lj.cms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lj.cms.service.ICommentService;



@Controller
@RequestMapping("/admin/comment")
public class CommentController
{
	@Autowired
	private ICommentService commentService;
	
	
	@RequestMapping("/list")
	public String list(Model model){
		return "backend/comment/list";
	}
}
