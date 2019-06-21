package com.codeup.adlister.models;

import com.codeup.adlister.dao.DaoFactory;

public class Ad {
    private long id;
    private long userId;
    private String title;
    private String description;

    public Ad(long id, long userId, String title, String description) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.description = description;
    }

    public Ad(long userId, String title, String description) {
        this.userId = userId;
        this.title = title;
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDisplay(){
        User adAuthor = DaoFactory.getUsersDao().findById(this.userId);
        String htmlBuffer=
                "<div class='card my-3'>" +
                "   <div class='card-body'>" +
                "       <h3>"+this.title+"</h3>" +
                "       <p>"+this.description+"</p>" +
                "       <a href='/profile/"+adAuthor.getId()+"'>"+adAuthor.getUsername()+"</a>"+
                "   </div>" +
                "</div>";
        return htmlBuffer;
    }
}
