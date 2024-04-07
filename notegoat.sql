CREATE TABLE Notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    note TEXT
);

DELIMITER //
CREATE PROCEDURE add_note(
    IN name VARCHAR(255),
    IN address VARCHAR(255),
    IN phone VARCHAR(20),
    IN email VARCHAR(255),
    IN note TEXT
)
BEGIN
    INSERT INTO Notes (name, address, phone, email, note)
    VALUES (name, address, phone, email, note);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE delete_note(
    IN search_name VARCHAR(255)
)
BEGIN
    DELETE FROM Notes WHERE name = search_name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE search_note(
    IN search_name VARCHAR(255)
)
BEGIN
    SELECT * FROM Notes WHERE name = search_name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE edit_note(
    IN search_name VARCHAR(255),
    IN new_name VARCHAR(255),
    IN new_address VARCHAR(255),
    IN new_phone VARCHAR(20),
    IN new_email VARCHAR(255),
    IN new_note TEXT
)
BEGIN
    UPDATE Notes 
    SET name = new_name, address = new_address, phone = new_phone, email = new_email, note = new_note
    WHERE name = search_name;
END //
DELIMITER ;