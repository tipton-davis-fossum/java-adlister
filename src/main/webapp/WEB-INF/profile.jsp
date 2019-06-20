<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Your Profile"/>
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/partials/navbar.jsp">
        <jsp:param name="current" value="profile"/>
    </jsp:include>

    <div class="container-fluid">
        <h1>Welcome, ${sessionScope.user.username}!</h1>

        <c:forEach var="ad" items="${requestScope.adsList}">

            <div class="card allTheAds">
                <div class="card-body">
                    <h3>${ad.title}</h3>
                    <p>${ad.description}</p>
                </div>
            </div>

        </c:forEach>

    </div>
</body>
</html>
