<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Create an Ad"/>
    </jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>


<h1 class="page-heading text-center">Create a new Ad:</h1>

<main class="container mx-auto row">
    <article class="card w-75 mx-auto col-7">
        <div class="card-body">
            <h2 class="card-title">Please enter the ads details:</h2>
            <h5 class="card-title">Your ad will need a title, description, and categories.</h5>
            <hr>
            <c:if test="${sessionScope.message != null}">
                <aside class="alert" role="alert">
                        ${sessionScope.message}
                </aside>
            </c:if>

            <form action="/ads/create" method="post">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input id="title" name="title" class="form-control" type="text" value="${sessionScope.title}">
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" type="text">${sessionScope.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <textarea id="category" name="category" class="form-control" type="text">${sessionScope.category}</textarea>
                </div>

                <input type="submit" class="btn btn-block my-2 nuts" value="Create Ad">
            </form>
        </div>
    </article>

</main>

</body>
<%
    session.removeAttribute("message");
    session.removeAttribute("title");
    session.removeAttribute("description");
%>
</html>
