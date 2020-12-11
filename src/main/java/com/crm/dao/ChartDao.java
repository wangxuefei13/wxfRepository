package com.crm.dao;


import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Resource
public interface ChartDao {
    int getTotal();

    List<Map<String, Object>> getCharts();
}
