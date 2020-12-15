package com.crm.dao;

import com.crm.entity.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerPageDao {
    List<Customer> getCustomerListByCondition(Map<String, Object> map);
    int getTotalByCondition(Map<String, Object> map);
}
