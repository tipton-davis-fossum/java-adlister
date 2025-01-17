package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.User;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import javax.servlet.annotation.WebServlet;

@WebServlet(name = "controllers.ViewProfileServlet", urlPatterns = "/profile/*")
public class ViewProfileServlet extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "img";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User loggedInUser = (User)request.getSession().getAttribute("user");
        if (loggedInUser == null) {
            response.sendRedirect("/login");
            return;
        }else {
            String pathInfo = request.getPathInfo();
            Long id = Long.valueOf(pathInfo.substring(1));
            User profileUser = DaoFactory.getUsersDao().findById(id);
            if (profileUser.getId() != loggedInUser.getId()) {
                response.sendRedirect("/profile/" + profileUser.getId());
                return;
            }

            String appPath = request.getServletContext().getRealPath("");
            String savePath = appPath + File.separator + UPLOAD_DIRECTORY;
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }
            //process only if its multipart content
            if (ServletFileUpload.isMultipartContent(request)) {
                try {
                    ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
//                upload.setSizeMax(50000);
                    List<FileItem> multiparts = upload.parseRequest(request);
                    for (FileItem item : multiparts) {
                        if (!item.isFormField()) {
                            String name = "profile_" + loggedInUser.getId();
                            String fileName = savePath + File.separator + name;
                            File file = new File(fileName);
                            item.write(file);

                            byte[] encoded = java.util.Base64.getEncoder().encode(FileUtils.readFileToByteArray(file));
                            PrintWriter out = response.getWriter();
                            String encodedPFP = new String(encoded, StandardCharsets.US_ASCII);
                            out.println(encodedPFP);
                            out.close();
                        }
                    }
                    //File uploaded successfully
                    request.setAttribute("message", "File Uploaded Successfully");
                } catch (FileUploadBase.SizeLimitExceededException ex) {
                    request.setAttribute("message", "File Upload Failed due to exceeding maximum file size (50KB)");
                } catch (Exception ex) {
                    request.setAttribute("message", "File Upload Failed due to " + ex);
                }
            } else {
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                List<String> ErrorList = new ArrayList<>();

                if (DaoFactory.getUsersDao().findByUsernameNotID(username, loggedInUser.getId()) != null) {
                    ErrorList.add("* Username is unavailable");
                }
                if (DaoFactory.getUsersDao().findByEmailNotID(email, loggedInUser.getId()) != null) {
                    ErrorList.add("* Email is already registered!");
                }
                if (username.isEmpty()) {
                    ErrorList.add("* Invalid Username");
                }
                if (email.isEmpty()) {
                    ErrorList.add("* Invalid Email");
                }

                boolean inputHasErrors = ErrorList.size() > 0;
                if (inputHasErrors) {
                    List<Ad> AdsList = DaoFactory.getAdsDao().adsByUser(profileUser);
                    request.setAttribute("ads",AdsList);
                    request.setAttribute("FormError", String.join("</br>", ErrorList));
                    request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
                    return;
                }
                loggedInUser.setUsername(username);
                loggedInUser.setEmail(email);
                request.getSession().setAttribute("user", loggedInUser);
                DaoFactory.getUsersDao().update(loggedInUser);
                response.sendRedirect("/profile/"+loggedInUser.getId());
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        String pathInfo = request.getPathInfo();
        Long id = Long.valueOf(pathInfo.substring(1));
        User profileUser = DaoFactory.getUsersDao().findById(id);
        request.getSession().setAttribute("profileUser",profileUser);
        List<Ad> AdsList = DaoFactory.getAdsDao().adsByUser(profileUser);
        request.setAttribute("ads",AdsList);
        request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
    }
}
