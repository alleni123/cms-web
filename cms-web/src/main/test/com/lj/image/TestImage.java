package com.lj.image;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.imageio.ImageIO;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import net.coobird.thumbnailator.geometry.Positions;

import org.junit.Test;

import com.lj.basic.model.SystemContext;

public class TestImage
{

	@Test
	public void test01()
	{
		try
		{
			Thumbnails.of(new File("d:/1.jpg")).size(360, 360)
					.toFile(new File("d:/hello.jpg"));

		}
		catch (Exception e)
		{
			// XXX: handle exception
		}
	}

	@Test
	public void test02()
	{
		try
		{
			Thumbnails
					.of(new File("d:/1.jpg"))
					.size(360, 360)
					.rotate(90)
					.watermark(Positions.BOTTOM_RIGHT,
							ImageIO.read(new File("d:/psb.jpg")), 0.5f)
					.toFile(new File("d:/hello.jpg"));

		}
		catch (Exception e)
		{
			// XXX: handle exception
		}
	}

	@Test
	public void test03()
	{
		try
		{
			Thumbnails
					.of(new File("d:/1.jpg"))
					.scale(0.3f) 
					.toFile(new File("d:/hello.jpg"));

		}
		catch (Exception e)
		{
			// XXX: handle exception
		}
	}
	
	@Test
	public void test04(){
		 try
		{
			BufferedImage bi=Thumbnails.of(new FileInputStream("d:/1.jpg")).scale(2.0f).asBufferedImage();
			System.out.println(bi.getWidth());
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
	}
	
	@Test
	public void test05() throws IOException{
		System.out.println((double)900/(double)2000);
		
		String realPath=SystemContext.getRealPath();
		System.out.println(realPath);
		BufferedImage oldBi=ImageIO.read(new File("d:/_thumbnail/01.jpg"));
		System.out.println(oldBi.getHeight());
		int width = oldBi.getWidth();
		if(width>900){
			
			Thumbnails.of(oldBi).scale((double)900/(double)width).toFile(new File("d:/_thumbnail/1w.jpg"));
		}
	}
	
	@Test
	public void test06(){
		int width=900;
		int thumb=100;
		try
		{
			BufferedImage bi=ImageIO.read(new File("d:/_thumbnail/01.jpg"));
			
			Builder<BufferedImage>builder=Thumbnails.of(bi);
			builder.scale((double)width/(double)bi.getWidth())
					.toFile(new File("d:/_thumbnail/scale.jpg"));
			
			Builder<BufferedImage> builder2=Thumbnails.of(bi);
			
			BufferedImage bi2=builder2.scale((thumb*1.2)/bi.getWidth()).asBufferedImage();
			Thumbnails.of(bi2).scale(1.0f).sourceRegion(Positions.CENTER,100,80).toFile(new File("d:/_thumbnail/region.jpg"));
		}
		catch (IOException e)
		{
			// XXX Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	
}
