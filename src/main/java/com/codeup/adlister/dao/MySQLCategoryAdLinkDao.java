package com.codeup.adlister.dao;

import com.codeup.adlister.models.Ad;
import com.codeup.adlister.models.Category;
import com.mysql.cj.jdbc.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySQLCategoryAdLinkDao {
    private Connection connection;

    public MySQLCategoryAdLinkDao(Config config) {
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


    public void addAdToCategory (Ad ad, Category category){
        String query = "insert into ad_categories (ad_id, category_id) values (?,?) ";
        try {
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setLong(1, ad.getId());
            stmt.setLong(2, category.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error creating record in ad category table", e);
        }
    }
    public List<Ad> findAdsFromCategory (Category category) {
        String query = "SELECT ads.* FROM ads " +
                "JOIN ad_categories ON ad_categories.ad_id = ads.id" +
                " where ad_categories.category_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, category.getId());
            ResultSet rs = stmt.executeQuery();
            return createAdsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error finding categories by ad id", e);
        }
    }
    public List<Category> findCategories (Ad ad) {
        String query = "SELECT categories.* FROM categories " +
                "JOIN ad_categories ON ad_categories.category_id = categories.id" +
                " where ad_categories.ad_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, ad.getId());
            ResultSet rs = stmt.executeQuery();
            return createCategoriesFromResults(rs);

        } catch (SQLException e) {
            throw new RuntimeException("Error finding categories by ad id", e);
        }
    }

    private List<Category> createCategoriesFromResults(ResultSet rs) throws SQLException {
        List<Category> categories = new ArrayList<>();
        while (rs.next()) {
            categories.add(new Category(rs.getLong(1),rs.getString(2)));
        }
        return categories;
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

    public void deleteLinkByAdID(Long id) {
        try{
            String updateAdQuery = "DELETE FROM ad_categories WHERE ad_id = ?";
            PreparedStatement statement = connection.prepareStatement(updateAdQuery);
            statement.setLong(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting the ad-category link with AD ID: " + id, e);
        }
    }
}