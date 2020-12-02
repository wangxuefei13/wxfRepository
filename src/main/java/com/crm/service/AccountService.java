package com.crm.service;



import com.crm.domain.Account;

import java.util.List;

/**
 * @author zbh
 * @date 2020/10/29
 */
public interface AccountService {

    public List<Account> findAll();

    public void saveAccount(Account account);

}
