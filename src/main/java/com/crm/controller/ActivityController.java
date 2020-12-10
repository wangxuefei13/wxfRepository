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
import java.util.Map;

@RestController
public class ActivityController {
    //查询user表信息
    @Autowired
    private UserService userService;

    //添加市场活动操作
    @Autowired
    private ActivityService activityService;

    /**
     * 查询用户拥有的角色在前台展示
     * @return
     */
    @RequestMapping("/getPersonList")
    public @ResponseBody List<User> getPersonList(){
        List<User> one = userService.getOne();
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
        boolean flag =activityService.save(activity);
        return flag;
    }

    /**
     *删除数据
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    private boolean delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = activityService.delete(ids);
        return flag;
    }

    /**
     * 修改数据
     * @return
     */
    @RequestMapping("/updateActivity")
    private Map<String, Object> updateActivity(HttpServletRequest request){
        String id =request.getParameter("id");
        Map<String,Object> map =activityService.update(id);
        System.out.println(map);
        return map;
    }

    /**
     * 市场活动修改操作
     */
    @RequestMapping("/update")
    @ResponseBody
    public boolean update(Activity activity, HttpServletRequest request){

        String id =request.getParameter("id");
        //当前修改的时间

        String editTime = DateTimeUtils.getSysTime();
        //当前修改用户
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        activity.setId(id);
        activity.setCreateTime(editTime);
        activity.setCreateBy(editBy);
        boolean flag =activityService.updateActivity(activity);
        return flag;
    }
}
