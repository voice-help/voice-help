CREATE TABLE record (
    record_id VARCHAR(256) PRIMARY KEY,
    file_id VARCHAR (256) NOT NULL,
    record_name VARCHAR (128) NOT NULL,
    create_user VARCHAR (128) NOT NULL,
    create_date TIMESTAMP NOT NULL
);

CREATE TABLE record_file(
    file_id VARCHAR(256) PRIMARY KEY,
    file_name VARCHAR (128) NOT NULL,
    file_extension VARCHAR (128) NOT NULL
);

ALTER TABLE record ADD CONSTRAINT FK_RECORD_FILE FOREIGN KEY (file_id) REFERENCES record_file (file_id);