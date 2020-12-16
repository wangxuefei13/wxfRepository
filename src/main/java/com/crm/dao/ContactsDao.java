package com.crm.dao;

import com.crm.entity.Contacts;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Repository
public interface ContactsDao {
    int saveCts(Contacts contacts);
    
    int getToByCondition(Map<String, Object> map);

    List<Contacts> getContactsListByCondition(Map<String, Object> map);
}
