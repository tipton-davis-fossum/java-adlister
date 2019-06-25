<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Viewing All The Ads"/>
    </jsp:include>
</head>

<body>

<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

<div class="container-fluid p-3">
    <div class="row">
        <div class="col-8 mx-auto">
            <jsp:include page="/WEB-INF/partials/search.jsp"/>
        </div>
    </div>
</div>

</body>

</html>
