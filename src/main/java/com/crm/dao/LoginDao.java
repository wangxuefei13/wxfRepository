package com.crm.dao;

import com.crm.entity.User;
import org.apache.ibatis.annotations.Param;

public interface LoginDao {

    User login(@Param("loginAct") String loginAct, @Param("loginPwd") String loginPwd);

}
