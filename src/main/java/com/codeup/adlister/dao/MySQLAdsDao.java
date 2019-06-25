package com.codeup.adlister.dao;

import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.User;
import com.mysql.cj.jdbc.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySQLAdsDao implements Ads {
    private Connection connection = null;

    public MySQLAdsDao(Config config) {
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
    public List<Ad> all() {
        PreparedStatement stmt = null;
        try {
            stmt = connection.prepareStatement("SELECT * FROM ads");
            ResultSet rs = stmt.executeQuery();
            return createAdsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving all ads.", e);
        }
    }

    @Override
    public Long insert(Ad ad) {
        try {
            String insertQuery = "INSERT INTO ads(user_id, title, description) VALUES (?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
            stmt.setLong(1, ad.getUserId());
            stmt.setString(2, ad.getTitle());
            stmt.setString(3, ad.getDescription());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            rs.next();
            return rs.getLong(1);
        } catch (SQLException e) {
            throw new RuntimeException("Error creating a new ad.", e);
        }
    }

    // display user's personal ads
    @Override
    public List<Ad> adsByUser(User user) {

        try {
            String userAdsQuery = "SELECT * FROM ads WHERE user_id = ?";
            PreparedStatement statement = connection.prepareStatement(userAdsQuery);
            statement.setLong(1, user.getId());
            ResultSet rs = statement.executeQuery();
            return createAdsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving your ads", e);
        }
    }

    @Override
    public Ad getAdById(Long id) {
        try {
            String adByIDQuery = "SELECT * FROM ads WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(adByIDQuery);
            statement.setLong(1, id);
            ResultSet rs = statement.executeQuery();
            if(!rs.next()){
                return null;
            }
            return extractAd(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving the ad with ID: " + id, e);
        }
    }

    @Override
    public void updateAd(Ad ad){
        try {
            String updateAdQuery = "UPDATE ads SET title = ?, description = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(updateAdQuery);
            statement.setString(1, ad.getTitle());
            statement.setString(2, ad.getDescription());
            statement.setLong(3, ad.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating the ad with ID: " + ad.getId(), e);
        }
    }
    @Override
    public void deleteAdByID(Long id) {
        try{
            String updateAdQuery = "DELETE FROM ads WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(updateAdQuery);
            statement.setLong(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting the ad with ID: " + id, e);
        }
    }

    private Ad extractAd(ResultSet rs) throws SQLException {
        return new Ad(
            rs.getLong("id"),
            rs.getLong("user_id"),
            rs.getString("title"),
            rs.getString("description")
        );
    }

    private List<Ad> createAdsFromResults(ResultSet rs) throws SQLException {
        List<Ad> ads = new ArrayList<>();
        while (rs.next()) {
            ads.add(extractAd(rs));
        }
        return ads;
    }
}
