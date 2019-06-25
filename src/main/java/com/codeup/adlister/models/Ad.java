package com.codeup.adlister.models;

import com.codeup.adlister.dao.DaoFactory;

import java.util.List;

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
    public String getCategoriesDisplay(List<Category>categories){
        String htmlBuffer="";
        for(Category category : categories){
            String tb="";
            tb+="<div class='mx-2 category py-1'>";
            tb+=    "<a href='/category/"+category.getCategory()+"'>#"+category.getCategory()+"</a>";
            tb+="</div>";
            htmlBuffer+=tb;
        }
        return htmlBuffer;
    }
    public String getDisplay(Long loggedInUserID){
        User adAuthor = DaoFactory.getUsersDao().findById(this.userId);
        List<Category> categories = DaoFactory.getCategoryAdLinkDao().findCategories(this);
        String htmlBuffer=
                "<div class='card my-3 mx-auto col-5 p-0'>" +
                "   <div class='card-body'>" +
                "       <div class='row'>"+
                "           <div class='col-11'>"+
                "               <h3>"+this.title+"</h3>" +
                "           </div>"+ (loggedInUserID == adAuthor.getId() ?
                "           <div class='col-1'>"+
                "               <form action='/ads/delete' method='post'>"+
                "                   <button class='btn btn-sm btn-danger' type='submit' name='delete' value='"+this.id+"'>X</button>"+
                "               </form>"+
                "           </div>" : "") +
                "       </div>"+
                "       <div class='row'>"+
                "           <div class='col'>"+
                "               <p>"+this.description+"</p>" +
                "           </div>"+
                "       </div>"+
                "       <div class='row'>"+
                "           <div class='col'>"+
                "               <a href='/profile/"+adAuthor.getId()+"'>"+adAuthor.getUsername()+"</a>"+
                "           </div>"+
                "       </div>"+
                "   </div>"+ (categories.size() > 0 ?
                "   <div class='card-footer text-muted py-0'>" +
                "       <div class='row'>"+
                "           " + getCategoriesDisplay(categories) +
                "       </div>"+
                "   </div>" : "") +
                "</div>";
        return htmlBuffer;
    }
}
