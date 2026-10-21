/* create tables. */
CREATE TABLE photo (
    photo_id INT NOT NULL,
    title VARCHAR(60),
    `description` VARCHAR(200),
    url VARCHAR(2000),
    filepath VARCHAR(120),
    date_taken DATETIME,
    date_uploaded DATETIME,
    user_id INT NOT NULL,
    location_id INT,
    camera_id INT NOT NULL,
    lens_id INT NOT NULL,
    iso INT,
    f_stop FLOAT,
    shutter_speed FLOAT,
    PRIMARY KEY (photo_id),
    CHECK ((url IS NULL AND filepath IS NOT NULL) OR (url IS NOT NULL AND filepath IS NULL))
);

CREATE TABLE camera (
    brand VARCHAR(60),
    model VARCHAR(120),
    camera_type VARCHAR(60),
    camera_id INT NOT NULL,
    lens_id INT NOT NULL,
    PRIMARY KEY (camera_id, lens_id)
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

CREATE TABLE city (
    city_name VARCHAR(120),
    province_state VARCHAR(120),
    country VARCHAR(120),
    city_id INT NOT NULL,
    PRIMARY KEY (city_id)
);

CREATE TABLE `user` (
    user_id INT NOT NULL,
    username VARCHAR(60) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    date_joined DATE,
    PRIMARY KEY (user_id)
);

CREATE TABLE camera_settings (
    iso INT NOT NULL,
    f_stop FLOAT NOT NULL,
    shutter_speed FLOAT NOT NULL,
    PRIMARY KEY (iso, f_stop, shutter_speed)
);

CREATE TABLE `follows` (
    followed_user_id INT,
    following_user_id INT
);

CREATE TABLE location (
    latitude FLOAT,
    longitude FLOAT,
    city_id INT,
    location_id INT NOT NULL,
    PRIMARY KEY (location_id),
    CHECK ((latitude IS NULL AND longitude IS NULL) OR (latitude IS NOT NULL AND longitude IS NOT NULL))
);

/* create foreign keys. */
ALTER TABLE location
    ADD FOREIGN KEY (city_id)
    REFERENCES city (city_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE camera
    ADD FOREIGN KEY (lens_id)
    REFERENCES lens (lens_id)
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
    ADD FOREIGN KEY (camera_id)
    REFERENCES `camera` (camera_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (lens_id)
    REFERENCES `camera` (lens_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (location_id)
    REFERENCES location (location_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (iso)
    REFERENCES camera_settings (iso)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (f_stop)
    REFERENCES camera_settings (f_stop)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE photo
    ADD FOREIGN KEY (shutter_speed)
    REFERENCES camera_settings (shutter_speed)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;