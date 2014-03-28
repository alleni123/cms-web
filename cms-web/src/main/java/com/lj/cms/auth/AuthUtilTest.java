package com.lj.cms.auth;

import java.io.File;
import java.io.FilenameFilter;
import java.io.PrintStream;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.lj.core.model.CmsException;
import com.lj.core.model.Role;
import com.lj.core.model.RoleType;

public class AuthUtilTest
{

	/**
	 * 初始化系统的角色所访问的功能信息
	 * 
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Set<String>> initAuth(String package_name)
	{	
		//key是AuthMethod的值，比如ROLE_PUBLISH，base。 object是该key对应的具体方法，比如com.lj.cms.controller.TopicController.add等
		Map<String, Set<String>> auths = new HashMap<String, Set<String>>();

		// 首先要获取包里面的所有类
		String[] package_classes = getClassesByPackage(package_name);
		
		for(String class_name:package_classes){
			
			//应该为 LoginController.class, UserController.class这种格式
			//System.out.println(class_name);
		    
			//先要获取所有类的全名称，也就是package_name+类名
			//比如class_name==UserService.class,这里要转换成com.lj.service.UserService
			String name=package_name+"."+class_name.substring(0, class_name.lastIndexOf(".class"));
		//	System.out.println("name= "+name); //com.lj.service.UserService
			
			//得到了类的class对象
			try
			{
				Class clz=Class.forName(name);
				//continue表示只要是有AuthClass注解的，就不考虑了。
				//例如这里的LoginController就没有AuthClass注解，因为大家都应当有login的权限
				if(!clz.isAnnotationPresent(AuthClass.class)) continue;
			//	System.out.println("clz.getSimpleName()= "+clz.getSimpleName());   //AdminController
				
				//接下来这些没有被continue掉的，就是加了AuthClass注解的，就需要遍历其中的方法。
				Method[] methods=clz.getDeclaredMethods();
				/*
				 * 遍历method来判断每个method上面是否存在相应的AuthMethod注解。
				 * 如果存在，那就直接将这个方法存储到auths中。
				 * 如果不存在，就不存储。那就以为着该方法只有超级管理员能访问
				 */
				for(Method method:methods){
					//如果该方法没有被加入AuthMethod注解，那就continue掉。
					//没有加入表示只有超级管理员能访问，比如UserController中除了updateSelf,updatePswd以外都没加入AuthMethod,
					//因此那些没加注解的例如add,delete都只能被超级管理员访问
					if(!method.isAnnotationPresent(AuthMethod.class)) continue;
					
					//如果存在，那就获取这个AuthMethod的值
					AuthMethod am=method.getAnnotation(AuthMethod.class);
					
					//获取角色值，默认是base，这里可以被设置为RoleType等Enum类型的值， 如@AuthMethod(value='ROLE_ADMIN')
					String role=am.role();   //这里获得的是@AuthMethod(value="?")的value值
				//	System.out.println("am.role()= "+role);   //base, ROLE_ADMIN这种格式
					
					//验证一下auths里面是否已经有了这些。没有则新建一个HashSet,并将键(role)值(actions)对放入auths 
					Set<String> actions=auths.get(role);
					if(actions==null){
						actions=new HashSet<String>();
						auths.put(role, actions);
					}
					String action_name=name+"."+method.getName();
				//	System.out.println("action_name= "+action_name); //com.lj.cms.controller.UserController.showSelf这种格式
					actions.add(action_name);
				}
			}
			catch (ClassNotFoundException e)
			{
				// XXX Auto-generated catch block
				e.printStackTrace();
			}
		}

		return auths;
	}
	
	
	/**
	 * 根据package名, 获取class名称
	 * @param pname  package的名字，比如com.lj.service
	 * @return 所有类的名称，比如{"UserService.class","GroupService.class"}.
	 */
	private static String[] getClassesByPackage(String pname)
	{
		System.out.println(pname);
		String packagePath = pname.replace('.', '/');
		System.out.println(packagePath);
		
		
		// 获取当前class路径
		 
		String	path = AuthUtilTest.class.getClassLoader()
					.getResource(packagePath).getPath();
		 
		
		 

		File dir = new File(path);

		String[] files = dir.list(new FilenameFilter()
		{
			@Override
			public boolean accept(File dir, String name)
			{   
				//过滤掉没有以.class结尾的文件
				if (name.endsWith(".class"))
				{
					return true;
				}
				return false;
			}

		});

		System.out.println(path);
		return files;
	}

	public static void main(String[] args)
	{
		AuthUtilTest t = new AuthUtilTest();
//		String[] files=t.getClassesByPackage("com.lj.cms.controller");
//		String[] a=new String[]{"1","2"};
//		for(String f:files){
//		System.out.println(f);}
		
		//System.out.println(initAuth("com.lj.cms.controller"));
		Map<String,Set<String>> allAuths=t.initAuth("com.lj.cms.controller");
		
		Set<String> base=allAuths.get("base");
		System.out.println("base= "+base);
		
		
		Role role=new Role(1,"publisher",RoleType.ROLE_PUBLISH);
		
		System.out.println("publisher+ "+role.getRoleType().name());
		
		Role admin=new Role(2,"admin",RoleType.ROLE_ADMIN);
		
		System.out.println("admin+ "+admin.getRoleType().name());
		

	}
}
