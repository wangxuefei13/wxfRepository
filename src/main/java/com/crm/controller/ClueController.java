package com.crm.controller;

import com.crm.entity.Clue;
import com.crm.entity.User;
import com.crm.service.ClueService;
import com.crm.service.UserService;
import com.crm.utils.DateTimeUtils;
import com.crm.utils.UUIDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ClueController {
    @Autowired
    private UserService userService;
    @Autowired
    private ClueService clueService;
    @RequestMapping("/userList")
    @ResponseBody
    public List<User> userList(){
        List<User> one = userService.getOne();
        return one;
    }
    //添加线索信息
    @RequestMapping("/qwer")
    @ResponseBody
    public boolean qwer(Clue clue, HttpServletRequest request){
        System.out.println("进入添加");
        //添加数据库id
        String id = UUIDUtils.getEncryption_ID("uu");
        //当前添加的时间
        String createTime = DateTimeUtils.getSysTime();
        //当前登录用户
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        clue.setId(id);
        clue.setCreateBy(createBy);
        clue.setCreateTime(createTime);
        System.out.println("要添加的信息"+clue);
        boolean flag = clueService.qwer(clue);

        return flag;
    }
}
