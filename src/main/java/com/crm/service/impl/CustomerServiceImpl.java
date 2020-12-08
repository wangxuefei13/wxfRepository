package com.crm.service.impl;

import com.crm.dao.CustomerDao;
import com.crm.entity.Customer;
import com.crm.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("CustomerService")
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerDao customerDao;
    @Override
    public List<Customer> getAuthority() {
        return customerDao.getAuthority();
    }
}
