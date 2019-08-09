package com.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Emplovee;
import com.ssm.bean.Msg;
import com.ssm.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	/**
	 * ��ѯԱ������
	 * @return
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//��Ȼ���Ƿ�ҳ��ѯ
		//����PageHelper��ҳ���,pn��ҳ�룬5��ÿҳ����
		PageHelper.startPage(pn, 5);
		List<Emplovee>list=employeeService.getAll();
		//��װ��ѯ�������װ����ϸ�ķ�ҳ��Ϣ,5��������ʾ��ҳ��
		PageInfo page=new PageInfo(list,5);
		model.addAttribute("pageInfo",page);
		return "list";
	}
	
	@RequestMapping("/emps2")
	@ResponseBody
	public Msg getEmpsJson(@RequestParam(value="pn",defaultValue="1") Integer pn) {
		//��Ȼ���Ƿ�ҳ��ѯ
		//����PageHelper��ҳ���,pn��ҳ�룬5��ÿҳ����
		PageHelper.startPage(pn, 5);
		//System.out.println(pn);
		List<Emplovee>list=employeeService.getAll();
		//��װ��ѯ�������װ����ϸ�ķ�ҳ��Ϣ,5��������ʾ��ҳ��
		PageInfo page=new PageInfo(list,5);
		return Msg.success().add("pageInfo", page);
	}
	
}
