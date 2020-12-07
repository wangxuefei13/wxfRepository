package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ActivityController {
    @Autowired
    private UserService userService;
    @RequestMapping("/getPersonList")
    public @ResponseBody List<User> getPersonList(){
        List<User> one = userService.getOne();
        System.out.println(one);
        return one;
    }
}
