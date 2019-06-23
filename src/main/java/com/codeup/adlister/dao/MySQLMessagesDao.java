package com.codeup.adlister.dao;

import com.codeup.adlister.models.Message;
import com.codeup.adlister.models.User;
import com.mysql.cj.jdbc.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySQLMessagesDao implements Messages {
    private Connection connection = null;

    public MySQLMessagesDao(Config config) {
        try {
            DriverManager.registerDriver(new Driver());
            connection = DriverManager.getConnection(
                config.getUrl(),
                config.getUsername(),
                config.getPassword()
            );
        } catch (SQLException e) {
            throw new RuntimeException("Error connecting to the database!", e);
        }
    }

    @Override
    public Long insert(Message message) {
        try {
            String insertQuery = "INSERT INTO messages(fromID, toID, content) VALUES (?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setLong(1, message.getFromID());
            stmt.setLong(2, message.getToID());
            stmt.setString(3, message.getContent());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            rs.next();
            return rs.getLong(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting new message.", e);
        }
    }

    @Override
    public List<Message> getMessagesBetweenUsers(User user1, User user2) {
        try {
            String userMessagesQuery = "SELECT * FROM messages WHERE (fromID = ? and toID = ?) or (toID = ? and fromID = ?) order by id desc limit 10";
            PreparedStatement statement = connection.prepareStatement(userMessagesQuery);
            statement.setLong(1,user1.getId());
            statement.setLong(2,user2.getId());
            statement.setLong(3,user1.getId());
            statement.setLong(4,user2.getId());
            ResultSet rs = statement.executeQuery();
            return createMessagesFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving your messages", e);
        }
    }

    @Override
    public List<Message> getUnreadsForUser(User user) {
        try {
            String messageByIDQuery = "SELECT * FROM messages WHERE toID = ? and unread=1";
            PreparedStatement statement = connection.prepareStatement(messageByIDQuery);
            statement.setLong(1,user.getId());
            ResultSet rs = statement.executeQuery();
            return createMessagesFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving unreads for user with id: "+user.getId(), e);
        }
    }
    @Override
    public void setUnreadsForUsers(User fromUser,User toUser) {
        try {
            String messageByIDQuery = "UPDATE messages SET unread = 0 WHERE fromID = ? and toID = ? and unread=1";
            PreparedStatement statement = connection.prepareStatement(messageByIDQuery);
            statement.setLong(1,fromUser.getId());
            statement.setLong(2,toUser.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error setting unreads for user with id: "+toUser.getId(), e);
        }
    }

    @Override
    public List<Message> getConversationsIncludingUser(User user) {
        try {
            String userConversationsQuery = "" +
                    "select * from messages\n" +
                    "where id in (\n" +
                    "    select max(m.id)as id\n" +
                    "    from messages as m\n" +
                    "    group by CONCAT(LEAST(m.fromID, m.toID), '-', GREATEST(m.toID, m.fromID))\n" +
                    ") and (fromID = ? or toID = ?) order by id desc";
            PreparedStatement statement = connection.prepareStatement(userConversationsQuery);
            statement.setLong(1,user.getId());
            statement.setLong(2,user.getId());
            ResultSet rs = statement.executeQuery();
            return createMessagesFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving your messages", e);
        }
    }
    @Override
    public Message getMessageById(Long id) {
        try {
            String messageByIDQuery = "SELECT * FROM messages WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(messageByIDQuery);
            statement.setLong(1,id);
            ResultSet rs = statement.executeQuery();
            return extractMessage(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving the message with ID: "+id, e);
        }
    }
    private Message extractMessage(ResultSet rs) throws SQLException {
        return new Message(
                rs.getLong("id"),
                rs.getLong("fromID"),
                rs.getLong("toID"),
                rs.getString("content"),
                rs.getBoolean("unread")
        );
    }

    private List<Message> createMessagesFromResults(ResultSet rs) throws SQLException {
        List<Message> messages = new ArrayList<>();
        while (rs.next()) {
            messages.add(extractMessage(rs));
        }
        return messages;
    }
}
