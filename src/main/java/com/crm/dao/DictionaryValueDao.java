package com.crm.dao;

import com.crm.entity.dic_value;

import java.util.List;

public interface DictionaryValueDao {
    List<dic_value> getListByCode(String code);
}
