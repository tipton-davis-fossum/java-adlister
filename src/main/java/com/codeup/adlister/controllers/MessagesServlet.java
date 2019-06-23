package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Message;
import com.codeup.adlister.models.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "controllers.MessagesServlet", urlPatterns = "/messages/*")
public class MessagesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        User user = (User)request.getSession().getAttribute("user");
        if(request.getPathInfo() == null) {
            List<Message> messagesList = DaoFactory.getMessagesDao().getConversationsIncludingUser(user);
            for(Message message : messagesList){
                message.setAuthorName(DaoFactory.getUsersDao().findById(message.getFromID()).getUsername());
                message.setToName(DaoFactory.getUsersDao().findById(message.getToID()).getUsername());
            }
            request.setAttribute("messagesList", messagesList);
            request.getRequestDispatcher("/WEB-INF/messagesList.jsp").forward(request, response);
        }else{
            Long id = Long.valueOf(request.getPathInfo().substring(1));
            User messageUser = DaoFactory.getUsersDao().findById(id);
            List<Message> messages = DaoFactory.getMessagesDao().getMessagesBetweenUsers(user, messageUser);
            Collections.reverse(messages);


            if (request.getParameter("oldMessages") != null) {
//                response.setContentType("text/plain");
//            System.out.println(request.getParameter("oldMessages"));
//                response.getWriter().write(request.getParameter("oldMessages"));
                PrintWriter out = response.getWriter();

                String htmlBuffer = "";
                for (Message message : messages) {
                    htmlBuffer += message.getDisplay(user);
                }
                out.write(htmlBuffer);
                out.close();
                return;
            }

            request.setAttribute("messageUser", messageUser);
            request.setAttribute("messages", messages);
            request.getRequestDispatcher("/WEB-INF/messages.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }else {

            User user = (User) request.getSession().getAttribute("user");
            Long id = Long.valueOf(request.getPathInfo().substring(1));
            User messageUser = DaoFactory.getUsersDao().findById(id);

            Message message = new Message(user.getId(), messageUser.getId(), request.getParameter("content"));
            DaoFactory.getMessagesDao().insert(message);
            response.sendRedirect("/messages/" + id);
        }
    }
}
