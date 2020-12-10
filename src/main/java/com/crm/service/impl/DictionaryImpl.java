package com.crm.service.impl;

import com.crm.dao.DictionaryDao;

import com.crm.dao.DictionaryValueDao;
import com.crm.entity.dic_type;
import com.crm.entity.dic_value;
import com.crm.service.EnerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service("enerService")
public class DictionaryImpl implements EnerService {

    @Autowired
    private DictionaryDao dictionaryDao;
    @Autowired
    private  DictionaryValueDao dictionaryValueDao;


    @Override
    public Map<String, List<dic_value>> Dictionary() {
        Map<String, List<dic_value>> map =  new HashMap<String, List<dic_value>>();
        System.out.println("进入Service");
        try{
            List<dic_type> dtlist = dictionaryDao.getTypeList();
            System.out.println(dtlist);
            //将字典列表遍历
//     将字典列表遍历
            for (dic_type dt:dtlist) {
                String code = dt.getCode();
                List<dic_value> dvList =  dictionaryValueDao.getListByCode(code);
                map.put(code,dvList);
            }

        }catch (Exception  e){
            e.printStackTrace();

                 }

        //取字典列表

        System.out.println(map);
        return map;
    }
}
