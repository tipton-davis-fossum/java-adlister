<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Delete Ad"/>
    </jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>
<div class="container my-5 col-lg-8 col-md-10 col-12">
    <fieldset class="card p-5 mx-auto col-10 bg-dark text-white">
        <h1>Are you sure you want to delete this ad!?</h1>
        <h3><c:out value="${ad.title}"/></h3>
        <form method="POST" action="/ads/delete">
            <input type="hidden" id="id" name="id" value="${ad.id}">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="This is permanent">
            </div>
            <input type="submit" class="btn btn-block btn-danger" value="DELETE">
        </form>
    </fieldset>
</div>
</body>
</html>