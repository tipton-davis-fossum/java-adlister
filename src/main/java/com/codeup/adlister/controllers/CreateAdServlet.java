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
        List<Category> categories = DaoFactory.getCategoriesDao().all();
        request.setAttribute("categories", categories);

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
        String[] categories = request.getParameterValues("category");

//        String categories = request.getParameter("category");


        List<String> ErrorList = new ArrayList<>();
        if (title.isEmpty()){ErrorList.add("* Title cannot be empty!");}
        if (description.isEmpty()){ErrorList.add("* Description cannot be empty!");}
//        if (categories.isEmpty()){ErrorList.add("* Categories cannot be empty!");}

        boolean inputHasErrors = ErrorList.size()>0;
        if (inputHasErrors) {
            request.setAttribute("FormError",String.join("</br>",ErrorList));
            request.getRequestDispatcher("/WEB-INF/ads/create.jsp").forward(request, response);
            return;
        }

//        String[] CatList = categories.trim().split("\\\\s*,\\\\s*");


        User user = (User) request.getSession().getAttribute("user");
        Ad ad = new Ad(
            user.getId(),
            title,
            description
        );
        ad.setId(DaoFactory.getAdsDao().insert(ad));
        try{
            for(String cat : categories) {
                Category curCat = DaoFactory.getCategoriesDao().findCategoryByName(cat);
                DaoFactory.getCategoryAdLinkDao().addAdToCategory(ad,curCat);
            }
        }catch(Exception e){
            System.out.println(e);
        }
        response.sendRedirect("/ads");
    }
}
