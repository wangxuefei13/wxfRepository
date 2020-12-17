package com.crm.service;

import com.crm.entity.Contacts;
import com.crm.vo.PaginationVO;

import java.util.Map;

public interface ContactsService {

    boolean saveCts(Contacts contacts);

    PaginationVO<Contacts> paging(Map<String, Object> map);

    boolean delete(String[] ids);

    Map<String, Object> update(String id);

    boolean updateContactts(Contacts contacts);

    Contacts detail(String id);
}
