# SOURCE myScript.sql;
/*
CREATE TABLE providers (
    p_id INT,
    name VARCHAR(200),
    name2 VARCHAR(200),
    address_1 VARCHAR(200),
    address_2 VARCHAR(100),
    city VARCHAR(100),
    state CHAR(2),
    zipcode INT,
    phone_number VARCHAR(20),
    web_site VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    num_reviews INT,
    avg_rating DECIMAL(2,1),
    PRIMARY KEY (p_id));

CREATE TABLE services (
    p_id INT,
    std INT,
    sexual_assault INT,
    domestic_violence INT,
    pregnancy_testing INT,
    abortion INT,
    low_cost INT,
    contraception INT,
    counseling INT,
    PRIMARY KEY (p_id),
    FOREIGN KEY (p_id) REFERENCES providers(p_id));


CREATE TABLE providerphotos (
    id INT,
    p_id INT,
    photo_url VARCHAR(2083),
    PRIMARY KEY (id),
    FOREIGN KEY (p_id) REFERENCES providers(p_id));

CREATE TABLE aliases (
    id INT,
    alias VARCHAR(50),
    PRIMARY KEY (id));

CREATE TABLE users (
    u_id INT,
    username VARCHAR(50),
    email VARCHAR(50),
    password VARCHAR(50),
    city VARCHAR(100),
    state CHAR(2),
    PRIMARY KEY (u_id));


CREATE TABLE reviews (
    id INT,
    p_id INT,
    u_id INT,
    rating INT,
    review_text TEXT,
    timestamp TIMESTAMP,
    verified INT,
    serv_used CHAR(8),
    PRIMARY KEY (id),
    FOREIGN KEY (u_id) REFERENCES users(u_id),
    FOREIGN KEY (p_id) REFERENCES providers(p_id),
    CHECK(rating <=5 AND rating >=0));

*/


CREATE TABLE stateservices (
    s_id INT,
    state VARCHAR(2000),
    abort_minor VARCHAR(50),
    PRIMARY KEY (s_id));
