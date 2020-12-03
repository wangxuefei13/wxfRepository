package com.crm.service.impl;

import com.crm.dao.ActivityDao;
import com.crm.entity.Activity;
import com.crm.service.ActivityService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("activityService")
@Transactional
public class ActivityServiceImpl implements ActivityService {

    @Resource(name = "activityDao")
    private ActivityDao activityDao;
    @Override
    public List<Activity> activityAll() {
        return activityDao.activityAll();
    }
}
