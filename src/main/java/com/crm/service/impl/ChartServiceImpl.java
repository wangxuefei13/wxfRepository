package com.crm.service.impl;

import com.crm.dao.ChartDao;
import com.crm.service.ChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChartServiceImpl implements ChartService {

    @Autowired
    private ChartDao chartDao;

    @Override
    public Map<String, Object> chartquery() {
        //取得total
         int total = chartDao.getTotal();

         //取得dataList
         List<Map<String,Object>> dateList = chartDao.getCharts();
        System.out.println(dateList);
        System.out.println(total);
        //将total和dataList保存到map中
        HashMap<String, Object> map = new HashMap<>();
        map.put("total",total);
        map.put("dataList",dateList);
        return map;
    }
}
