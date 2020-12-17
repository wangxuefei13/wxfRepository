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
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		$("#saveAdd").click(function () {
            $(".time").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });
            $.ajax({
                url: "addContacts",
                data: {},
                type: "get",
                dataType: "json",
                success: function (data) {
                    var html = "<option></option>";
                    $.each(data,function (i,n) {
                        html += "<option value='"+n.id+"'>"+n.name+"</option>";
                    })
                    $("#create-owner").html(html);
                    var id ="${user.id}";
                    $("#create-owner").val(id);
                    $("#createContactsModal").modal("show");
                }
            })
            $("#saveContacts").click(function () {
                $.ajax({
                    url : "saveCts",
                    data : {
                        "owner":$.trim($("#create-owner").val()),
                        "source":$.trim($("#create-source").val()),
                        "customerId":$.trim($("#create-customerId").val()),
                        "fullname":$.trim($("#create-fullname").val()),
                        "appellation":$.trim($("#create-appellation").val()),
                        "email":$.trim($("#create-email").val()),
                        "mphone":$.trim($("#create-mphone").val()),
                        "job":$.trim($("#create-job").val()),
                        "birth":$.trim($("#create-birth").val()),
                        "description":$.trim($("#create-description").val()),
                        "contactSummary":$.trim($("#create-contactSummary1").val()),
                        "nextContactTime":$.trim($("#create-nextContactTime1").val()),
                        "address":$.trim($("#edit-address").val())
                    },
                    type : "post",
                    dataType : "json",
                    success : function(data){
                        if (data==true){
                            pageList(1,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
                            $("#contactsAddFrom")[0].reset();
                            $("#createContactsModal").modal("hide");
                        }else {
                            alert("添加失败");
                        }
                    }
                })
            })
        });
		//页面加载完毕后触发一个方法
        pageList(1,2);
        //为查询绑定事件,触发pageList方法
        $("#searchBtn").click(function () {
            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-fullname").val($.trim($("#search-fullname").val()));
            $("#hidden-customerId").val($.trim($("#search-customerId").val()));
            $("#hidden-source").val($.trim($("#search-source").val()));
            $("#hidden-birth").val($.trim($("#search-birth").val()));
            pageList(1,2);
        })
        $("#qx").click(function () {
            $("input[name=xz]").prop("checked",this.checked);
        })
        $("#contactsBody").on("click",$("input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
        })

        //为删除按钮绑定事件,执行市场活动删除操作
        $("#deleteBut").click(function () {
            //找到复选框中所有挑√的复选框的jquery对象
            var $xz = $("input[name=xz]:checked");
            if ($xz.length==0){
                alert("请选择需要删除的记录");
                //肯定选择,而且可能是一条,也可能是多条
            }else {
                if (confirm("确定删除所选中的记录吗?")){
                    //拼接函数
                    var param = "";
                    //将$xz中的每个dom对象遍历出来,取其value值,就相当于取得了需要删除的记录的id
                    for (var i=0;i<$xz.length;i++){
                        param += "id="+$($xz[i]).val();
                        //如果不是最后一个元素,需要在后面加一个&符
                        if (i<$xz.length-1){
                            param += "&";
                        }
                    }
                    $.ajax({
                        url : "deleteCon",
                        data : param,
                        type : "post",
                        dataType : "json",
                        success : function (data) {
                            if (data==true){
                                //删除成功后
                                //回到第一页,维持每页展现的记录数
                                //pageList(1,2);
                                pageList(1,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除市场活动失败");
                            }
                        }
                    })
                }

            }
        })

        //为修改按钮绑定事件,打开修改模态窗口
        $("#editBut").click(function () {
            //日期  年-月-日
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
                    url : "updateContacts",
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
                        //处理单条activity
                        $("#edit-owner").val(data.a.owner);
                        $("#edit-id").val(data.a.id);
                         $("#edit-source").val(data.a.source);
                         $("#edit-fullname").val(data.a.fullname);
                         $("#edit-appellation").val(data.a.appellation);
                         $("#edit-job").val(data.a.job);
                         $("#edit-mphone").val(data.a.mphone);
                         $("#edit-email").val(data.a.email);
                         $("#edit-birth").val(data.a.birth);
                         $("#edit-customerId").val(data.a.customerId);
                         $("#edit-description").val(data.a.description);
                         $("#edit-contactSummary").val(data.a.contactSummary);
                         $("#edit-nextContactTime").val(data.a.nextContactTime);
                         $("#edit-address2").val(data.a.address);
                        //所有值填写好之后,打开修改模态窗口
                        $("#editContactsModal").modal("show");
                    }
                })
            }
        })

        //为更新按钮绑定事件,执行修改操作
        $("#updateBut").click(function () {
            $.ajax({
                url: "updatecont",
                data :{
                    "id" : $.trim($("#edit-id").val()),
                    "owner" : $.trim($("#edit-owner").val()),
                    "source" : $.trim($("#edit-source").val()),
                    "fullname" : $.trim($("#edit-fullname").val()),
                    "appellation" : $.trim($("#edit-appellation").val()),
                    "job" : $.trim($("#edit-job").val()),
                    "mphone" : $.trim($("#edit-mphone").val()),
                    "email" : $.trim($("#edit-email").val()),
                    "birth" : $.trim($("#edit-birth").val()),
                    "customerId" : $.trim($("#edit-customerId").val()),
                    "description" : $.trim($("#edit-description").val()),
                    "contactSummary" : $.trim($("#edit-contactSummary").val()),
                    "nextContactTime" : $.trim($("#edit-nextContactTime").val()),
                    "address" : $.trim($("#edit-address2").val()),
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
                        pageList($("#contactsPage").bs_pagination('getOption', 'currentPage')
                                ,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
                        //关闭修改模态窗口
                        $("#editContactsModal").modal("hide");
                    }else {
                        alert("修改市场活动失败")
                    }
                }
            })
        })
	});
    function pageList(pageNo,pageSize) {
        $("#qx").prop("checked",false);
        $("#search-owner").val($.trim($("#hidden-owner").val()));
        $("#search-fullname").val($.trim($("#hidden-fullname").val()));
        $("#search-customerId").val($.trim($("#hidden-customerId").val()));
        $("#search-source").val($.trim($("#hidden-source").val()));
        $("#search-birth").val($.trim($("#hidden-birth").val()));
        $.ajax({
            url : "pageList",
            data : {
                "pageNo":pageNo,
                "pageSize":pageSize,
                "owner":$.trim($("#search-owner").val()),
                "fullname":$.trim($("#search-fullname").val()),
                "customerId":$.trim($("#search-customerId").val()),
                "source":$.trim($("#search-source").val()),
                "birth":$.trim($("#search-birth").val())
            },
            type : "get",
            dataType : "json",
            success : function(data){
                var html = "";
                //每一个n就是每一个联系人对象
                $.each(data.dataList,function (i,n) {
                    html += '<tr class="active">';
                    html += '<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
                    html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'detaill?id='+n.id+'\';">'+n.fullname+'</a></td>';
                    html += '<td>'+n.customerId+'</td>';
                    html += '<td>'+n.owner+'</td>';
                    html += '<td>'+n.source+'</td>';
                    html += '<td>'+n.birth+'</td>';
                    html += '</tr>';
                })
                $("#contactsBody").html(html);
                var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
                //数据处理完毕后,结合分页插件，对前端展示分页信息
                $("#contactsPage").bs_pagination({
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
<%--    隐藏域解决查询和下一页点击bug--%>
<input type="hidden" id="hidden-name">
<input type="hidden" id="hidden-customerId">
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-source">
<input type="hidden" id="hidden-birth">

	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form id="contactsAddFrom" class="form-horizontal" role="form">

						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
							<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
								  <option>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fullname">
							</div>
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
								  <option>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>

						</div>

						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-birth">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerId" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>

						<div class="form-group" style="position: relative;">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>

						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="create-nextContactTime1">
								</div>
							</div>
						</div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveContacts">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
                        <input type="hidden" id="edit-id"/>
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option></option>
								  <option selected>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-fullname" value="">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-appellation">
								  <option></option>
								  <option selected>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-birth">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerId" placeholder="支持自动补全，输入客户不存在则新建" value="">
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
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address2"></textarea>
                                </div>
                            </div>
                        </div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBut">更新</button>
				</div>
			</div>
		</div>
	</div>





	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>

	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="search-customerId">
				    </div>
				  </div>

				  <br>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="search-source">
						  <option></option>
						  <option>广告</option>
						  <option>推销电话</option>
						  <option>员工介绍</option>
						  <option>外部介绍</option>
						  <option>在线商场</option>
						  <option>合作伙伴</option>
						  <option>公开媒介</option>
						  <option>销售邮件</option>
						  <option>合作伙伴研讨会</option>
						  <option>内部研讨会</option>
						  <option>交易会</option>
						  <option>web下载</option>
						  <option>web调研</option>
						  <option>聊天</option>
						</select>
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control" type="text" id="search-birth">
				    </div>
				  </div>

				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>

				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="saveAdd" ><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBut"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBut"> <span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>


			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>姓名</td>
							<td>客户名称</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="contactsBody">
<%--						<tr>--%>
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四</a></td>--%>
<%--							<td>动力节点</td>--%>
<%--							<td>zhangsan</td>--%>
<%--							<td>广告</td>--%>
<%--							<td>2000-10-10</td>--%>
<%--						</tr>--%>
<%--                        <tr class="active">--%>
<%--                            <td><input type="checkbox" /></td>--%>
<%--                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">李四</a></td>--%>
<%--                            <td>动力节点</td>--%>
<%--                            <td>zhangsan</td>--%>
<%--                            <td>广告</td>--%>
<%--                            <td>2000-10-10</td>--%>
<%--                        </tr>--%>
					</tbody>
				</table>
			</div>

            <div style="height: 50px; position: relative;top: 30px;">
                <div id="contactsPage"></div>
            </div>
			
		</div>
		
	</div>
</body>
</html>