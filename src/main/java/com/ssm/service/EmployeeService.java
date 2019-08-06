package com.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.bean.Emplovee;
import com.ssm.dao.EmploveeMapper;
@Service
public class EmployeeService {

	@Autowired
	EmploveeMapper emploveeMapper;
	
	public List<Emplovee> getAll() {
		return emploveeMapper.selectByExampleWithDept(null);
	}

}
