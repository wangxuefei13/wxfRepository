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
		$("#addBtn").click(function(){
		    //日期  年-月-日
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});
            //查询user表传递到所有者下拉菜单
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
					$("#createActivityModal").modal("show");
				}
			})
			//保存按钮执行添加操作(点击市场活动保存,添加ACTIVITY)
			$("#saveBtn").click(function () {
				$.ajax({
					url: "save",
					data :{
						"owner" : $.trim($("#create-owner").val()),
						"name" : $.trim($("#create-name").val()),
						"startDate" : $.trim($("#create-startDate").val()),
						"endDate" : $.trim($("#create-endDate").val()),
						"cost" : $.trim($("#create-cost").val()),
						"description" : $.trim($("#create-description").val()),
					},
					type: "post",
					dataType: "json",
					success : function (data) {
						//console.log(data)
						if (data==true){
							//添加成功后
							//刷新市场活动信息列表(局部刷新)
                            //pageList(1,2);

                            /*
                            *($("#activityPage").bs_pagination('getOption', 'currentPage')
                            * 操作后停留在当前页
                            * $("#activityPage").bs_pagination('getOption', 'rowsPerPage')
                            * 操作后维持已经设置好的每页展现的记录数
                            *
                            * 两个参数不需任何操作
                            * 直接使用
                            * */

                            //做完操作后应回到第一页维持每页展现记录数
                            pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

							//清空添加操作模态窗口的数据
							//提交表单
							$("#activityAddForm")[0].reset();

							//关闭模态窗口
							$("#createActivityModal").modal("hide");
						}else {
							alert("添加市场活动失败")
						}
					}
				})

			})
		})
		//页面加载完毕后触发一个方法
		pageList(1,2);
		//未查询按钮绑定事件，触发pageList方法
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
        $("#activityBody").on("click",$("input[name=xz]"),function () {
            $("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
        })



        //为删除按钮绑定事件,执行市场活动删除操作
        $("#deleteBtn").click(function () {
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
                    //alert(param);
                    $.ajax({
                        url : "delete",
                        data : param,
                        type : "post",
                        dataType : "json",
                        success : function (data) {
                            if (data==true){
                                //删除成功后
                                //回到第一页,维持每页展现的记录数
                                //pageList(1,2);
                                pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除市场活动失败");
                            }
                        }
                    })
                }

            }
        })

        //为修改按钮绑定事件,打开修改模态窗口
        $("#editBtn").click(function () {
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
                    url : "updateActivity",
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
                        $("#edit-id").val(data.a.id);
                        $("#edit-name").val(data.a.name);
                        $("#edit-owner").val(data.a.owner);
                        $("#edit-startDate").val(data.a.startData);
                        $("#edit-endDate").val(data.a.endData);
                        $("#edit-cost").val(data.a.cost);
                        $("#edit-description").val(data.a.description);

                        //所有值填写好之后,打开修改模态窗口
                        $("#editActivityModal").modal("show");
                    }
                })
            }
        })

        //为更新按钮绑定事件,执行市场活动修改操作
        $("#updateBtn").click(function () {
            $.ajax({
                url: "update",
                data :{
                    "id" : $.trim($("#edit-id").val()),
                    "owner" : $.trim($("#edit-owner").val()),
                    "name" : $.trim($("#edit-name").val()),
                    "startDate" : $.trim($("#edit-startDate").val()),
                    "endDate" : $.trim($("#edit-endDate").val()),
                    "cost" : $.trim($("#edit-cost").val()),
                    "description" : $.trim($("#edit-description").val()),
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
                        pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                                ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                        //关闭修改模态窗口
                        $("#editActivityModal").modal("hide");
                    }else {
                        alert("修改市场活动失败")
                    }
                }
            })
        })
	});
	/*
	对于所有的关系型数据库，做前端的分页相关操作的基础组件
	pageNo：页码
	pageSize：每页展示的记录条数
	 */
	function pageList(pageNo,pageSize) {
	    //将全选的复选框的√去除
        $("#qx").prop("checked",false);

		//查询前把隐藏域中的值取出来传进搜索框中
		$("#search-name1").val($.trim($("#hidden-name").val()));
		$("#search-owner1").val($.trim($("#hidden-owner").val()));
		$("#search-startDate").val($.trim($("#hidden-startDate").val()));
		$("#search-endDate").val($.trim($("#hidden-endDate").val()));
		$.ajax({
			url:"paging",
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"name1":$.trim($("#search-name1").val()),
				"owner1":$.trim($("#search-owner1").val()),
				"startData":$.trim($("#search-startDate").val()),
				"endData":$.trim($("#search-endDate").val()),
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html="";
				// dataList后台传过来的市场活动
				$.each(data.dataList,function (i,n) {
					console.log(data.dataList)
					html+='<tr class="active">';
					html+='<td><input type="checkbox" name="xz" value="'+n.id+'"/></td>';
					html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'detail?id='+n.id+'\';">'+n.name+'</a></td>';
					html+='<td>'+n.owner+'</td>';
					html+='<td>'+n.startDate+'</td>';
					html+='<td>'+n.endDate+'</td>';
					html+='</tr>';
				})
				$("#activityBody").html(html);
				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后,结合分页插件，对前端展示分页信息
				$("#activityPage").bs_pagination({
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
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-startData">
	<input type="hidden" id="hidden-endData">

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">

					<form id="activityAddForm" class="form-horizontal" role="form">
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate" autocomplete="off">
								<!-- readonly input框无法选中 -->
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate" autocomplete="off">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost" autocomplete="off">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">

					<!--
						data-dismiss="modal"
						表示关闭模态窗口
					-->

					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">

                        <input type="hidden" id="edit-id"/>

						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name" value="发传单">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate" >
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
                                <!--
                                    关于文本域textarea:
                                    (1)一定要以标签队的形式出现,正常状态下标签对要紧紧挨着
                                    (2)textarea虽然是以标签对的形式出现,但他也是属于表单元素范畴
                                    -->
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
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
				      <input class="form-control" type="text" id="search-name1">
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner1">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="search-startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="search-endDate">
				    </div>
				  </div>
				  
				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
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
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">
<%--						<tr class="active">--%>
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>--%>
<%--                            <td>zhangsan</td>--%>
<%--							<td>2020-10-10</td>--%>
<%--							<td>2020-10-20</td>--%>
<%--						</tr>--%>
<%--                        <tr class="active">--%>
<%--                            <td><input type="checkbox" /></td>--%>
<%--                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">发传单</a></td>--%>
<%--                            <td>zhangsan</td>--%>
<%--                            <td>2020-10-10</td>--%>
<%--                            <td>2020-10-20</td>--%>
<%--                        </tr>--%>
					</tbody>
				</table>
			</div>
<%--分页--%>
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>