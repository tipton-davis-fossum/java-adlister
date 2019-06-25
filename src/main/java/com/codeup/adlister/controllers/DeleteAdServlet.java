package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="controllers.DeleteAdServlet", urlPatterns = "/ads/delete")
public class DeleteAdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            request.getSession().setAttribute("IntendedRedirect","/ads");
            response.sendRedirect("/login");
            return;
        }
        User user = ((User)request.getSession().getAttribute("user"));
        Long ID = Long.parseLong(request.getParameter("delete"));
        if(DaoFactory.getAdsDao().getAdById(ID).getUserId() == user.getId()) {
            DaoFactory.getCategoryAdLinkDao().deleteLinkByAdID(ID);
            DaoFactory.getAdsDao().deleteAdByID(ID);
        }
        response.sendRedirect("/ads");
    }
}