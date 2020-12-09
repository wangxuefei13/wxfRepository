package com.crm.service.impl;

import com.crm.LoginExc.LoginException;
import com.crm.dao.LoginDao;
import com.crm.entity.User;
import com.crm.service.LoginService;
import com.crm.utils.Constantstatement;
import com.crm.utils.DateTimeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginDao loginDao;

    @Override
    public User login(String loginAct, String loginPwd) throws LoginException {

        User user = loginDao.login(loginAct, loginPwd);
        //判断账户密码
        if (user==null){
            throw new LoginException(Constantstatement.EXCEPTION_MESSAGE);
        }
        //判断有效时间
        String expireTime = user.getExpireTime();
        String sysTime = DateTimeUtils.getSysTime();
        if (expireTime.compareTo(sysTime)<0){
            throw new LoginException(Constantstatement.EXPIRETIME_USER);
        }
        //判断锁定状态
        String lockState = user.getLockState();
        if ("0".equals(lockState)){
            throw new LoginException(Constantstatement.LOCKSTATE_USER);
        }

        return user;

    }
}
