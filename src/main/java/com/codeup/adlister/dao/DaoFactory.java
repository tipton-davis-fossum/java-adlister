package com.codeup.adlister.dao;

import com.codeup.adlister.dao.Config;

public class DaoFactory {
    private static Ads adsDao;
    private static Users usersDao;
    private static Categories categoriesDao;
    private static MySQLCategoryAdLinkDao categoryAdLinkDao;
    private static Messages messagesDao;
    private static Config config = new Config();

    public static Ads getAdsDao() {
        if (adsDao == null) {
            adsDao = new MySQLAdsDao(config);
        }
        return adsDao;
    }

    public static Users getUsersDao() {
        if (usersDao == null) {
            usersDao = new MySQLUsersDao(config);
        }
        return usersDao;
    }

    public static Categories getCategoriesDao() {
        if (categoriesDao == null) {
            categoriesDao = new MySQLCategoriesDao(config);
        }
        return categoriesDao;
    }

    public static MySQLCategoryAdLinkDao getCategoryAdLinkDao() {
        if (categoryAdLinkDao == null) {
            categoryAdLinkDao = new MySQLCategoryAdLinkDao(config);
        }
        return categoryAdLinkDao;
    }

    public static Messages getMessagesDao() {
        if (messagesDao == null) {
            messagesDao = new MySQLMessagesDao(config);
        }
        return messagesDao;
    }
}
