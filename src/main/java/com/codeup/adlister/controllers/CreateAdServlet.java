package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.User;
import com.codeup.adlister.models.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "controllers.CreateAdServlet", urlPatterns = "/ads/create")
public class CreateAdServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            request.getSession().setAttribute("IntendedRedirect","/ads/create");
            response.sendRedirect("/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/ads/create.jsp")
            .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if (request.getSession().getAttribute("user") == null) {
            request.getSession().setAttribute("IntendedRedirect","/ads/create");
            response.sendRedirect("/login");
            return;
        }
        String title = request.getParameter("title");
        String description = request.getParameter("description");


        List<String> ErrorList = new ArrayList<>();
        if (title.isEmpty()){ErrorList.add("* Title cannot be empty!");}
        if (description.isEmpty()){ErrorList.add("* Description cannot be empty!");}

        boolean inputHasErrors = ErrorList.size()>0;
        if (inputHasErrors) {
            request.setAttribute("FormError",String.join("</br>",ErrorList));
            request.getRequestDispatcher("/WEB-INF/ads/create.jsp").forward(request, response);
            return;
        }

        User user = (User) request.getSession().getAttribute("user");
        Ad ad = new Ad(
            user.getId(),
            title,
            description
        );
        DaoFactory.getAdsDao().insert(ad);
        response.sendRedirect("/ads");
    }
}
