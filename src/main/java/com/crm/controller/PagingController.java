package com.crm.controller;

import com.crm.entity.Activity;
import com.crm.service.PagingService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class PagingController {
    @Autowired
    private PagingService pagingService;
    @RequestMapping("/paging")
    public @ResponseBody PaginationVO<Activity> paging(String pageNo, String pageSize,
            @RequestParam(value = "name1", required = false) String name,
            @RequestParam(value = "owner1", required = false) String owner,
            @RequestParam(value = "startDate", required = false)String startDate,
            @RequestParam(value = "endDate", required = false)String endDate){
        int pageNo1 = Integer.valueOf(pageNo);
        int pageSize1 = Integer.valueOf(pageSize);
        //计算出略过的记录数
        int skipCount=(pageNo1-1)*pageSize1;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("startDate",startDate);
        map.put("endDate",endDate);
        map.put("skipCount",skipCount);
        map.put("pageSize1",pageSize1);
        PaginationVO<Activity> vo = pagingService.paging(map);
        return vo;
    }
}
