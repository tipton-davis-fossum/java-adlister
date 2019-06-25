<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Welcome to the adlister!"/>
    </jsp:include>
    <%--Stylesheets--%>
    <%--<link href="WEB-INF/css/front-page.css" rel="stylesheet" type="text/css" media="screen">--%>

<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

<div class="container-fluid">

   <h1 class="mt-0">Welcome to the Adlister</h1>

</div>

<jsp:include page="WEB-INF/partials/footer.jsp"/>
</body>
</html>
