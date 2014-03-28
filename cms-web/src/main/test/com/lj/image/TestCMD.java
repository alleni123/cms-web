package com.lj.image;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import org.junit.Test;

public class TestCMD
{
	
	@Test
	public void testSimpleCmd() throws IOException{
		String cmd="cmd /c dir c:\\";
		Process proc=Runtime.getRuntime().exec(cmd);
		
		BufferedReader br=new BufferedReader(new InputStreamReader(proc.getInputStream(),"utf-8"));
		String str=null;
		while((str=br.readLine())!=null){
			System.out.println(str);
		}
		
	}
	
	@Test
	public void testMySql() throws IOException{
		String cmd="cmd /c mysqldump -u alleni -p23315 mydb";
		Process proc=Runtime.getRuntime().exec(cmd);
		BufferedReader reader=new BufferedReader(new InputStreamReader(proc.getInputStream(),"utf-8"));
		
		BufferedWriter writer=new BufferedWriter(new FileWriter("d:/mydb.sql"));;
		
		String str=null;
		while((str=reader.readLine())!=null){
			System.out.println(str);
			writer.write(str);
			writer.newLine();
		}
	}
	@Test
	public void testResume() throws IOException{
		String cmd="cmd /c mysql -u alleni -p23315 mydb";
		Process proc=Runtime.getRuntime().exec(cmd);
		BufferedReader reader=new BufferedReader(new FileReader("d:/mydb.sql"));
		
		BufferedWriter writer=new BufferedWriter(new OutputStreamWriter(proc.getOutputStream()));;
		
		String str=null;
		while((str=reader.readLine())!=null){
			System.out.println(str);
			writer.write(str);
			writer.newLine();
		}
		writer.close();
		reader.close();
	}
}
