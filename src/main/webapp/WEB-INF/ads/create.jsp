<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Create a new Ad" />
    </jsp:include>
</head>
<body>
    <div class="container">
        <h1>Create a new Ad</h1>
        <form action="/ads/create" method="post">
            <div class="form-group">
                <label for="title">Title</label>
                <input id="title" name="title" class="form-control" type="text" value="<%= request.getParameter("title") != null? request.getParameter("title") : "" %>">
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" type="text" value="<%= request.getParameter("description") != null? request.getParameter("description") : "" %>"></textarea>
            </div>
            <c:if test="${FormError != null}">
                <div class="mb-2 alert alert-danger" role="alert">
                        ${FormError}
                </div>
            </c:if>
            <input type="submit" class="btn btn-block btn-primary">
        </form>
    </div>
</body>
</html>
