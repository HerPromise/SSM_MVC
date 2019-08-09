package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.bean.Department;
import com.ssm.bean.Msg;
import com.ssm.service.DepartmentService;

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService deptService;

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department>list=deptService.getDepts();
		return Msg.success().add("depts",list);
	}
}
