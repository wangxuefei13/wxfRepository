package com.crm.service.impl;

import com.crm.dao.PagingDao;
import com.crm.entity.Activity;
import com.crm.service.PagingService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class PagingServiceImpl implements PagingService {
    @Autowired
    private PaginationVO<Activity> vo;
    @Autowired
    private PagingDao pagingDao;
    @Override
    public PaginationVO<Activity> paging(Map<String, Object> map) {
        //获取dataList
        List<Activity> dataList = pagingDao.getActivityListByCondition(map);
        System.out.println("获取dataList"+dataList);
        //获取total
        int total = pagingDao.getTotalByCondition(map);
        //获取total和获取dataList封装到vo中
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }
}
