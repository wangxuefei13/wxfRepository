package com.crm.dao;

import com.crm.entity.Activity;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface PagingDao {
    List<Activity> getActivityListByCondition(Map<String, Object> map);
    int getTotalByCondition(Map<String, Object> map);
}
