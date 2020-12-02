package com.crm.service.impl;


import com.crm.dao.AccountDao;
import com.crm.domain.Account;
import com.crm.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author zbh
 * @date 2020/10/29
 */
@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao accountDao;

    @Override
    public List<Account> findAll() {
        System.out.println("业务层:查询所有信息");
        return accountDao.findAll();
    }

    @Override
    public void saveAccount(Account account) {
        System.out.println("业务层:保存账户");
        accountDao.saveAccount(account);
    }
}
