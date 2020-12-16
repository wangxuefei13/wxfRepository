<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <%--分页插件--%>
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
    <script type="text/javascript">

        $(function(){
            $("#addBtn").click(function () {
                $(".time").datetimepicker({
                    minView: "month",
                    language:  'zh-CN',
                    format: 'yyyy-mm-dd',
                    autoclose: true,
                    todayBtn: true,
                    pickerPosition: "bottom-left"
                });
                $.ajax({
                    url : "getPersonList",
                    type : "get",
                    dataType : "json",
                    success : function (data) {
                        var html = "";
                        //遍历出的每个n,就是每一个user对象
                        $.each(data,function(i,n){
                            html += "<option value='"+n.id+"'>"+n.name+"</option>";
                        })
                        $("#create-owner").html(html);
                        //取得当前用户id
                        //在js中使用el表达式,el表达式套用在字符串中
                        var id ="${user.id}";
                        $("#create-owner").val(id);
                        //所有者下拉框处理完毕后,展现模态窗口
                        $("#createCustomerModal").modal("show");
                    }
                })

                $("#addSave").click(function () {
                    // alert("aa")
                    $.ajax({
                        url: "add",
                        data: {
                            "owner": $.trim($("#create-owner").val()),
                            "name": $.trim($("#create-name").val()),
                            "website": $.trim($("#create-website").val()),
                            "phone": $.trim($("#create-phone").val()),
                            "contactSummary": $.trim($("#create-contactSummary").val()),
                            "nextContactTime": $.trim($("#create-nextContactTime").val()),
                            "description": $.trim($("#create-description").val()),
                            "address": $.trim($("#create-address1").val()),
                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            //console.log(data)
                            if (data == true) {
                                pageList(1,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));
                                $("#customerAddForm")[0].reset();
                                //关闭模态窗口
                                $("#createCustomerModal").modal("hide");

                            } else {
                                alert("添加客户失败")
                            }
                        }
                    })
                })
            })

            //删除按钮绑定事件
            $("#deleteBtn").click(function () {

                //找到复选框所有√的复选框jquery对象
                var $xz = $("input[name=xz]:checked");

                if ($xz.length==0){
                    alert("请选择要删除的记录")

                    //选了，可能是一条，也可能多条
                }else{
                    if (confirm("确定删除所选中的记录吗?")){


                        var param = "";
                        //将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
                        for(var i =0;i<$xz.length;i++){
                            param += "id="+$($xz[i]).val();

                            //如果不是最后一个元素，需要在后面追加一个&符
                            if(i<$xz.length-1){

                                param += "&";
                            }
                        }
                        // alert(param);
                        $.ajax({
                            url :"deleteCust",
                            data : param,
                            type:"post",
                            dataType:"json",
                            success:function(data){
                                if (data.success){
                                    alert("删除客户失败");
                                }else {
                                    //删除成功后
                                    // pageList(1,2);
                                    pageList(1,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

                                }
                            }
                        })


                    }
                }

            })






            // 页面加载完毕后触发一个方法
            // 默认展开列表的第一页，每页展现两条记录
            pageList(1,2);

            //为查询按钮绑定事件，触发pageList方法
            $("#searchBtn").click(function () {
                //点击查询的时候我们应当把搜索框中的信息保存起来，保存到隐藏域中
                $("#hidden-name").val($.trim($("#search-name1").val()));
                $("#hidden-owner").val($.trim($("#search-owner1").val()));
                $("#hidden-startDate").val($.trim($("#search-startDate").val()));
                $("#hidden-endDate").val($.trim($("#search-endDate").val()));

                pageList(1,2);
            })
            //为全选的复选框绑定事件，触发全选操作
            $("#qx").click(function () {
                $("input[name=xz]").prop("checked",this.checked);
            })
            $("#customerBody").on("click",$("input[name=xz]"),function () {
                $("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
            })



            //为修改按钮绑定事件,打开修改模态窗口
            $("#updateBtn").click(function () {
                $(".time").datetimepicker({
                    minView: "month",
                    language:  'zh-CN',
                    format: 'yyyy-mm-dd',
                    autoclose: true,
                    todayBtn: true,
                    pickerPosition: "bottom-left"
                });
                var $xz = $("input[name=xz]:checked");

                if ($xz.length==0){
                    alert("请选择要修改的数据");
                }else if ($xz.length>1){
                    alert("只能修改一条数据");
                }else {
                    var id = $xz.val();
                    $.ajax({
                        url : "updateCustomer",
                        data : {
                            "id":id,
                        },
                        type : "get",
                        dataType : "json",
                        success : function(data){
                            //处理所有者的下拉框
                            var html = "<option></option>";
                            $.each(data.uList,function (i,n) {
                                html +="<option value='"+n.id+"'>"+n.name+"</option>";
                            })
                            $("#edit-owner").html(html);
                            //处理单条customer
                            $("#edit-id").val(data.a.id);
                            $("#edit-name").val(data.a.name);
                            $("#edit-owner").val(data.a.owner);
                            $("#edit-website").val(data.a.website);
                            $("#edit-phone").val(data.a.phone);
                            $("#edit-description").val(data.a.description);
                            $("#edit-contactSummary1").val(data.a.contactSummary);
                            $("#edit-nextContactTime2").val(data.a.nextContactTime);
                            $("#edit-address").val(data.a.address);

                            //所有值填写好之后,打开修改模态窗口
                            $("#editCustomerModal").modal("show");
                        }
                    })
                }
            })

//为更新按钮绑定事件,执行市场活动修改操作
            $("#editBtn").click(function () {
                $.ajax({
                    url: "updatea",
                    data :{
                        "id" : $.trim($("#edit-id").val()),
                        "name" : $.trim($("#edit-name").val()),
                        "owner" : $.trim($("#edit-owner").val()),
                        "website" : $.trim($("#edit-website").val()),
                        "phone" : $.trim($("#edit-phone").val()),
                        "description" : $.trim($("#edit-description").val()),
                        "contactSummary" : $.trim($("#edit-contactSummary1").val()),
                        "nextContactTime" : $.trim($("#edit-nextContactTime2").val()),
                        "address" : $.trim($("#edit-address").val())
                    },
                    type: "post",
                    dataType: "json",
                    success : function (data) {
                        //console.log(data)
                        if (data==true){
                            //修改成功后
                            //刷新市场活动信息列表(局部刷新)
                            //pageList(1,2);

                            /*
                            * 修改操作后,应维持当前页维持每页展现记录数
                            * */
                            pageList($("#customerPage").bs_pagination('getOption', 'currentPage')
                                    ,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));
                            //关闭修改模态窗口
                            $("#editCustomerModal").modal("hide");
                        }else {
                            alert("修改客户信息失败")
                        }
                    }
                })
            })







        });

        /**
         * pageNo:页码
         * pageSize：每页展现的记录数
         *
         * pageList方法：就是ajax请求到后台，从后台取得最新的市场活动信息列表数据
         *               通过响应回来的数据，局部刷新市场活动信息列表
         *
         * （1）点击左侧菜单中的客户刷新
         * （2）添加修改删除后，需要刷新客户界面
         * （3）点击查询按钮的时候
         * （4）点击分页组件的时候
         */
        function pageList(pageNo,pageSize){
            //将全选的复选框的√去掉
            $("#qx").prop("checked",false);

            $.ajax({
                url :"pageListe",
                data: {

                    "pageNo":pageNo,
                    "pageSize": pageSize,
                    "name": $.trim($("#search-name").val()),
                    "owner": $.trim($("#search-owner").val()),
                    "phone": $.trim($("#search-phone").val()),
                    "website": $.trim($("#search-website").val()),
                },
                type:"get",
                dataType:"json",
                success:function(data){
                    var html="";
                    //每一个n就是一个客户对象信息
                    $.each(data.dataList,function (i,n) {
                        html+='<tr class="customer">';
                        html+= '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                        html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'detail1?id='+n.id+'\';">'+n.name+'</a></td>';
                        html+='<td>'+n.owner+'</td>';
                        html+='<td>'+ n.phone+'</td>';
                        html+='<td>'+ n.website+'</td>';
                        html+='</tr>';
                    })
                    $("#customerBody").html(html);

                    //计算总页数
                    var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
                    //数据处理完毕后,结合分页插件，对前端展示分页信息
                    $("#customerPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
                        totalPages: totalPages, // 总页数
                        totalRows: data.total, // 总记录条数

                        visiblePageLinks: 3, // 显示几个卡片

                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: true,
                        //该分页函数是在点击分页插件时触发的
                        onChangePage : function(event, data){
                            pageList(data.currentPage , data.rowsPerPage);
                        }
                    });
                }
            })
        }


    </script>
