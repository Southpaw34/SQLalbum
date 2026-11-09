/* Revised photo library schema — MySQL 8.0.16+ */
/* Create tables in dependency order. */

CREATE TABLE `user` (
    user_id INT NOT NULL,
    username VARCHAR(60) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    date_joined DATE,
    PRIMARY KEY (user_id)
);

CREATE TABLE lens (
    brand VARCHAR(60),
    model VARCHAR(120),
    min_focal_length FLOAT,
    max_focal_length FLOAT,
    max_aperture FLOAT,
    lens_id INT NOT NULL,
    PRIMARY KEY (lens_id)
);

CREATE TABLE camera (
    brand VARCHAR(60),
    model VARCHAR(120),
    camera_type VARCHAR(60),
    camera_id INT NOT NULL,
    PRIMARY KEY (camera_id)
);

CREATE TABLE camera_lenses (
    camera_id INT NOT NULL,
    lens_id INT NOT NULL,
    PRIMARY KEY (camera_id, lens_id)
);

CREATE TABLE camera_settings (
    settings_id INT NOT NULL,
    iso INT NOT NULL,
    f_stop FLOAT NOT NULL,
    shutter_speed FLOAT NOT NULL,
    PRIMARY KEY (settings_id)
);

CREATE TABLE province_state (
    province_state_id INT NOT NULL,
    province_state_name VARCHAR(120) NOT NULL,
    country VARCHAR(120) NOT NULL,
    PRIMARY KEY (province_state_id),
    UNIQUE (province_state_name, country)
);

CREATE TABLE city (
    city_name VARCHAR(120),
    province_state_id INT NOT NULL,
    city_id INT NOT NULL,
    PRIMARY KEY (city_id)
);

CREATE TABLE location (
    latitude FLOAT,
    longitude FLOAT,
    city_id INT NOT NULL,
    location_id INT NOT NULL,
    PRIMARY KEY (location_id),
    CHECK ((latitude IS NULL AND longitude IS NULL)
        OR (latitude IS NOT NULL AND longitude IS NOT NULL))
);

CREATE TABLE `follows` (
    followed_user_id INT NOT NULL,
    following_user_id INT NOT NULL,
    PRIMARY KEY (followed_user_id, following_user_id),
    CHECK (followed_user_id <> following_user_id)
);

CREATE TABLE photo (
    photo_id INT NOT NULL,
    title VARCHAR(60),
    `description` VARCHAR(200),
    url VARCHAR(2000),
    filepath VARCHAR(120),
    date_taken DATETIME,
    date_uploaded DATETIME,
    user_id INT NOT NULL,
    location_id INT NOT NULL,
    camera_id INT NOT NULL,
    lens_id INT NOT NULL,
    settings_id INT NOT NULL,
    PRIMARY KEY (photo_id),
    CHECK ((url IS NULL AND filepath IS NOT NULL)
        OR (url IS NOT NULL AND filepath IS NULL))
);

/* Create foreign keys. */
ALTER TABLE camera_lenses
    ADD FOREIGN KEY (camera_id)
    REFERENCES camera (camera_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE camera_lenses
    ADD FOREIGN KEY (lens_id)
    REFERENCES lens (lens_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE city
    ADD FOREIGN KEY (province_state_id)
    REFERENCES province_state (province_state_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE location
    ADD FOREIGN KEY (city_id)
    REFERENCES city (city_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE `follows`
    ADD FOREIGN KEY (following_user_id)
    REFERENCES `user` (user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE `follows`
    ADD FOREIGN KEY (followed_user_id)
    REFERENCES `user` (user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (user_id)
    REFERENCES `user` (user_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (location_id)
    REFERENCES location (location_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (camera_id, lens_id)
    REFERENCES camera_lenses (camera_id, lens_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (settings_id)
    REFERENCES camera_settings (settings_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;
