package com.codeup.adlister.models;

public class Category {
    private Long id;
    private String category;

    public Category(Long id, String name) {
        this.id = id;
        this.category = name;
    }

    public Long getId() {
        return id;
    }

    public String getCategory() {
        return category;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}