package com.lj.cms.service;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lj.basic.model.SystemContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class TestIndexService
{	
	private String rp="D:\\konghaoShopping\\cms-web\\src\\main\\webapp";
	
	@Inject
//	private IIndexService indexService;
	
	@Test
	public void testGenerateBody(){
	 	SystemContext.setRealPath(rp);
	 //	indexService.generateBody();
	}
}
