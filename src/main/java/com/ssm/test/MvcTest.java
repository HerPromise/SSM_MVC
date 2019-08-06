package com.ssm.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ssm.bean.Emplovee;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet.xml"})
public class MvcTest {

	MockMvc mockMvc=null;
	
	@Autowired
	WebApplicationContext context;
	
	@Before
	public void initMockMvc() {
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		MvcResult mvcResult=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo page = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("��ǰҳ�룺"+page.getPageNum());
		System.out.println("��ҳ�룺"+page.getPages());
		System.out.println("�ܼ�¼����"+page.getTotal());
		System.out.println("��ҳ����Ҫ������ʾҳ�룺");
		int[]nums=page.getNavigatepageNums();
		for (int i : nums) {
			System.out.print(" "+i);
		}
		
		//��ȡԱ������
		List<Emplovee> list = page.getList();
		for (Emplovee emplovee : list) {
			System.out.println("ID:"+emplovee.getEmpId()+"\tName:"+emplovee.getEmpName());
		}
	}
}
