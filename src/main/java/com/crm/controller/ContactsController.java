package com.crm.controller;

import com.crm.entity.Contacts;
import com.crm.entity.User;
import com.crm.service.ContactsService;
import com.crm.service.UserService;
import com.crm.utils.DateTimeUtils;
import com.crm.utils.UUIDUtils;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ContactsController {
    @Autowired
    private UserService userService;
    @Autowired
    private ContactsService contactsService;

    /**
     * 查询用户表信息在前台展示
     * @return
     */
    @RequestMapping("/addContacts")
    public @ResponseBody
    List<User> addContacts(){
        List<User> one = userService.getOne();
        return one;
    }



    /**
     * 添加用户到数据库
     * @param contacts
     * @param request
     * @return
     */
    @RequestMapping("/saveCts")
    @ResponseBody
    public boolean saveCts(Contacts contacts, HttpServletRequest request){
        String id = UUIDUtils.getEncryption_ID("uu");
        String createTime =DateTimeUtils.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        contacts.setId(id);
        contacts.setCreateTime(createTime);
        contacts.setCreateBy(createBy);

        boolean flag = contactsService.saveCts(contacts);
        return flag;
    }

    /**
     * 查询列表
     * @param pageNo
     * @param pageSize
     * @param owner
     * @param fullname
     * @param customerId
     * @param source
     * @param birth
     * @return
     */
    @RequestMapping("/pageList")
    public @ResponseBody
    PaginationVO<Contacts> pageList(String pageNo,String pageSize,
        @RequestParam(value = "owner", required = false) String owner,
        @RequestParam(value = "fullname", required = false) String fullname,
        @RequestParam(value = "customerId", required = false)String customerId,
        @RequestParam(value = "source", required = false)String source,
        @RequestParam(value = "birth", required = false)String birth){

        int pageNo1 = Integer.valueOf(pageNo);
        int pageSize1 = Integer.valueOf(pageSize);
        //计算出略过的记录数
        int skipCount=(pageNo1-1)*pageSize1;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("owner",owner);
        map.put("fullname",fullname);
        map.put("customerId",customerId);
        map.put("source",source);
        map.put("birth",birth);
        map.put("skipCount",skipCount);
        map.put("pageSize1",pageSize1);
        PaginationVO<Contacts> vo = contactsService.paging(map);
        return vo;
    }

    /**
     * 删除
     * @param request
     * @return
     */
    @RequestMapping("/deleteCon")
    @ResponseBody
    public boolean deleteCon(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = contactsService.delete(ids);
        return flag;
    }

    /***
     * 修改
     * @param request
     * @return
     */
    @RequestMapping("/updateContacts")
    public Map<String, Object> updateContacts(HttpServletRequest request){
        String id =request.getParameter("id");
        Map<String,Object> map =contactsService.update(id);
        //System.out.println(map);
        return map;
    }

    @RequestMapping("/updatecont")
    @ResponseBody
    public boolean updatecont(Contacts contacts, HttpServletRequest request){
        String id =request.getParameter("id");
        String editTime = DateTimeUtils.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        contacts.setId(id);
        contacts.setEditTime(editTime);
        contacts.setEditBy(editBy);

        boolean flag =contactsService.updateContactts(contacts);
        return flag;
    }

    /**
     * 跳转详细信息
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping("/detaill")
    public void detaill(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String id =request.getParameter("id");
        Contacts a = contactsService.detail(id);
        //System.out.println(a);
        request.setAttribute("a",a);
        request.getRequestDispatcher("/workbench/contacts/detail.jsp").forward(request,response);
    }
}
