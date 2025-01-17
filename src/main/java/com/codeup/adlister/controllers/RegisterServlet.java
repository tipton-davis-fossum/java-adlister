package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "controllers.RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordConfirmation = request.getParameter("confirm_password");

        // validate input



        List<String> ErrorList = new ArrayList<>();
        if (DaoFactory.getUsersDao().findByUsername(username) != null) {ErrorList.add("* Username is unavailable");}
        if (DaoFactory.getUsersDao().findByEmail(email) != null) {ErrorList.add("* Email is already registered!");}
        if (username.isEmpty()){ErrorList.add("* Invalid Username");}
        if (email.isEmpty()){ErrorList.add("* Invalid Email");}
        if (password.isEmpty()){ErrorList.add("* Invalid Password");}
        if ((! password.equals(passwordConfirmation)) || passwordConfirmation.isEmpty()){ErrorList.add("* Passwords must match!");}

        boolean inputHasErrors = ErrorList.size()>0;
        if (inputHasErrors) {
            request.setAttribute("FormError",String.join("</br>",ErrorList));
            request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
            return;
        }

        // create and save a new user
        User user = new User(username, email, password);
        DaoFactory.getUsersDao().insert(user);
        response.sendRedirect("/login");
    }
}
