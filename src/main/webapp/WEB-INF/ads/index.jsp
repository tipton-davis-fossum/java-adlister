<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Viewing All The Ads"/>
    </jsp:include>
</head>
<body>

<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

<%--<div class="container-fluid">--%>

<%--<h1>Here are all the ads!</h1>--%>

<%--<br>--%>

<%--&lt;%&ndash;Search ads&ndash;%&gt;--%>


<%--</div>--%>

<div class="container">
    <form class="d-flex justify-content-center" action="" METHOD="GET">
        <div class="row input-group input-group-lg">
            <div class="input-group-prepend">
                <span class="input-group-text" id="inputGroup-sizing-lg">Search our ads</span>
            </div>
            <input type="text" name="title" id="title" class="form-control" aria-label="Sizing example input"
                   aria-describedby="inputGroup-sizing-lg" placeholder="search">

            <button type="submit" class="btn btn-secondary btn-lg btn-block">Search</button>
        </div>
    </form>

    <c:forEach var="ad" items="${ads}">
        <div class="col-12">
            <%
                String query = request.getParameter("title");
                request.setAttribute("search", request.getParameter("title"));
            %>
            <c:if test="${search == null}">
                <h2><c:out value="${ad.title}"/></h2>
                <p><c:out value="${ad.description}"/><p>
                <form method="get" action="">
                    <input id="search1" type="hidden" placeholder="${ad.userId}" value="${ad.userId}">
                </form>
                <hr>
            </c:if>

            <c:if test="${search.toString() == ''}">
                <h2><c:out value="${ad.title}"/></h2>
                <p><c:out value="${ad.description}"/><p>
                <form method="get" action="">
                    <input id="search2" type="hidden" placeholder="${ad.userId}" value="${ad.userId}">
                </form>
                <hr>
            </c:if>

            <c:if test="${search.length() != 0}">
                <c:if test="${search != null}">
                    <c:if test="${ad.title.toLowerCase().contains(search.toLowerCase())}">
                        <h2><c:out value="${ad.title}"/></h2>
                        <p><c:out value="${ad.description}"/><p>
                        <form method="get" action="">
                            <input id="search3" type="hidden" placeholder="${ad.userId}" value="${ad.userId}">
                        </form>
                        <hr>
                    </c:if>
                </c:if>
            </c:if>

        </div>
    </c:forEach>
</div>
</body>
</html>
