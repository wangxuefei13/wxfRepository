package com.crm.controller;

import com.crm.entity.Customer;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.UserService;
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

    private List<Customer> list;

    private Customer customer;

    /**
     * 查询所有者
     */
    @RequestMapping("/getAuthority")
    public @ResponseBody List<User> getPersonList(){
//        System.out.println("进入");
        List<User> one = userService.getOne();
//        System.out.println(one);
        return one;
    }

    /**
     * 添加客户
     */
    @RequestMapping("/addCustomer")
    @ResponseBody
    public boolean addCustomer(Customer customer, HttpServletRequest request){
        System.out.println("进入"+customer);
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String website = request.getParameter("website");
        String phone = request.getParameter("phone");

        System.out.println(owner+""+name+""+website+""+phone);

        return true;
    }

}
