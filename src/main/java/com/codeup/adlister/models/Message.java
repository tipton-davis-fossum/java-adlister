package com.codeup.adlister.models;

import com.codeup.adlister.dao.DaoFactory;

public class Message {
    private long id;
    private long fromID;
    private long toID;
    private String content;
    private boolean unread;

    private String authorName;
    private String toName;

    public Message() {
    }

    public Message(long fromID, long toID, String content) {
        this.fromID = fromID;
        this.toID = toID;
        this.content = content;
    }

    public Message(long id, long fromID, long toID, String content, boolean unread) {
        this.id = id;
        this.fromID = fromID;
        this.toID = toID;
        this.content = content;
        this.unread = unread;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getFromID() {
        return fromID;
    }

    public void setFromID(long fromID) {
        this.fromID = fromID;
    }

    public long getToID() {
        return toID;
    }

    public void setToID(long toID) {
        this.toID = toID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    public String getDisplay(User curUser) {
        User messageAuthor = DaoFactory.getUsersDao().findById(this.fromID);
        String color;
        if(messageAuthor.getId() == curUser.getId()){
            color="'background-color:#eee';";
        }else{
            color="'background-color:#ccc';";
            if(this.unread){
                color="'background-color:#fcc';";
            }
        }
        String htmlBuffer = "<div class='row' style="+color+">" +
            "<div class='col-12'>"+
                "<a class='Author' href='/profile/"+messageAuthor.getId()+"'>" +
                    "<span class='w-100 mb-3'>"
                        + messageAuthor.getUsername() +
                    "</span>" +
                "</a>"+
                "<p class='w-100 mb-0'>" + this.content + "</p>" +
                "</div>"+
            "</div>";
        return htmlBuffer;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public boolean isUnread() {
        return unread;
    }

    public void setUnread(boolean unread) {
        this.unread = unread;
    }
}
