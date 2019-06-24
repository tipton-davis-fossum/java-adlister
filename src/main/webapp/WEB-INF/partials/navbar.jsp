<%@ page import="com.codeup.adlister.dao.DaoFactory" %>
<%@ page import="com.codeup.adlister.models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .nav-item{
        padding-top:8px;
        padding-bottom:8px;
    }
    #mailNav{
        position:relative;
        top:-1px;
        left:4px;
    }
    .nav-item .fa-envelope{
        position:relative;
        top:2px;
        left:-3px;
    }
</style>

<script
        src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous">
</script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


<nav class="navbar navbar-expand-sm navbar-dark bg-dark py-0">
    <!-- Brand and toggle get grouped for better mobile display -->
    <a class="mr-3 text-light" href="/"><i class="fas fa-home"></i></a>
    <a class="navbar-brand" href="/ads">Adlister</a>
    <a class="navbar-brand" href="/ads/create">Create Ad</a>
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
                    <li class="nav-item <c:if test="${param.current.equals('profile')}">active</c:if>"><a href="/profile/${user.getId()}" class="nav-link">Profile (${user.getUsername()})</a></li>
                    <li class="nav-item"><a href="/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item <c:if test="${param.current.equals('register')}">active</c:if>"><a href="/register" class="nav-link">Register</a></li>
                    <li class="nav-item <c:if test="${param.current.equals('login')}">active</c:if>"><a href="/login" class="nav-link">Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>