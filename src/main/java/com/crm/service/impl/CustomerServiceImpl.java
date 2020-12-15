package com.crm.service.impl;

import com.crm.dao.CustomerDao;
import com.crm.dao.UserDao;
import com.crm.entity.Customer;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;
    private UserDao userDao;

    @Override
    public boolean add(Customer customer) {
        boolean flag = true;
        int count =customerDao.add(customer);

        if (count!=1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;

        //删除市场活动
        int count3 = customerDao.delete(ids);

        if (count3!=ids.length){
            flag = false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> update(String id) {
        //取uList
        List<User> uList = userDao.getOne();
        //取a
        Customer a = customerDao.getById(id);
        //将uList和a打包到map中
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("a",a);
        System.out.println("我是马保国"+map);
        //返回map
        return map;
    }

    @Override
    public boolean updateCust(Customer customer) {
        boolean flag = true;
        int count =customerDao.updateCust(customer);
        if (count!=1){
            flag = false;
        }
        return  flag;
    }


}
