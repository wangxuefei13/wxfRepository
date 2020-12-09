package com.crm.service.impl;

import com.crm.dao.ActivityDao;
import com.crm.entity.Activity;
import com.crm.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityDao activityDao;

    @Override
    public boolean save(Activity activity){
        boolean flag = true;
        int count =activityDao.save(activity);
        if (count!=1){
            flag = false;
    }
        return  flag;
    }
}
