package com.lj.cms.web;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import com.lj.core.model.BaseInfo;

public class BaseInfoUtil
{
	private static BaseInfoUtil biu;

	private static Properties prop;

	private BaseInfoUtil() throws IOException
	{
		if (prop == null)
		{
			prop = new Properties();
			prop.load(BaseInfoUtil.class.getClassLoader().getResourceAsStream(
					"baseinfo.properties"));
		}
	}

	public static BaseInfoUtil getInstance()
	{

		try
		{
			if (biu == null)
			{
				biu = new BaseInfoUtil();
			}
			return biu;
		}
		catch (IOException e)
		{
			// XXX Auto-generated catch block 
			e.printStackTrace();
		}
		return null;
	}
	
	public BaseInfo read(){
		BaseInfo bi=new BaseInfo();
		bi.setAddress(prop.getProperty("address"));
		bi.setEmail(prop.getProperty("email"));
		bi.setName(prop.getProperty("name"));
		bi.setPhone(prop.getProperty("phone"));
		bi.setZipCode(prop.getProperty("zipCode"));
		bi.setRecordCode(prop.getProperty("recordCode"));
		bi.setIndexPicNumber(Integer.parseInt(prop.getProperty("indexPicNumber")));
		bi.setIndexChannelNumber(Integer.parseInt(prop.getProperty("indexChannelNumber")));
		
		String picSize=prop.getProperty("indexPicSize");
		String[] picSizes=picSize.split("\\*");
		bi.setIndexPicWidth(Integer.parseInt(picSizes[0]));
		bi.setIndexPicHeight(Integer.parseInt(picSizes[1]));
		
		return bi;
	}

	public BaseInfo write(BaseInfo bi){
		FileOutputStream fos=null;
		
		try
		{
			prop.setProperty("address", bi.getAddress());
			prop.setProperty("email", bi.getEmail());
			prop.setProperty("name", bi.getName());
			prop.setProperty("phone", bi.getPhone());
			prop.setProperty("recordCode", bi.getRecordCode());
			prop.setProperty("zipCode",bi.getZipCode());
			prop.setProperty("indexPicSize", bi.getIndexPicWidth()+"*"+bi.getIndexPicHeight());
			String path=BaseInfoUtil.class.getClassLoader().getResource("baseinfo.properties").getFile();
			fos=new FileOutputStream(path);
			prop.store(fos, null);
			return bi;
		}
		catch (FileNotFoundException e)
		{
			// XXX Auto-generated catch block
			e.printStackTrace();
		}
		catch (IOException e)
		{
			// XXX Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			if(fos!=null)
				try
				{
					fos.close();
				}
				catch (IOException e)
				{
					// XXX Auto-generated catch block
					e.printStackTrace();
				}
		}
		
		
		return null;
	}
}
