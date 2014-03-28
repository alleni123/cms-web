package com.lj.cms.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lj.basic.model.Pager;
import com.lj.basic.model.SystemContext;
import com.lj.basic.util.JsonUtil;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.auth.AuthMethod;
import com.lj.cms.dto.AjaxObj;
import com.lj.cms.dto.TopicDto;
import com.lj.cms.service.IAttachmentService;
import com.lj.cms.service.IChannelService;
import com.lj.cms.service.IIndexService;
import com.lj.cms.service.IKeywordService;
import com.lj.cms.service.ITopicService;
import com.lj.core.model.Attachment;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelTree;
import com.lj.core.model.Keyword;
import com.lj.core.model.Topic;
import com.lj.core.model.User;

@Controller
@AuthClass("login")
// 这里讲用户权限设置为login,也就是登录用户可以访问
@RequestMapping("/admin/topic")
public class TopicController
{

	@Autowired
	private ITopicService topicService;

	@Autowired
	private IChannelService channelService;

	@Autowired
	private IKeywordService keywordService;

	@Autowired
	private IAttachmentService attachmentService;

	@Autowired
	private IIndexService indexService;

	private final static List<String> imgTypes = Arrays.asList("jpg", "jpeg", "gif", "png");

	/**
	 * 通过栏目id和模糊查询关键字来查询topic列表。
	 * 
	 * @param con
	 *            关键字
	 * @param channel_id
	 *            栏目id requestParam(required=false)表示该参数不是必须要有的。这样不会报错
	 */
	@RequestMapping("/audits")
	@AuthMethod(role = "ROLE_PUBLISH")
	public String audits(@RequestParam(required = false) String title_con, @RequestParam(required = false) Integer channel_id, Model model, HttpSession session,
			HttpServletRequest req, String published)
	{
		System.out.println("title_con = " + title_con);
		System.out.println("channel_id =" + channel_id);
		if (published == null || published.equals(""))
		{
			session.setAttribute("published", 1);
		}
		else
		{
			session.setAttribute("published", Integer.valueOf(published));
		}
		initList(title_con, channel_id, model, session, 1, 1);
		return "topic/list";
	}

	@RequestMapping("/unaudits")
	@AuthMethod(role = "ROLE_PUBLISH")
	public String unaudits(@RequestParam(required = false) String title_con, @RequestParam(required = false) Integer channel_id, Model model, HttpSession session,
			HttpServletRequest req)
	{
		// model.addAttribute("published", "0");
		// req.setAttribute("published", "0");
		session.setAttribute("published", 0);
		initList(title_con, channel_id, model, session, 0, 1);
		return "topic/list";
	}

	// @RequestMapping(value="/listByPage/{pageOffset}/{tarPage}")
	// public String listByPage(Model model, @PathVariable Integer pageOffset,
	// @PathVariable Integer tarPage,
	// HttpSession session,@RequestParam(required=false) Integer both){
	// if(both!=null&&both==1){
	// session.removeAttribute("published");
	// }
	//
	// SystemContext.setPageOffset(pageOffset);
	// Pager<Topic>topics=topicService.findTopicsByStatus((Integer)session.getAttribute("published"));
	// model.addAttribute("datas",topics);
	// model.addAttribute("curPage", tarPage);
	// return "topic/list";
	//
	// }

	@RequestMapping(value = "/listByPage/{pageOffset}/{tarPage}")
	public String listByPage(Model model, @PathVariable Integer pageOffset, @PathVariable Integer tarPage, @RequestParam(required = false) String title_con,
			@RequestParam(required = false) Integer channel_id, HttpSession session, @RequestParam(required = false) Integer published,
			@RequestParam(required=false) Integer chosen_link)
	{
		SystemContext.setPageOffset(pageOffset);

		if (published == null)
		{
			published = (Integer) session.getAttribute("published");
		}

		if (published != null && published == 2)
		{
			session.removeAttribute("published");
			// Pager<Topic>datas=topicService.findPager();
			// model.addAttribute("datas", datas);
			// model.addAttribute("curPage", tarPage);
			initList(title_con, channel_id, model, session, 2, tarPage);
		}
		if (published != null && published == 0)
		{
			initList(title_con, channel_id, model, session, 0, tarPage);

		}
		if (published != null && published == 1)
		{
			initList(title_con, channel_id, model, session, 1, tarPage);
		}

		session.setAttribute("published", published);

		// 如果title和channel都不为空，则表示这次请求是用户的搜索请求。
		// 此时要加入用户自定义的request请求数据，这样@requestParam就有数值了。
		if (title_con != null && channel_id != null)
		{
			model.addAttribute("custom", "?title_con=" + title_con + "&&channel_id=" + channel_id);
		}

		return "topic/list";
	}

