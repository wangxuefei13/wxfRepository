package com.crm.controller;


import com.crm.service.ChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class ChartController {
    @Autowired
    private ChartService chartService;

    @RequestMapping("/chart")
    @ResponseBody
    public Map<String, Object> chart() {
        System.out.println("进入chart");
        System.out.println("取图文数据");
        Map<String,Object> map = chartService.chartquery();
        return map;
    }

}
