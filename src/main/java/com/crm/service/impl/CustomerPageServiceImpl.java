package com.crm.service.impl;


import com.crm.dao.CustomerPageDao;
import com.crm.entity.Customer;
import com.crm.service.CustomerPageService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CustomerPageServiceImpl implements CustomerPageService {
    @Autowired
    private PaginationVO<Customer> vo;
    @Autowired
    private CustomerPageDao customerPageDao;
    @Override
    public PaginationVO<Customer> paging(Map<String, Object> map) {
//        System.out.println("进入CustomerPageService"+map);
        //获取dataList
        List<Customer> dataList = customerPageDao.getCustomerListByCondition(map);
//        System.out.println("获取dataList"+dataList);
        //获取total
        int total = customerPageDao.getTotalByCondition(map);
        //获取total和获取dataList封装到vo中
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

}
