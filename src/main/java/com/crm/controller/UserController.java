package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@RestController
public class UserController {
    @Autowired
    private UserService userService;
    @GetMapping("/personList")
    public @ResponseBody List<User> personList(){
        ModelAndView mv = new ModelAndView();
        List<User> one = userService.getOne();
        return one;
    }
}
