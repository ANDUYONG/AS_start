package com.myspring.startup.admin.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface AdminMemberController {

//	멤버리스트
	ModelAndView adminMemberList(HttpServletRequest request, HttpServletResponse response) throws Exception;
//	멤버상세
	ModelAndView adminMemberDetail(String cuId, HttpServletRequest request, HttpServletResponse response)
			throws Exception;

	

}
