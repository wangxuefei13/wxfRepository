package com.crm.dao;

import com.crm.entity.Contacts;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Repository
public interface ContactsDao {
    //添加
    int saveCts(Contacts contacts);

    List<Contacts> getContactsListByCondition(Map<String, Object> map);
    int getToByCondition(Map<String, Object> map);

    //删除
    int delete(String[] ids);


    Contacts getById(String id);

    int updateContacts(Contacts contacts);

    Contacts detail(String id);
}
