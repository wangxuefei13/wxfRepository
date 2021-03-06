package com.crm.controller;

import com.crm.entity.Customer;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.UserService;
import com.crm.utils.DateTimeUtils;
import com.crm.utils.UUIDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

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
        String createTime = DateTimeUtils.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        customer.setId(id);
        customer.setCreateBy(createBy);
        customer.setCreateTime(createTime);
        System.out.println(createBy);
        System.out.println(createTime);
//        System.out.println(id);
        boolean flag = customerService.add(customer);
//        System.out.println(flag);
        return flag;
    }

    /**
     *删除数据
     * @return
     */
    @RequestMapping("/deleteCust")
    @ResponseBody
    private boolean delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = customerService.delete(ids);
        return flag;
    }


    /**
     * 修改数据
     * @return
     */
    @RequestMapping("/updateCustomer")
    public Map<String, Object> updateCust(HttpServletRequest request){
        String id =request.getParameter("id");
        System.out.println(id);
        Map<String, Object> map = customerService.update(id);
        System.out.println("进入customerCOn"+map);
        return map;
    }
    /**
     * 客户修改操作
     */
    @RequestMapping("/updatea")
    @ResponseBody
    public boolean updatea(Customer customer, HttpServletRequest request){

        String id = request.getParameter("id");
//        System.out.println("id-----------------"+id);

        //当前修改的时间
        String editTime = DateTimeUtils.getSysTime();
        //当前修改用户
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

//        customer.setId(id);
        customer.setEditTime(editTime);
        customer.setEditBy(editBy);

        boolean flag =customerService.updateCust(customer);
        //System.out.println(flag);
        return flag;
    }

@RequestMapping("/detail1")
    public void detail(HttpServletRequest request ,HttpServletResponse response) throws ServletException, IOException {
    String id =request.getParameter("id");
    Customer c = customerService.detail(id);
    //System.out.println(c);
    request.setAttribute("c",c);
    request.getRequestDispatcher("/workbench/customer/detail.jsp").forward(request,response);
    }


}
