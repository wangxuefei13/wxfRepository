package com.crm.controller;

import com.crm.entity.Customer;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.UserService;
import com.crm.utils.UUIDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
public class CustomerController {
    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;
    /**
     * 查询所有者信息
     * @return
     */
    @RequestMapping("/getAuthority")
    public @ResponseBody List<User> personList(){
        List<User> one = userService.getOne();
        return one;
    }
    /**
     * 添加客户数据
     */
    @RequestMapping("/add")
    @ResponseBody
    public boolean add(Customer customer, HttpServletRequest request){
        //添加数据库id
        String id =UUIDUtils.getEncryption_ID("uu");

        customer.setId(id);
        System.out.println(id);
        boolean flag = customerService.add(customer);
        System.out.println(flag);
        return flag;
    }




}
