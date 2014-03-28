package com.lj.cms.dto;

import java.util.List;

 

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import com.lj.core.model.User;

public class UserDto {
	private int id;
	/**
	 * �û���¼���
	 */
	private String username;
	
	/**
	 * �û���¼����
	 */
	private String password;
	
	/**
	 * �û��ǳ�
	 */
	private String	nickname;
	
	/**
	 * �û������ַ
	 */
	private String	email;
	
	/**
	 * �û��ֻ�
	 */
	private String	phone;
	
	/**
	 * �û�״̬: 0��ʾͣ�ã� 1��ʾ����
	 */
	private int	status;
	
	
	/**
	 * ��ɫid
	 */
	private Integer[] roleIds;
	
	/**
	 * ��id
	 */
	private Integer[] groupIds;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	@NotEmpty(message="用户名不能为空")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@NotEmpty(message="用户密码不能为空")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Email(message="邮箱格式不正确")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Integer[] getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(Integer[] roleIds) {
		this.roleIds = roleIds;
	}

	public Integer[] getGroupIds() {
		return groupIds;
	}

	public void setGroupIds(Integer[] groupIds) {
		this.groupIds = groupIds;
	}
	
	public User getUser(){
		User u=new User();
		u.setId(this.id);
		u.setEmail(email);
		u.setNickname(nickname);
		u.setPassword(password);
		u.setPhone(phone);
		u.setStatus(status);
		u.setUsername(username);
		return u;
	}

	
	
	public UserDto(User user){
		this.setEmail(user.getEmail());
		this.setId(user.getId());
		this.setNickname(user.getNickname());
		this.setPassword(user.getPassword());
		this.setPhone(user.getPhone());
		this.setStatus(user.getStatus());
		this.setUsername(user.getUsername());
		
	}
	
	public UserDto(User user,Integer[] roleIds, Integer[] groupIds){
		this.setEmail(user.getEmail());
		this.setId(user.getId());
		this.setNickname(user.getNickname());
		this.setPassword(user.getPassword());
		this.setPhone(user.getPhone());
		this.setStatus(user.getStatus());
		this.setUsername(user.getUsername());
		this.setGroupIds(groupIds);
		this.setRoleIds(roleIds);
		
	}
	
	public UserDto(User user,List<Integer> roleIds,List<Integer> groupIds) {
		this.setEmail(user.getEmail());
		this.setId(user.getId());
		this.setNickname(user.getNickname());
		this.setPassword(user.getPassword());
		this.setPhone(user.getPhone());
		this.setStatus(user.getStatus());
		this.setUsername(user.getUsername());
		this.setGroupIds(list2Array(groupIds));
		this.setRoleIds(list2Array(roleIds));
	}
	
	private Integer[] list2Array(List<Integer> datas) {
		Integer[] nums = new Integer[datas.size()];
		for(int i=0;i<datas.size();i++) {
			nums[i] = datas.get((int)i);
		}
		return nums;
	}
	
	public UserDto(){
		
	}
	
	 
	
	
	
}
