package com.crm.controller;

import com.crm.entity.Activity;
import com.crm.service.ActivityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class ActivityController {
   @Resource(name = "activityService")
    private ActivityService activityService;
    @RequestMapping("/activityList")
    public ModelAndView activityList(){
        List<Activity> list = activityService.activityAll();
        ModelAndView mv = new ModelAndView();
        mv.addObject("list",list);
        mv.setViewName("index");
        return mv;
    }
}
