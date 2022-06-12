drop database social_media;
create database social_media;

\c social_media

CREATE TABLE Social_user
(       Serv_id CHAR(9) NOT NUll,
	user_name CHAR(50) NOT NULL,
	user_id INT NOT NULL,
	passwd CHAR(50) NOT NULL,
	email_id CHAR(225) NOT NULL,
        age INT NOT NULL,
        gender CHAR(50) NOT NULL,
        DOB DATE,
	fname CHAR(50) NOT NULL,
	lname CHAR(50) NOT NULL,
	contactNo BIGINT NOT NULL,
    	city CHAR(50) NOT NULL,
    	user_state CHAR(50) NOT NULL,
    	country CHAR(50) NOT NULL,
    	PRIMARY KEY (user_id));

CREATE TABLE user_profile
(
    user_profile_id INT,
    senior_school CHAR(100),
    college CHAR(100),
    university CHAR(100),
    work_profile CHAR(100),
    about_you TEXT,
    hobbies TEXT,
    skills TEXT,
    relationship_status CHAR(100),
    user_id INT,
    PRIMARY KEY (user_profile_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id)
);

CREATE TABLE friends
(
    friend_id INT NOT NULL,
    f_email VARCHAR(100) NOT NULL,
    approval_status TEXT NOT NULL DEFAULT 'waiting',
    "ReqRes_Details" TEXT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (friend_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id) 
        
);

CREATE TABLE testimonial
(
    tr_id INT NOT NULL,
    testimonial VARCHAR(100),
    like_status TEXT DEFAULT 'no response',

    posting_time TIMESTAMP without time zone,

    user_id serial NOT NULL,
    PRIMARY KEY (tr_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id) 
);
CREATE TABLE photos
(
    photo_id INT NOT NULL,
    photo_link VARCHAR(100) NOT NULL,
    caption VARCHAR(200),

    upload_time timestamp without time zone NOT NULL,

    like_status TEXT DEFAULT 'no response',

    "isProfile_photo" TEXT NOT NULL DEFAULT 'No',
    user_id INT NOT NULL,
    tr_id INT NOT NULL,
    PRIMARY KEY (photo_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id),
    FOREIGN KEY (tr_id) REFERENCES testimonial (tr_id)
);
CREATE TABLE scrap
(
    scrap_id INT NOT NULL,
    scrap VARCHAR(50),

    like_status TEXT DEFAULT 'no response',

    posting_time TIMESTAMP without time zone NOT NULL,

    user_id INT NOT NULL,
    tr_id INT NOT NULL,
    PRIMARY KEY (scrap_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id),
    FOREIGN KEY (tr_id) REFERENCES testimonial (tr_id) 
);

CREATE TABLE user_status
(
    status_id INT NOT NULL,

    posting_time TIMESTAMP without time zone NOT NULL,

    update_status TEXT NOT NULL DEFAULT 'saved to draft',
    user_id INT NOT NULL,
    tr_id INT,
    PRIMARY KEY (status_id),
    FOREIGN KEY (user_id) REFERENCES Social_user (user_id),
    FOREIGN KEY (tr_id) REFERENCES testimonial (tr_id)
);


