package com.crm.service.impl;

import com.crm.dao.ClueDao;
import com.crm.entity.Clue;
import com.crm.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueDao clueDao;
    @Override
    public boolean qwer(Clue clue) {
        boolean flag = true;
        int count = clueDao.qwer(clue);
        if (count!=1){
            flag =false;
        }
        System.out.println(flag);
        return flag;
    }
}
