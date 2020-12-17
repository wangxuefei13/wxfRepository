package com.crm.dao;

public interface DetailDao {
    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);
}
