<%@ page import="com.codeup.adlister.dao.DaoFactory" %>
<%@ page import="com.codeup.adlister.models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script
        src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous">
</script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


<nav class="navbar navbar-expand-sm navbar-dark bg-dark py-0">
    <!-- Brand and toggle get grouped for better mobile display -->
    <a class="mr-3 text-light" href="/"><i class="fas fa-home"></i></a>
    <a class="navbar-brand nav-style" href="/ads">Adlister</a>
    <a class="navbar-nav nav-style" href="/ads/create">Create Ad</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav ml-auto">
            <c:choose>
                <c:when test="${user != null}">
                    <li class="nav-item <c:if test="${param.current.equals('messages')}">active</c:if>">
                        <a href="/messages" id="mailNav" class="nav-link">
                            <% int unreadCount = (DaoFactory.getMessagesDao().getUnreadsForUser((User)
                                    request.getSession().getAttribute("user"))).size();%>
<%--                            <c:if test="<%=unreadCount != 0%>">--%>
                                <span class="badge badge-danger">
                                    <%=unreadCount%>
                                </span>
<%--                            </c:if>--%>
                            <i class="fas fa-envelope"></i>
                        </a>
                    </li>
                    <li class="nav-item nav-style <c:if test="${param.current.equals('profile')}">active</c:if>"><a href="/profile/${user.getId()}" class="nav-link nav-style">Profile (${user.getUsername()})</a></li>
                    <li class="nav-item nav-style"><a href="/logout" class="nav-link nav-style">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li class="navbar-nav nav-style <c:if test="${param.current.equals('register')}">active</c:if>"><a href="/register" class="navbar-nav nav-style nav-register">Register</a></li>
                    <li class="navbar-nav nav-style <c:if test="${param.current.equals('login')}">active</c:if>"><a href="/login" class="navbar-nav nav-style nav-login">Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>