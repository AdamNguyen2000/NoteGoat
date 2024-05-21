CREATE TABLE IF NOT EXISTS notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    address TEXT,
    phone TEXT,
    email TEXT,
    note TEXT
);

INSERT INTO notes (name, address, phone, email, note) VALUES ('adam', '1', '11', '1@', '1');
INSERT INTO notes (name, address, phone, email, note) VALUES ('Tom', '2', '1', '3@', '1');
INSERT INTO notes (name, address, phone, email, note) VALUES ('perl', '1', '1', '1@', '1');
INSERT INTO notes (name, address, phone, email, note) VALUES ('test', '1', '123-123-1234', '1@1', 'note');
