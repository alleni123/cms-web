package com.lj.cms.auth;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;


/**
 * 只要在Controller上增加了这个方法的类， 都需要进行权限的控制</br>
 * 根据value是login还是admin，来决定这个类是由管理员访问还是都可以访问。
 * 默认值是admin，也就是只有超级管理员可以访问
 * @author Administrator
 *
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthClass {
	
	/**
	 * 如果value为admin 就表示这个类只能超级管理员访问。</br>
	 * 如果value为login，就表示这个类中的方法， 某些可能为相应的角色访问
	 * 默认为admin
	 * @return
	 */
	public String value() default "admin";
}
