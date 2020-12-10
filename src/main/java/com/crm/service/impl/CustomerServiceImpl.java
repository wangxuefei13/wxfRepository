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
    public boolean addCustomer(Customer customer) {
        boolean succ = true;
        int count =customerDao.addCustomer(customer);
        if (count!=1){
            succ = false;
        }
        return  succ;
    }
}
