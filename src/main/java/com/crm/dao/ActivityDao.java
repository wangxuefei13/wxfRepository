package com.crm.dao;

import com.crm.entity.Activity;


public interface ActivityDao {

    //添加
    int save(Activity activity);

    int delete(String[] ids);

    Activity getById(String id);

    int updateActivity(Activity activity);

    Activity detail(String id);
}
