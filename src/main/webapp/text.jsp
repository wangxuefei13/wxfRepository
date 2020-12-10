<%--
  Created by IntelliJ IDEA.
  User: TaiHao
  Date: 2020/12/2
  Time: 19:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
</head>
<body>
    <!--
        add:打开修改模态窗口
        save:执行添加操作
        edit:跳转到修改页面(打开修改模态窗口)
        update:执行修改操作
    -->

    $.ajax({
        url : "",
        data : {

        },
        type : "",
        dataType : "json",
        success : function(data){

        }
    })
</body>
</html>
