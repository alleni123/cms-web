package com.lj.cms.auth;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**
 * 用来确定哪些方法由哪些角色访问<br/>
 * 属性有一个role： 如果role的值为base，表示这个方法可以被所有的登录用户访问.<br/>
 * 如果为ROLE_PUBLISH,表示只能为文章发布人员访问.<br/>
 * 如果某个方法中没有加入AuthMethod,就表示该方法只能被管理员所访问<br/>
 * 默认值为base<br/>
 * @author Administrator
 *
 */
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthMethod {
	public String role() default "base";
}
