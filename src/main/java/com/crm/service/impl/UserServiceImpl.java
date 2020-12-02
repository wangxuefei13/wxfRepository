package com.crm.service.impl;

import com.crm.dao.UserDao;
import com.crm.entity.User;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Override
    public List<User> userAll() {
        return userDao.userAll();
    }

    @Override
    public User getOne(String id) {

        return userDao.getOne(id);
    }
}
