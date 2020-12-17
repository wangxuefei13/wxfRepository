package com.crm.dao;

import com.crm.entity.Activity;
import com.crm.entity.Clue;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ClueDao {
    int qwer(Clue clue);

    Clue particulars(String id);

    List<Clue> getClueListByCondition(Map<String, Object> map);

    int getClueByCondition(Map<String, Object> map);
    //线索删除
    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    int delete(String[] ids);
    //线索修改
    int updateClue(Clue clue);

    Clue getById(String id);
}
