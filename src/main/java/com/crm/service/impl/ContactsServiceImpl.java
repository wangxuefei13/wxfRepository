package com.crm.service.impl;

import com.crm.dao.ContactsDao;
import com.crm.entity.Contacts;
import com.crm.service.ContactsService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {
    @Autowired
    private PaginationVO<Contacts> vo;

    @Autowired
    private ContactsDao contactsDao;

    @Override
    public boolean saveCts(Contacts contacts) {
        boolean flag = true;
        int count =contactsDao.saveCts(contacts);
        if (count!=1){
            flag = false;
        }
        return flag;
    }

    @Override
    public PaginationVO<Contacts> paging(Map<String, Object> map) {
        System.out.println("进入service"+map);
        //获取dataList
        List<Contacts> dataList = contactsDao.getContactsListByCondition(map);
        System.out.println("获取dataList"+dataList);
        //获取total
        int total = contactsDao.getToByCondition(map);
        //获取total和获取dataList封装到vo中
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }
}
