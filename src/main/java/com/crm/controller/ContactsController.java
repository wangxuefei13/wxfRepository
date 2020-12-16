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

import javax.servlet.http.HttpServletRequest;
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
    @RequestMapping("/pageList")
    public @ResponseBody
    PaginationVO<Contacts> pageList(String pageNo,String pageSize,
        @RequestParam(value = "owner", required = false) String owner,
        @RequestParam(value = "name", required = false) String name,
        @RequestParam(value = "customerId", required = false)String customerId,
        @RequestParam(value = "source", required = false)String source,
        @RequestParam(value = "birth", required = false)String birth){

        int pageNo1 = Integer.valueOf(pageNo);
        int pageSize1 = Integer.valueOf(pageSize);
        //计算出略过的记录数
        int skipCount=(pageNo1-1)*pageSize1;
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("owner",owner);
        map.put("name",name);
        map.put("customerId",customerId);
        map.put("source",source);
        map.put("birth",birth);
        map.put("skipCount",skipCount);
        map.put("pageSize1",pageSize1);
        PaginationVO<Contacts> vo = contactsService.paging(map);
        return vo;
    }
}
