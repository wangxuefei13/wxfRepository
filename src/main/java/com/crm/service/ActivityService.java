package com.crm.service;
import com.crm.entity.Activity;

import java.util.Map;

public interface ActivityService {
    boolean save(Activity activity);

    boolean delete(String[] ids);

    Map<String, Object> update(String id);

    boolean updateActivity(Activity activity);
}
