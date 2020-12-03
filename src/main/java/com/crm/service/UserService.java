package com.crm.service;

import com.crm.entity.User;

import java.util.List;

public interface UserService {
    public List<User> userAll();

    public User getOne(String id);



}
