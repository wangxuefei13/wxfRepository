package com.crm.service;

import com.crm.entity.Activity;
import com.crm.entity.Clue;
import com.crm.vo.PaginationVO;

import java.util.Map;

public interface ClueService {
    boolean qwer(Clue clue);

    Clue particulars(String id);
    //线索的分页搜索
    PaginationVO<Clue> cluePaging(Map<String, Object> map);
    //线索的删除
    boolean delete(String[] ids);
    //市场活动修改操作
    boolean updateClue(Clue clue);
    //修改数据
    Map<String, Object> update(String id);
}
