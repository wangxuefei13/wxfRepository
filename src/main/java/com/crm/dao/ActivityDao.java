package com.crm.dao;

import com.crm.entity.Activity;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("activityDao")
public interface ActivityDao {
    public List<Activity> activityAll();
}
