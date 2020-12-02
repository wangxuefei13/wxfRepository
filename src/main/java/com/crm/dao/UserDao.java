package com.crm.dao;

import com.crm.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
@Mapper
public interface UserDao {
    public List<User> userAll();

    public User getOne(String id);
}
