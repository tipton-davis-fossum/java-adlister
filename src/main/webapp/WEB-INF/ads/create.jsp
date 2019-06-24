<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Create an Ad"/>
    </jsp:include>
    <style>
        /* Customize the label (the container) */

        /* Hide the browser's default checkbox */
        input[type="checkbox"] {
            position: absolute;
            opacity: 0;
            cursor: pointer;
            height: 0;
            width: 0;
        }

        /* Create a custom checkbox */
        .checkmark {
            height: 25px;
            width: 105px;
            padding:5px 10px;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            background-color: #eee;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        /* On mouse-over, add a grey background color */
        .checkmark:hover {
            background-color: #ccc;
        }

        /* When the checkbox is checked, add a blue background */
        input:checked ~ .checkmark {
            background-color: #2196F3;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

    <main class="container-fluid p-3 mx-auto">
        <div class="row">
            <div class="col-8 mx-auto">
                <h1 class="page-heading text-center">Create a new Ad:</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-8 mx-auto">
                <article class="card w-75 mx-auto">
                    <div class="card-body">
                        <h2 class="card-title">Please enter the ads details:</h2>
                        <h5 class="card-title">Your ad will need a title, description, and categories.</h5>
                        <hr>
                        <c:if test="${FormError != null}">
                            <div class="mb-2 alert alert-danger" role="alert">
                                    ${FormError}
                            </div>
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

                            <div id="categories" class="form-group row">

                            </div>
                            <input type="submit" class="btn btn-block my-2 nuts" value="Create Ad">
                        </form>
                    </div>
                </article>
            </div>
        </div>
    </main>
<script>
    let categories = [];


    <c:forEach var="category" items="${categories}">
    categories.push(
        {
            id:${category.id},
            category:"${category.category}"
        });
    </c:forEach>


    function renderCategory(category) {
        let html = "<label class=\"col mx-auto text-center p-1\">" +
                "<input type=\"checkbox\" name=\"category\"" +
                " value=\""+category.category+"\">" +
                "<span class=\"checkmark mx-auto\">"+category.category+"</span>" +
            "</label>";
        return html;
    }
    function renderCategories(categories) {
        let html = '';
        for(let i = 0; i < categories.length; i++) {
            html += renderCategory(categories[i]);
        }
        html+='';
        return html;
    }
    $("#categories").html(renderCategories(categories))
</script>
</body>
</html>
