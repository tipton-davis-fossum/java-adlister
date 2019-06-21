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

@WebServlet(name = "controllers.UpdateAdServlet", urlPatterns = "/ads/update")
public class UpdateAdsServlet {

    public class UpdateAdServlet extends HttpServlet {
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            String getId = request.getParameter("id");
            Long getAdId = Long.parseLong(getId);
            Ad ad = DaoFactory.getAdsDao().getByAdId(getAdId);
            request.setAttribute("ad", ad);

            request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
        }

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            String updateTitle = request.getParameter("title");
            String updateDescription = request.getParameter("description");
            Long adId = Long.parseLong(request.getParameter("ad.id"));
            User user = (User) request.getSession().getAttribute("user");
            Long userId = user.getId();

            if (updateTitle.isEmpty() || updateDescription.isEmpty()) {
                request.setAttribute("ads", DaoFactory.getAdsDao().all());
                request.setAttribute("title", updateTitle);
                request.setAttribute("description", updateDescription);
                request.setAttribute("adId", adId);
//                request.setAttribute("updateAdFailure", "Please enter something in the title and description.");
                request.getRequestDispatcher("/WEB-INF/ads/update.jsp").forward(request, response);
                response.sendRedirect("/ads/update");



            }
        }
    }
}