</head>
<body>

<!-- 创建客户的模态窗口 -->
<div class="modal fade" id="createCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建客户</h4>
            </div>
            <div class="modal-body">
                <form id="customerAddForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-owner">



                            </select>
                        </div>
                        <label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-website">
                        </div>
                        <label for="create-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-description"></textarea>
                        </div>
                    </div>
                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="create-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="create-address1"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary"  id="addSave">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改客户的模态窗口 -->
<div class="modal fade" id="editCustomerModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改客户</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <input type="hidden" id="edit-id" >
                    <div class="form-group">
                        <label for="edit-customerOwner" class="col-sm-2 control-ldeabel">所有者<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-owner">

                            </select>
                        </div>
                        <label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-name" value="动力节点">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website">
                        </div>
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-contactSummary1"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control time" id="edit-nextContactTime2">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="editBtn">更新</button>
            </div>
        </div>
    </div>
</div>




<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>客户列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text" id="search-name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="search-owner">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input class="form-control" type="text" id="search-phone">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司网站</div>
                        <input class="form-control" type="text" id="search-website">
                    </div>
                </div>

                <button type="button" id="searchBtn" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                <button type="button" class="btn btn-default" id="updateBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="qx"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>公司座机</td>
                    <td>公司网站</td>
                </tr>
                </thead>
                <tbody id="customerBody">
                <%--<tr>
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点</a></td>
                    <td>zhangsan</td>
                    <td>010-84846003</td>
                    <td>http://www.bjpowernode.com</td>
                </tr>
                <tr class="active">
                    <td><input type="checkbox" /></td>
                    <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点</a></td>
                    <td>zhangsan</td>
                    <td>010-84846003</td>
                    <td>http://www.bjpowernode.com</td>
                </tr>--%>
                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div id="customerPage"></div>
        </div>

    </div>

</div>
</body>
</html>