/* create tables. */
CREATE TABLE photo (
    photo_id INT NOT NULL,
    title VARCHAR(60),
    `description` VARCHAR(200),
    url VARCHAR(2000),
    date_taken DATETIME,
    date_uploaded DATETIME,
    filepath VARCHAR(120),
    user_id INT,
    location_id INT,
    camera_id INT,
    PRIMARY KEY (photo_id)
);

CREATE TABLE Camera (
    brand VARCHAR(60),
    model VARCHAR(120),
    camera_type VARCHAR(60),
    iso INT,
    f_stop FLOAT,
    shutter_speed FLOAT,
    camera_id INT NOT NULL,
    lens_id INT,
    PRIMARY KEY (camera_id)
);

CREATE TABLE lens (
    brand VARCHAR(60),
    model VARCHAR(120),
    min_focal_length FLOAT,
    max_focal_length FLOAT,
    max_aperture INT,
    lens_id INT NOT NULL,
    PRIMARY KEY (lens_id)
);

CREATE TABLE location (
    city VARCHAR(120),
    province_state VARCHAR(120),
    country VARCHAR(120),
    latitude FLOAT,
    longitude FLOAT,
    location_id INT NOT NULL,
    PRIMARY KEY (location_id)
);

CREATE TABLE `user` (
    user_id INT NOT NULL,
    username VARCHAR(60),
    email VARCHAR(120),
    date_joined DATE,
    PRIMARY KEY (user_id)
);


/* create foreign keys. */
ALTER TABLE photo
    ADD FOREIGN KEY (camera_id)
    REFERENCES Camera (camera_id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

ALTER TABLE Camera
    ADD FOREIGN KEY (lens_id)
    REFERENCES lens (lens_id)
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

