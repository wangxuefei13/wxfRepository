package com.crm.service;
import com.crm.entity.Activity;
public interface ActivityService {
    boolean save(Activity activity);

    boolean delete(String[] ids);
}
