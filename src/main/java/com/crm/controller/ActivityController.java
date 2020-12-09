package com.crm.controller;

import com.crm.entity.Activity;
import com.crm.entity.User;
import com.crm.service.ActivityService;
import com.crm.service.UserService;
import com.crm.utils.DateTimeUtils;
import com.crm.utils.UUIDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
public class ActivityController {
    //查询user表信息
    @Autowired
    private UserService userService;

    //添加市场活动操作
    @Autowired
    private ActivityService activityService;

    private List<Activity> list;

    private Activity activity;
    /**
     * 查询用户拥有的角色在前台展示
     * @return
     */
    @RequestMapping("/getPersonList")
    public @ResponseBody List<User> getPersonList(){
        List<User> one = userService.getOne();
        //System.out.println(one);
        return one;
    }


    /**
     * 向后台添加用户
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public boolean save(Activity activity, HttpServletRequest request){
        //添加数据库id
        String id =UUIDUtils.getEncryption_ID("uu");
        //当前添加的时间
        String createTime = DateTimeUtils.getSysTime();
        //当前登录用户
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        activity.setId(id);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);
        //System.out.println(activity);
        boolean flag =activityService.save(activity);
        return flag;
    }
}
