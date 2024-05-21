import re
import os

# The name of the file where the notes will be stored in SQL format
SQL_FILENAME = 'notes.sql'

def load_existing_notes():
    """
    Loads the existing notes from the SQL file.
    Returns a set of note names that are already in the file.
    """
    notes = set()
    try:
        with open(SQL_FILENAME, 'r') as file:
            for line in file:
                # Use regex to find note names in the INSERT INTO statements
                match = re.match(r"INSERT INTO notes \(name, address, phone, email, note\) VALUES \('([^']+)'", line)
                if match:
                    notes.add(match.group(1))  # Add the note name to the set
    except FileNotFoundError:
        pass  # If the file doesn't exist, return an empty set
    return notes

def write_sql_header():
    """
    Writes the SQL table header to the file if it does not already exist.
    This creates the table schema for storing notes.
    """
    if not os.path.exists(SQL_FILENAME):
        with open(SQL_FILENAME, 'w') as file:
            file.write("CREATE TABLE IF NOT EXISTS notes (\n")
            file.write("    id INTEGER PRIMARY KEY AUTOINCREMENT,\n")
            file.write("    name TEXT UNIQUE,\n")
            file.write("    address TEXT,\n")
            file.write("    phone TEXT,\n")
            file.write("    email TEXT,\n")
            file.write("    note TEXT\n")
            file.write(");\n\n")

def add_note():
    """
    Adds a new note to the SQL file.
    Ensures the note name is unique and collects other note details from the user.
    """
    existing_notes = load_existing_notes()

    name = input("Name: ").strip()
    if name in existing_notes:
        print(f"A note with the name '{name}' already exists.")
        return

    address = input("Address: ").strip()

    # Regex pattern to validate phone number
    phone_pattern = re.compile(r'^[0-9\s\-]+$')
    while True:
        phone = input("Phone number: ").strip()
        if phone_pattern.match(phone):
            break
        else:
            print("Invalid phone number. Please enter a valid phone number (digits, spaces, and hyphens allowed).")

    while True:
        email = input("Email address: ").strip()
        if '@' in email:
            break
        else:
            print("Missing @. Please enter a valid email address.")

    note = input("Note: ").strip()

    # Write the new note to the SQL file
    with open(SQL_FILENAME, 'a') as file:
        sql_command = f"INSERT INTO notes (name, address, phone, email, note) VALUES ('{name}', '{address}', '{phone}', '{email}', '{note}');\n"
        file.write(sql_command)
    print("Note added successfully.")

def delete_note():
    """
    Deletes a note from the SQL file based on the note name provided by the user.
    """
    search_name = input("Enter the name of the note to delete: ").strip()

    tempfile = 'temp.sql'
    deleted = False
    with open(SQL_FILENAME, 'r') as infile, open(tempfile, 'w') as outfile:
        for line in infile:
            if f"INSERT INTO notes (name, address, phone, email, note) VALUES ('{search_name}'," in line:
                deleted = True  # Mark as deleted
            else:
                outfile.write(line)  # Copy all other lines to the temp file

    os.replace(tempfile, SQL_FILENAME)  # Replace the original file with the updated file

    if deleted:
        print("Note deleted successfully.")
    else:
        print(f"No note with the name '{search_name}' found.")

def search_note():
    """
    Searches for a note in the SQL file by the note name provided by the user.
    Displays the note details if found.
    """
    search_name = input("Enter the name of the note to search: ").strip()

    found = False
    with open(SQL_FILENAME, 'r') as file:
        for line in file:
            if f"INSERT INTO notes (name, address, phone, email, note) VALUES ('{search_name}'," in line:
                found = True
                # Extract the values from the SQL command
                match = re.search(r"INSERT INTO notes \(name, address, phone, email, note\) VALUES \('([^']*)', '([^']*)', '([^']*)', '([^']*)', '([^']*)'\);", line)
                if match:
                    name, address, phone, email, note = match.groups()
                    print(f"Name: {name}")
                    print(f"Address: {address}")
                    print(f"Phone: {phone}")
                    print(f"Email: {email}")
                    print(f"Note: {note}")
                    print(f"---------------")
                break

    if not found:
        print(f"No note with the name '{search_name}' found.")

def edit_note():
    """
    Edits an existing note by first deleting the old note and then adding a new note with the same name.
    """
    search_name = input("Enter the name of the note to edit: ").strip()

    existing_notes = load_existing_notes()
    if search_name not in existing_notes:
        print(f"No note with the name '{search_name}' found.")
        return

    delete_note_by_name(search_name)  # Delete the old note
    add_note()  # Add a new note with the same name
    print("Note edited successfully.")

def delete_note_by_name(search_name):
    """
    Helper function to delete a note by name without user interaction.
    Used internally by edit_note.
    """
    tempfile = 'temp.sql'
    with open(SQL_FILENAME, 'r') as infile, open(tempfile, 'w') as outfile:
        for line in infile:
            if f"INSERT INTO notes (name, address, phone, email, note) VALUES ('{search_name}'," in line:
                continue  # Skip the line that matches the note to delete
            outfile.write(line)  # Copy all other lines to the temp file

    os.replace(tempfile, SQL_FILENAME)  # Replace the original file with the updated file

def main():
    """
    Main function to run the note-taking application.
    Displays a menu to the user for different actions: add, delete, search, edit, and exit.
    """
    write_sql_header()  # Ensure the SQL file has the table schema
    while True:
        print("1. Add Note")
        print("2. Delete Note")
        print("3. Search Note")
        print("4. Edit Note")
        print("5. Exit")
        choice = input("Enter your choice: ").strip()

        if choice == '1':
            add_note()
        elif choice == '2':
            delete_note()
        elif choice == '3':
            search_note()
        elif choice == '4':
            edit_note()
        elif choice == '5':
            break
        else:
            print("Invalid choice")

if __name__ == '__main__':
    main()
