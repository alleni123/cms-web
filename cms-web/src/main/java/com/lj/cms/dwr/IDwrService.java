package com.lj.cms.dwr;

public interface IDwrService {
	/**
	 * 添加GroupChannel对象
	 * 
	 * @param gid
	 * @param cid
	 */
	public void addGroupChannel(int gid, int cid);
	
	
	/**
	 * 删除组栏目
	 */
	public void deleteGroupChannel(int gid, int cid);

	
	/**
	 * 更新附件的主页图片状态
	 * @param aid attachment id
	 */
	public void updateIndexPic(int aid);

	/**
	 * 更新附件
	 * @param aid attachment id
	 */
	public void updateAttachInfo(int aid);
	
	/**
	 * 删除附件
	 * @param aid attachment id
	 */
	public void deleteAttach(int aid);
	
	public int updatePicPos(int id, int oldPos, int newPos);
	
	public int updateLinkPos(int id, int oldPos, int newPos);
	
	
	/**
	 * 更新图片标题
	 */
	public void updateGalleryPicTitle(int id, String title);
}
