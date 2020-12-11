package com.crm.controller;


import com.crm.LoginExc.LoginException;
import com.crm.entity.User;
import com.crm.entity.dic_value;
import com.crm.service.EnerService;
import com.crm.service.LoginService;
import com.crm.utils.Constantstatement;
import com.crm.utils.MD5UTils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
public class LoginController {
    @Autowired
    private LoginService loginService;
    @Autowired
    private EnerService enerService;
    @RequestMapping("/login")
    public String personList(HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam("loginAct") String loginAct, @RequestParam("loginPwd") String loginPwd) throws LoginException, ServletException, IOException {


        System.out.println("服务器处理缓存字典");
         Map<String, List<dic_value>> map = enerService.Dictionary();
        Set<String> set = map.keySet();

        for (String key:set
             ) {
            request.getSession().setAttribute(key,map.get(key));
            System.out.println(key);
        }
        System.out.println("缓存结束");

        String md5 = MD5UTils.getMD5(loginPwd);
        User user = null;


        try{
            user = loginService.login(loginAct, md5);



        }catch (LoginException e){
            String message = e.getMessage();
            request.setAttribute("msg",message);
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return null;
        }

        model.addAttribute("user", user);
        request.getSession().setAttribute(Constantstatement.SESSION_LOGIN_USER,user);
        return "redirect: /workbench/index.jsp";
    }
}
