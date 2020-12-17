package com.crm.controller;

import com.crm.entity.Clue;
import com.crm.entity.User;
import com.crm.service.ClueService;
import com.crm.service.UserService;
import com.crm.utils.DateTimeUtils;
import com.crm.utils.UUIDUtils;
import com.crm.vo.PaginationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    //跳转到线索详情页面
    @RequestMapping("/particulars")
    public void particulars(String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Clue c = clueService.particulars(id);
        request.setAttribute("c",c);
        request.getRequestDispatcher("/workbench/clue/detail.jsp").forward(request,response);
    }
    //线索的分页查询
    @RequestMapping("/cluePaging")
    public @ResponseBody
    PaginationVO<Clue> paging(String pageNo, String pageSize,
              @RequestParam(value = "name", required = false) String name,
              @RequestParam(value = "owner", required = false) String owner,
              @RequestParam(value = "company", required = false)String company,
              @RequestParam(value = "phone", required = false)String phone,
              @RequestParam(value = "mphone", required = false)String mphone,
              @RequestParam(value = "state", required = false)String state,
              @RequestParam(value = "source", required = false)String source){
        int pageNo1 = Integer.valueOf(pageNo);
        int pageSize1 = Integer.valueOf(pageSize);
        //计算出略过的记录数
        int skipCount=(pageNo1-1)*pageSize1;
        System.out.println("coll层的名字"+name);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("name",name);
        map.put("owner",owner);
        map.put("company",company);
        map.put("phone",phone);
        map.put("mphone",mphone);
        map.put("state",state);
        map.put("source",source);
        map.put("skipCount",skipCount);
        map.put("pageSize1",pageSize1);
        PaginationVO<Clue> vo = clueService.cluePaging(map);
        return vo;
    }
    /**
     *删除数据
     * @return
     */
    @RequestMapping("/clueDelete")
    @ResponseBody
    private boolean delete(HttpServletRequest request){
        String ids[] = request.getParameterValues("id");
        boolean flag = clueService.delete(ids);
        return flag;
    }
    /**
     * 修改数据
     * @return
     */
    @RequestMapping("/updateClue")
    @ResponseBody
    private Map<String, Object> updateClue(String id){
        System.out.println("进入修改---"+id);
        Map<String,Object> map =clueService.update(id);
        System.out.println("返回修改数据--"+map);
        return map;
    }

    /**
     * 市场活动修改操作
     */
    @RequestMapping("/clupdate")
    @ResponseBody
    public boolean update(Clue clue, HttpServletRequest request){

        String id =request.getParameter("id");
        //当前修改的时间

        String editTime = DateTimeUtils.getSysTime();
        //当前修改用户
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        clue.setId(id);
        clue.setCreateTime(editTime);
        clue.setCreateBy(editBy);
        boolean flag =clueService.updateClue(clue);
        return flag;
    }

}
