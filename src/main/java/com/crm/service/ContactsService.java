package com.crm.service;

import com.crm.entity.Contacts;
import com.crm.vo.PaginationVO;

import java.util.Map;

public interface ContactsService {

    boolean saveCts(Contacts contacts);

    PaginationVO<Contacts> paging(Map<String, Object> map);
}
