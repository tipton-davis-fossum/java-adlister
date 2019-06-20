package com.codeup.adlister.controllers;

import com.codeup.adlister.dao.DaoFactory;
import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.User;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
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

@WebServlet(name = "controllers.ViewProfileServlet", urlPatterns = "/profile")
public class ViewProfileServlet extends HttpServlet {
    private final String UPLOAD_DIRECTORY = "img";
    private Object obj = new Object();
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        String appPath = request.getServletContext().getRealPath("");
        String savePath = appPath + File.separator + UPLOAD_DIRECTORY;
        File fileSaveDir = new File(savePath);
//        System.out.println(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        //process only if its multipart content
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
//                upload.setSizeMax(50000);
                List<FileItem> multiparts = upload.parseRequest(request);
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = "profile_"+((User)request.getSession().getAttribute("user")).getId();
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
            } catch(FileUploadBase.SizeLimitExceededException ex){
                request.setAttribute("message", "File Upload Failed due to exceeding maximum file size (50KB)");
            } catch (Exception ex) {
                request.setAttribute("message", "File Upload Failed due to " + ex);
            }

        }else{
            request.setAttribute("message",
                    "Sorry this Servlet only handles file upload request");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        List<Ad> AdsList = DaoFactory.getAdsDao().adsByUser((User)request.getSession().getAttribute("user"));
        request.setAttribute("adsList",AdsList);
        request.getRequestDispatcher("/WEB-INF/profile.jsp").forward(request, response);
    }
}
