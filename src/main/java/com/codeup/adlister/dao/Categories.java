package com.codeup.adlister.dao;

import com.codeup.adlister.models.Category;
import com.codeup.adlister.models.User;

import java.util.List;

public interface Categories {
    Category findByCategory(String category);
    Long insert(Category category);
}