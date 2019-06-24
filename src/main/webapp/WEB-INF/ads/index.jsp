<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:if test="${Category != null}">
                <div class="row">
                    <div class="col mx-auto">
                        ${Category.category}
                    </div>
                </div>
            </c:if>
            <jsp:include page="/WEB-INF/partials/search.jsp"/>
        </div>
    </div>
</div>
</body>
</html>