package com.crm.service.impl;

import com.crm.dao.ContactsDao;
import com.crm.dao.DetailDao;
import com.crm.dao.UserDao;
import com.crm.entity.Contacts;
import com.crm.entity.User;
import com.crm.service.ContactsService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {
    @Autowired
    private PaginationVO<Contacts> vo;

    @Autowired
    private DetailDao detailDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private ContactsDao contactsDao;

    /**
     * 添加
     * @param contacts
     * @return
     */
    @Override
    public boolean saveCts(Contacts contacts) {
        boolean flag = true;
        int count =contactsDao.saveCts(contacts);
        if (count!=1){
            flag = false;
        }
        return flag;
    }

    /**
     * 查询
     * @param map
     * @return
     */
    @Override
    public PaginationVO<Contacts> paging(Map<String, Object> map) {
        //System.out.println("进入service"+map);
        //获取dataList
        List<Contacts> dataList = contactsDao.getContactsListByCondition(map);
        //System.out.println("获取dataList"+dataList);
        //获取total
        int total = contactsDao.getToByCondition(map);
        //获取total和获取dataList封装到vo中
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    /***
     * 删除
     * @param ids
     * @return
     */
    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;
        //查询出需要删除备注的数量
        int count1 = detailDao.getCountByAids(ids);
        //删除备注,返回受到影响的条数(实际删除的数量)
        int count2 = detailDao.deleteByAids(ids);
        if (count1!=count2){
            flag = false;
        }
        //删除市场活动
        int count3 = contactsDao.delete(ids);

        if (count3!=ids.length){
            flag = false;
        }
        return flag;
    }

    /**
     * 修改
     * @param id
     * @return
     */
    @Override
    public Map<String, Object> update(String id) {
        //取uList
        List<User> uList = userDao.getOne();
        //取a
        Contacts a = contactsDao.getById(id);
        //将uList和a打包到map中
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("a",a);
        //返回map
        return map;
    }

    @Override
    public boolean updateContactts(Contacts contacts) {
        boolean flag = true;
        int count =contactsDao.updateContacts(contacts);
        if (count!=1){
            flag = false;
        }
        return  flag;
    }

    @Override
    public Contacts detail(String id) {
        Contacts a = contactsDao.detail(id);
        return a;
    }
}
