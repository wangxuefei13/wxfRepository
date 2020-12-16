package com.crm.service;

import com.crm.entity.Customer;

import java.util.Map;

public interface CustomerService {

    boolean add(Customer customer);


    boolean delete(String[] ids);

    Map<String, Object> update(String id);

    boolean updateCust(Customer customer);

    Customer detail(String id);
}
