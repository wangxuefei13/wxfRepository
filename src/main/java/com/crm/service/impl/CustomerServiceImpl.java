package com.crm.service.impl;

import com.crm.dao.CustomerDao;
import com.crm.entity.Customer;
import com.crm.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;


    @Override
    public boolean add(Customer customer) {
        boolean flag = true;
        int count =customerDao.add(customer);

        if (count!=1){
            flag = false;
        }
        return flag;
    }
}
