package com.crm.service;

import com.crm.entity.Customer;
import com.crm.vo.PaginationVO;

import java.util.Map;

public interface CustomerPageService {
    public PaginationVO<Customer> paging(Map<String, Object> map);
}
