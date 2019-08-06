package dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssm.bean.Department;
import com.ssm.dao.DepartmentMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	/**
	 * 
	 */
	@Test
	public void testCRUD() {
		System.out.println(departmentMapper);
		departmentMapper.insertSelective(new Department(null,"开发部"));
		departmentMapper.insertSelective(new Department(null,"测试部"));
	}
}
