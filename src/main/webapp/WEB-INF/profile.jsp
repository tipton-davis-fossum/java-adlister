<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Your Profile" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/partials/navbar.jsp" />

    <div class="container-fluid">
        <h1>Welcome, ${sessionScope.user.username}!</h1>

        < class="card">

        <c:forEach var="ad" items="${sessionScope.user.ad}">
                    <div class="card-body">
                        <h3>${ad.title}</h3>
                        <em class="card-subtitle">User ID: ${sessionScope.user.id}</em>
                        <p>${ad.description}</p>
                    </div>
        </c:forEach>

        </div>

</body>
</html>
