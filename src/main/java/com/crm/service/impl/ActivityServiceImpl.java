package com.crm.service.impl;

import com.crm.dao.ActivityDao;
import com.crm.dao.ActivityRemarkDao;
import com.crm.dao.UserDao;
import com.crm.entity.Activity;
import com.crm.entity.User;
import com.crm.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityDao activityDao;
    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Autowired
    private UserDao userDao;

    /**
     * 添加
     * @param activity
     * @return
     */
    @Override
    public boolean save(Activity activity){
        boolean flag = true;
        int count =activityDao.save(activity);
        if (count!=1){
            flag = false;
        }
        return  flag;
        }

    /**
     * 删除
     * @param ids
     * @return
     */
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //查询出需要删除备注的数量
        int count1 = activityRemarkDao.getCountByAids(ids);
        //删除备注,返回受到影响的条数(实际删除的数量)
        int count2 = activityRemarkDao.deleteByAids(ids);
        if (count1!=count2){
            flag = false;
        }
        //删除市场活动
        int count3 = activityDao.delete(ids);

        if (count3!=ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> update(String id) {

        //取uList
        List<User> uList = userDao.getOne();
        //取a
        Activity a = activityDao.getById(id);
        //将uList和a打包到map中
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("a",a);
        //返回map
        return map;
    }

    @Override
    public boolean updateActivity(Activity activity) {
        boolean flag = true;
        int count =activityDao.updateActivity(activity);
        if (count!=1){
            flag = false;
        }
        return  flag;
    }

    @Override
    public Activity detail(String id) {
        Activity a = activityDao.detail(id);
        return a;
    }

}
