package com.crm.service.impl;

import com.crm.dao.ClueDao;
import com.crm.dao.UserDao;
import com.crm.entity.Clue;
import com.crm.entity.User;
import com.crm.service.ClueService;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private PaginationVO<Clue> vo;
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
//跳转到线索详情页面
    @Override
    public Clue particulars(String id) {
        Clue c = clueDao.particulars(id);
        return c;
    }
    //线索的分页搜索
    @Override
    public PaginationVO<Clue> cluePaging(Map<String, Object> map) {
        //获取dataList
        List<Clue> dataList = clueDao.getClueListByCondition(map);
//        System.out.println("获取dataList"+dataList);
        //获取total
        int total = clueDao.getClueByCondition(map);
        //获取total和获取dataList封装到vo中
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    /**
     * 删除
     *
     */
    @Override
    public boolean delete(String[] ids) {
        //System.out.println("进入service"+ids);
        boolean flag = true;
        //查询出需要删除备注的数量
        int count1 = clueDao.getCountByAids(ids);
        //删除备注,返回受到影响的条数(实际删除的数量)
        int count2 = clueDao.deleteByAids(ids);
        if (count1!=count2){
            flag = false;
        }
        //删除线索
        int count3 = clueDao.delete(ids);

        if (count3!=ids.length){
            flag = false;
        }
        return flag;
    }
    //修改
    @Override
    public Map<String, Object> update(String id) {
        System.out.println("进入修改service");
        //取uList
        List<User> uList = userDao.getOne();
        //取a
        Clue c = clueDao.getById(id);
        //将uList和a打包到map中
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("uList",uList);
        map.put("c",c);
        //返回map
        return map;
    }

    @Override
    public boolean updateClue(Clue clue) {
        boolean flag = true;
        int count =clueDao.updateClue(clue);
        if (count!=1){
            flag = false;
        }
        return  flag;
    }
}
