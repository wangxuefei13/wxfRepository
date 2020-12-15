package com.crm.dao;


import com.crm.entity.Customer;

public interface CustomerDao {
    int add(Customer customer);


    int delete(String[] ids);

    Customer getById(String id);

    int updateCust(Customer customer);
}
