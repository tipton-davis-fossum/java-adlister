CREATE DATABASE IF NOT EXISTS adlister_db;

USE adlister_db;

DROP TABLE IF EXISTS ads;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS ad_categories;
DROP TABLE IF EXISTS messages;

CREATE TABLE users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE ,
    username VARCHAR(128) NOT NULL UNIQUE ,
    email VARCHAR(128) NOT NULL UNIQUE ,
    password VARCHAR(256) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ads
(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    title VARCHAR(128) NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE categories (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category VARCHAR(64) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE ad_categories (
    ad_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (ad_id) REFERENCES ads(id),
    FOREIGN KEY (category_id) REFERENCES categories (id)
);

CREATE TABLE messages (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     fromID INT UNSIGNED NOT NULL,
     toID INT UNSIGNED NOT NULL,
     content TEXT NOT NULL,
     unread TINYINT(1) NOT NULL DEFAULT 1,
     PRIMARY KEY (id),
     FOREIGN KEY (fromID) REFERENCES users(id) ON DELETE CASCADE,
     FOREIGN KEY (toID) REFERENCES users(id) ON DELETE CASCADE
);