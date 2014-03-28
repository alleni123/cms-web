package com.lj.cms.dwr;

import javax.inject.Inject;

import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import com.lj.cms.service.IAttachmentService;
import com.lj.cms.service.ICmsLinkService;
import com.lj.cms.service.IGroupService;
import com.lj.cms.service.IIndexPicService;
import com.lj.cms.service.pic.IGalleryPicService;

@Service("dwrService")
public class DwrService implements IDwrService
{	
	@Autowired
	private IGroupService groupService;

	@Autowired
	private IAttachmentService attachmentService;
	
	@Autowired
	private IIndexPicService indexPicService;
	
	@Autowired
	private ICmsLinkService cmsLinkService;
	
	@Autowired
	private IGalleryPicService galleryPicService;
	
	

	 

	@Override
	public void addGroupChannel(int gid, int cid)
	{
		groupService.addGroupChannel(gid, cid);
	}

	@Override
	public void deleteGroupChannel(int gid, int cid)
	{
		groupService.deleteGroupChannel(gid, cid);

	}

	@Override
	public void updateIndexPic(int aid)
	{
		attachmentService.updateIndexPic(aid);
	}

	@Override
	public void updateAttachInfo(int aid)
	{
		attachmentService.updateAttachInfo(aid);
	}

	@Override
	public void deleteAttach(int aid)
	{
		attachmentService.delete(aid);
	}

	@Override
	public int updatePicPos(int id, int oldPos, int newPos)
	{
		return indexPicService.updatePos(id, oldPos, newPos);
	}

	@Override
	public int updateLinkPos(int id, int oldPos, int newPos)
	{
		
		return cmsLinkService.updatePos(id, oldPos, newPos);
	}

	@Override
	public void updateGalleryPicTitle(int id, String title)
	{
		galleryPicService.updateTitle(id,title);
	}

}
