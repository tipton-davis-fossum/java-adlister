<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="partials/head.jsp">
        <jsp:param name="title" value="404 Error" />
    </jsp:include>
</head>
<body>
    <jsp:include page="/WEB-INF/partials/navbar.jsp" >
        <jsp:param name="current" value="404" />
    </jsp:include>
    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-10 mx-auto">
                <h1>Error 404: Page not found!</h1>
            </div>
        </div>
    </div>
</body>
</html>
