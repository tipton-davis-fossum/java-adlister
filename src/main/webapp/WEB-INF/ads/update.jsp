<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Update Your Ad"/>
    </jsp:include>
</head>
<body>
<div class="container-fluid paper-background">
    <form method="post">
        <div class="row">
            <div class="col-md-3 col-md-offset-5">
                <h1>Update Ad</h1>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="title">Title</label>
                <input id="title" name="title" class="form-control" type="text" value="${ad.title}">
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" type="text">${ad.description}</textarea>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <input type="hidden" name="id" value="${ad.id}">
                <button class="btn btn-primary btn-block">Update!</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>