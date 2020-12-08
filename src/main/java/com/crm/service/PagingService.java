package com.crm.service;

import com.crm.entity.Activity;
import com.crm.vo.PaginationVO;

import java.util.Map;

public interface PagingService {
    public PaginationVO<Activity> paging(Map<String, Object> map);
}