	private void initList(String title_con, Integer channel_id, Model model, HttpSession session, Integer status, Integer tarPage)
	{
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");

		// 检查一下用户是否是超级管理员， 是则显示所有文章，否则只显示自己的文章。
		boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
		if (isAdmin)
		{
			model.addAttribute("datas", topicService.find(channel_id, title_con, status));
		}
		else
		{
			User loginUser = (User) session.getAttribute("loginUser");
			model.addAttribute("datas", topicService.find(loginUser.getId(), channel_id, title_con, status));
		}

		if (title_con == null)
		{
			title_con = "";
		}

		SystemContext.removeOrder();
		SystemContext.removeSort();

		model.addAttribute("title_con", title_con);
		model.addAttribute("channel_id", channel_id);
		model.addAttribute("channels", channelService.listEnabledChannel());
		model.addAttribute("curPage", tarPage);

	}

	@RequestMapping("/changeStatus/{id}")
	@AuthMethod(role = "ROLE_AUDIT")
	public String changeStatus(@PathVariable int id, Integer status)
	{
		topicService.updateStatus(id);
		Topic t = topicService.load(id);

		if (topicService.isUpdateIndex(t.getChannel().getId()))
		{
			indexService.generateBody();
		}

		if (status == 1)
		{
			return "redirect:/admin/topic/unaudits";
		}
		else
		{
			return "redirect:/admin/topic/audits";
		}
	}

	/**
	 * 文章的删除只有发布人员才可以
	 */
	@RequestMapping("/delete/{id}")
	@AuthMethod(role = "ROLE_PUBLISH")
	public String delete(@PathVariable int id, Integer status)
	{
		Topic t = topicService.load(id);
		topicService.delete(id);

		if (topicService.isUpdateIndex(t.getChannel().getId()))
		{
			indexService.generateBody();
		}

		return status == 1 ? "redirect:/admin/topic/audits" : "redirect:/admin/topic/unaudits";
	}

	@RequestMapping("/audit")
	@AuthMethod(role = "ROLE_AUDIT")
	public void audit()
	{

	}

	// 60_文章管理 40分钟
	@RequestMapping("/treeAll")
	@AuthMethod(role = "ROLE_PUBLISH")
	public @ResponseBody
	List<ChannelTree> tree()
	{
		return channelService.generateTree();
	}

	@AuthMethod(role = "ROLE_PUBLISH")
	@RequestMapping(value = "/searchKeyword")
	public @ResponseBody
	List<String> searchKeyword(String term)
	{
		List<String> list = keywordService.listKeywordStringByCon(term);
		System.out.println(list);
		return keywordService.listKeywordStringByCon(term);
	}

