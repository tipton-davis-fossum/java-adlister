<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Update Your Ad"/>
    </jsp:include>
</head>
<body>
<% request.setAttribute("adId", request.getParameter("adId"));%>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

<%
    String adTitle = request.getParameter("title");
    String adDescription = request.getParameter("description");
%>

<div class="container-fluid">
    <h1>${sessionScope.user.username}'s ads</h1>

    <c:forEach var="ad" items="${ads}">
        <c:if test="${ad.id == adId}">

            <form action="/ads/update" method="POST">
                <div class="form-group">
                    <label for="updateAdTitle" name="updateAdTitle" value="<c:out value="${ad.title}"/>">Title
                        update</label>
                    <input type="text" class="form-control" id="updateAdTitle">
                    <label for="updateAdDescription" name="updateAdDescription"
                           value="<c:out value="${ad.description}"/>">Description update</label>
                    <textarea class="form-control" id="updateAdDescription" rows="5"></textarea>
                </div>
                <input type="submit" class="btn btn-block btn-primary">
            </form>

        </c:if>
    </c:forEach>
</div>
</body>

</head>
<body>
<div class="container-fluid paper-background">
    <form action="/ad/update" method="post">
        <div class="row">
            <div class="col-md-3 col-md-offset-5">
                <h1>Update Ad</h1>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="title">Title</label>
                <input id="title" name="title" class="form-control" type="text" value="${ads.title}">
            </div>
        </div>
        <div class="row">
            <div class="form-group col-md-6 col-md-offset-3">
                <label for="description">Description</label>
                <textarea id="description" name="description" class="form-control" type="text" value="${ads.description}"></textarea>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <input type="hidden" name="id" value="${ads.id}">
                <button class="btn btn-primary btn-block">Update!</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>