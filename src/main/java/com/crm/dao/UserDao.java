package com.crm.dao;

import com.crm.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface UserDao {
    List<User> getOne();

    //List<User> getUserList();
}
