package com.crm.dao;

import com.crm.domain.Account;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author zbh
 * @date 2020/10/29
 */
@Repository
public interface AccountDao {

    @Select("select * from account")
    public List<Account> findAll();

    @Insert("insert into account (name,money) values(#{name},#{money})")
    public void saveAccount(Account account);


}
