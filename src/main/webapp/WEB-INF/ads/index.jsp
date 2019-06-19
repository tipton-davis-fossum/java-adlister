<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Viewing All The Ads" />
    </jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp" />

<div class="container-fluid">
    <div class="row">
        <div class="col-10 mx-auto">
            <div class="row">
                <h1>Here Are all the ads!</h1>
            </div>
            <div class="row">
                <c:forEach var="ad" items="${ads}">
                    <div class="col-md-6 px-0">
                        <h2>${ad.title}</h2>
                        <p>${ad.description}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

</body>
</html>
