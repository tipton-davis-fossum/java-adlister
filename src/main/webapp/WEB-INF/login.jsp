<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Please Log In" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/partials/navbar.jsp">
        <jsp:param name="current" value="login" />
    </jsp:include>
    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-8 mx-auto">
                <h1>Please Log In</h1>
                <form action="/login" method="POST">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input id="username" name="username" class="form-control" type="text" value="<%= request.getParameter("username") != null? request.getParameter("username") : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input id="password" name="password" class="form-control" type="password" value="<%= request.getParameter("password") != null? request.getParameter("password") : "" %>">
                    </div>
                    <c:if test="${FormError != null}">
                        <div class="mb-2 alert alert-danger" role="alert">
                            ${FormError}
                        </div>
                    </c:if>
                    <input type="submit" class="btn btn-primary btn-block" value="Log In">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
