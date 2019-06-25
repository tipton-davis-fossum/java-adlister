package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="controllers.UpdateAdsServlet", urlPatterns = "/ads/update")
public class UpdateAdServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("ads", DaoFactory.getAdsDao().all());
        request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String adTitle = request.getParameter("title");
        String adDescription = request.getParameter("description");
        Long adId = Long.parseLong(request.getParameter("id"));

        if (adTitle.isEmpty() || adDescription.isEmpty()) {
            request.setAttribute("ads", DaoFactory.getAdsDao().all());
            request.setAttribute("title", adTitle);
            request.setAttribute("description", adDescription);
            request.setAttribute("id", adId);
            request.setAttribute("updateAdError", "Please fill in all fields.");
            request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
            response.sendRedirect("/ads/update");
            return;
        }
    }
}