package com.lj.cms.auth;

import java.io.File;
import java.io.FilenameFilter;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.directwebremoting.annotations.Auth;

public class AuthUtil {

	/**
	 * 初始化系统的角色所访问的功能信息
	 * 
	 * @return
	 * @throws ClassNotFoundException
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Set<String>> initAuth(String pname) {
		Map<String, Set<String>> auths = new HashMap<String, Set<String>>();

		String[] ps = getClassByPackage(pname);

		for (String p : ps) {

			String pc = pname + "." + p.substring(0, p.lastIndexOf(".class"));
			// System.out.println("pc=" +pc);

			// 得到了类的class对象
			try {
				Class clz = Class.forName(pc);
				if (!clz.isAnnotationPresent(AuthClass.class))
					continue;
				System.out.println(pc);
				// 获取每个类中的方法，以此确定哪些角色可以访问哪些方法
				Method[] methods=clz.getDeclaredMethods();
				
				/**
				 * 遍历method 来判断每个method上面是否存在相应的method
				 * 如果存在， 就直接将这个方法直接存储到auths中。不存在就不存储
				 * 不存储就意味着该方法
				 */
				for( Method m:methods){
					if(!m.isAnnotationPresent(AuthMethod.class))continue;
					//如果存在就要获取这个Annotation
					AuthMethod authMethod=m.getAnnotation(AuthMethod.class);
					String role=authMethod.role();
					System.out.println("role= "+role);
					Set<String> actions=auths.get(role);
					
					if((actions==null)){
						actions=new HashSet<String>();
						auths.put(role, actions);
					}
					
					actions.add(pc+"."+m.getName());
					 
				}

			} catch (ClassNotFoundException e) {
				// XXX Auto-generated catch block
				e.printStackTrace();
			}

		}

		return auths;
	}

	public static String[] getClassByPackage(String pname) {
		String packageRename = pname.replace(".", "/");
		String pakPath = AuthUtil.class.getClassLoader()
				.getResource(packageRename).getPath();
		File file = new File(pakPath);
		String[] files = file.list(new FilenameFilter() {

			@Override
			public boolean accept(File dir, String name) {
				// XXX Auto-generated method stub
				if (name.endsWith(".class"))
					return true;
				return false;
			}

		});
		return files;
	}

	public static void main(String[] args) {
		System.out.println(AuthUtil.initAuth("com.lj.cms.controller"));
	}
}
