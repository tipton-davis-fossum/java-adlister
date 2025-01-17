package com.codeup.adlister.dao;

import com.codeup.adlister.models.Message;
import com.codeup.adlister.models.User;

import java.util.List;

public interface Messages {

    Long insert(Message message);

    List<Message> getMessagesBetweenUsers(User user1,User user2);
    List<Message> getConversationsIncludingUser(User user);
    List<Message> getUnreadsForUser(User user);
    void setUnreadsForUsers(User fromUser,User toUser);

    Message getMessageById(Long id);
}
