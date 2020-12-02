package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;


@RestController
public class UserController {
    @Autowired
    private UserService userService;
    @GetMapping("/personList/{id}")
    public ModelAndView personList(@PathVariable("id") String id){
        ModelAndView mv = new ModelAndView();
        User one = userService.getOne(id);
        System.out.println(one);
        mv.setViewName("list");
        mv.addObject("user",one);

        return mv;
    }
}