	/**
	 * 视频64 25分钟写的， 感觉和上面是一样的效果。 @responsebody返回的就是json。 视频67 1小时3分钟写完
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	// 返回的是json类型的值， 而uplodify只能接受字符串
	public void upload(MultipartFile attach, HttpServletResponse res) throws IOException
	{
		res.setContentType("text/plain;charset=utf-8");
		AjaxObj obj;
		try
		{
			Attachment attachment = new Attachment();

			System.out.println(attach.getOriginalFilename());
			// 获取文件名的后缀
			String ext = FilenameUtils.getExtension(attach.getOriginalFilename());
			ext = ext.toLowerCase();

			attachment.setIsAttach(0);
			attachment.setIsIndexPic(0);
			attachment.setNewName(new Date().getTime() + "." + ext);
			attachment.setOriginalName(FilenameUtils.getBaseName(attach.getOriginalFilename()));
			attachment.setFilenameExtension(ext);
			attachment.setType(attach.getContentType());
			attachment.setTopic(null);
			attachment.setFileSize(attach.getSize());
			attachment.setIsImg(imgTypes.contains(ext) ? 1 : 0);// 视频里用了if
																// else语句

			attachmentService.add(attachment, attach.getInputStream());

			obj = new AjaxObj(1, null, attachment);
		}
		catch (IOException e)
		{
			obj = new AjaxObj(0, e.getMessage());
		}
		res.getWriter().write(JsonUtil.getInstance().obj2json(obj));
	}

	// 添加文章开始
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	// 这里用的值是cms-core的com.lj.core.model.RoleType里的Enum类型。
	public String add(Model model)
	{
		Topic t = new Topic();
		t.setPublishDate(new Date());
		

		TopicDto topicDto = new TopicDto(t);

		model.addAttribute("topicDto", topicDto);
		return "topic/add";

	}

	/**
	 * 添加文章
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(@Validated TopicDto topicDto, BindingResult br, String[] added_keywords, Integer[] aids, HttpSession session)
	{
		if (br.hasErrors())
		{
			return "topic/add";
		}
		Topic t = topicDto.getTopic();
		User loginUser = (User) session.getAttribute("loginUser");

		StringBuffer keys = new StringBuffer();

		if (added_keywords != null)
		{
			for (String k : added_keywords)
			{
				keys.append(k).append("|"); // 这里写成\\|的话会输入一个\进去。
				keywordService.addOrUpdate(k);
			}
		}

		t.setKeyword(keys.toString());
		topicService.add(t, topicDto.getChannel_id(), loginUser.getId(), aids);

		if (topicDto.getStatus() == 1 && topicService.isUpdateIndex(topicDto.getChannel_id()))
		{
			indexService.generateBody();
		}

		return "redirect:/jsp/common/addSuc2.jsp";

	}

	// 添加文章结束

	// 更新文章开始
	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	@AuthMethod(role = "ROLE_PUBLISH")
	// 这里用的值是cms-core的com.lj.core.model.RoleType里的Enum类型。
	public String update(@PathVariable int id, Model model)
	{
		Topic t = topicService.load(id);
		String keyword = t.getKeyword();
		String[] split_result=null;
		if (keyword != null && keyword.length() > 0)
		{
			 split_result = keyword.split("\\|");
		}
		// System.out.println(split_result);

		model.addAttribute("keywords", split_result);
		model.addAttribute("atts", attachmentService.listByTopic(id));

		t.setPublishDate(new Date());
		TopicDto topicDto = new TopicDto(t, t.getChannel().getId());

		model.addAttribute("topicDto", topicDto);
		model.addAttribute("channel_name", t.getChannel_name());
		return "topic/update";

	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(@Validated TopicDto topicDto, @PathVariable int id, BindingResult br, String[] added_keywords, Integer[] aids, HttpSession session)
	{
		if (br.hasErrors())
		{
			return "topic/update";
		}

		Topic update_topic = topicService.load(id);

		Topic t = topicDto.getTopic();

		StringBuffer keys = new StringBuffer();

		if (added_keywords != null)
		{
			for (String k : added_keywords)
			{
				keys.append(k).append("|"); // 这里不能用append("\\|"),否则会把\加进去。
				keywordService.addOrUpdate(k);
			}
		}

		t.setKeyword(keys.toString());

		update_topic.setKeyword(keys.toString());
		update_topic.setChannelPicId(t.getChannelPicId());
		update_topic.setContent(t.getContent());
		update_topic.setPublishDate(t.getPublishDate());
		update_topic.setRecommend(t.getRecommend());
		update_topic.setStatus(t.getStatus());
		update_topic.setSummary(t.getSummary());
		update_topic.setTitle(t.getTitle());

		topicService.update(update_topic, topicDto.getChannel_id(), aids);

		if (topicService.isUpdateIndex(topicDto.getChannel_id()))
		{
			indexService.generateBody();
		}

		return "redirect:/jsp/common/updateSuc.jsp";

	}

	// 更新文章结束

	@RequestMapping("/{id}")
	public String show(@PathVariable int id, Model model)
	{
		model.addAttribute(topicService.load(id));
		List<Attachment> atts=attachmentService.listAttachByTopic(id);
		
		model.addAttribute("atts", atts);
		return "topic/show";
	}

}
