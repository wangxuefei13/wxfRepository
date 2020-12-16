package com.crm.controller;

import com.crm.entity.Customer;
import com.crm.service.CustomerPageService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class CustomerPage {
    @Autowired
    private CustomerPageService customerPageService;
    @RequestMapping("/pageListe")
    public @ResponseBody PaginationVO<Customer> cust(String pageNo, String pageSize,
                                                     @RequestParam(value = "name",required = false)String name,
                                                     @RequestParam(value = "owner",required = false)String owner,
                                                     @RequestParam(value = "phone",required = false)String phone,
                                                     @RequestParam(value = "website",required = false)String website){
        int pageNo1 = Integer.valueOf(pageNo);
        int pageSize1 = Integer.valueOf(pageSize);
        //计算出略过的记录数
        int skipCount=(pageNo1-1)*pageSize1;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("phone",phone);
        map.put("website",website);
        map.put("skipCount",skipCount);
        map.put("pageSize1",pageSize1);
        PaginationVO<Customer> vo = customerPageService.paging(map);
        return vo;

    }

}
