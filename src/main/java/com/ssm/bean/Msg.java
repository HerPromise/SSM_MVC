package com.ssm.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

	private int code;
	
	private String msg;
	
	private Map<String,Object> map=new HashMap<String,Object>();

	
	public static Msg success() {
		Msg m=new Msg();
		m.setCode(200);
		m.setMsg("³É¹¦£¡");
		return m;
	}
	public static Msg fail() {
		Msg m=new Msg();
		m.setCode(500);
		m.setMsg("Ê§°Ü£¡");
		return m;
	}
	public Msg add(String key,Object value) {
		this.getMap().put(key,value);
		return this;
	}
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}
	
	
	
}
