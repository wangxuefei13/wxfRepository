<%--
  Created by IntelliJ IDEA.
  User: Bokhoo
  Date: 2020/10/29
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
</head>
<body>
    <h3>查询所有账户</h3>
    <table>
        <tr>
            <td>编号</td>
            <td>名字</td>
            <td>余额</td>
        </tr>
        <c:forEach var="user" items="${list}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.money}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
