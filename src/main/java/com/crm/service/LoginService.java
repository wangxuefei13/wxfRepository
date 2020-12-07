package com.crm.service;

import com.crm.LoginExc.LoginException;
import com.crm.entity.User;

public interface LoginService {

    User login(String loginAct, String loginPwd) throws LoginException;

}
