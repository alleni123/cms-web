package com.lj.cms.dto;

/**
 * 专门用来返回Ajax</br>
 * Object obj用来存储放回的对象， int result和String message用来存储是否成功以及信息。</br>
 * 在界面层只要调用ajaxObj.obj.prop就行。
 * @author Administrator
 *
 */
public class AjaxObj {
	/**
	 * 0表示失败， 1表示成功
	 */
	private int result;
	
	/**
	 * 提示消息
	 */
	private String message;
	
	/**
	 * 附加对象， 用来存储一些特定的返回信息
	 */
	private Object obj;

	public int getResult() {
		return result;
	}
	
	/**
	 * @param result 0表示失败， 1表示成功
	 */
	public void setResult(int result) {
		this.result = result;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
	
	public AjaxObj() {
		this.result=1;
	}

	public AjaxObj(int result, String message, Object obj) {
		this.result = result;
		this.message = message;
		this.obj = obj;
	}

	public AjaxObj(int result, String message) {
		this.result = result;
		this.message = message;
	}

	public AjaxObj(int result) {
		super();
		this.result = result;
	}
	
	
	
}
