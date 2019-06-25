package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="controllers.UpdateAdsServlet", urlPatterns = "/ads/update/*")
public class UpdateAdServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            request.getSession().setAttribute("IntendedRedirect","/ads");
            response.sendRedirect("/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        Long id = Long.valueOf(pathInfo.substring(1));
        request.setAttribute("ad", DaoFactory.getAdsDao().getAdById(id));
        request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            request.getSession().setAttribute("IntendedRedirect","/ads");
            response.sendRedirect("/login");
            return;
        }
        User user = ((User)request.getSession().getAttribute("user"));
        String pathInfo = request.getPathInfo();
        Long ID = Long.valueOf(pathInfo.substring(1));

        if(DaoFactory.getAdsDao().getAdById(ID).getUserId() == user.getId()) {
            String adTitle = request.getParameter("title");
            String adDescription = request.getParameter("description");

            if (adTitle.isEmpty() || adDescription.isEmpty()) {
                request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
                response.sendRedirect("/ads/update");
            }
            Ad ad = DaoFactory.getAdsDao().getAdById(ID);
            ad.setTitle(adTitle);
            ad.setDescription(adDescription);
            DaoFactory.getAdsDao().updateAd(ad);
        }
        response.sendRedirect("/ads");
    }
}