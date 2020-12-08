package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class CustomerController {
    @Autowired
    private UserService userService;

    /**
     * 查询所有者信息
     * @return
     */
    @RequestMapping("/getAuthority")
    public @ResponseBody List<User> personList(){
        List<User> one = userService.getOne();
        return one;
    }
    /**
     * 添加客户数据
     */





}
