package com.codeup.adlister.dao;

import com.codeup.adlister.models.User;

import java.util.List;

public interface Users {
    User findById(Long ID);
    User findByUsername(String username);
    User findByUsernameNotID(String username, long ID);
    User findByEmail(String email);
    User findByEmailNotID(String email, long ID);
    Long insert(User user);
    void update(User user);
}
