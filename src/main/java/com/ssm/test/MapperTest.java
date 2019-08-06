package com.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.bean.Emplovee;
import com.ssm.dao.DepartmentMapper;
import com.ssm.dao.EmploveeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmploveeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;

	
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
//		for(;;) {
//			employeeMapper.insertSelective(new Emplovee(null,"Tom","M",1));
//		}
		
		EmploveeMapper emploveeMapper=sqlSession.getMapper(EmploveeMapper.class);
		for(int i=0;i<1000;i++)
		{
			String uid=UUID.randomUUID().toString().substring(0,5)+i;
			employeeMapper.insertSelective(new Emplovee(null,uid,"M",1));
		}
		System.out.println("批量完成");
	}
}
