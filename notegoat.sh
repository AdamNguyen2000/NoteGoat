#!/bin/bash

# Define the name of the SQL file where notes will be stored
SQL_FILENAME="notes.sql"

# Ensure the SQL file exists and has the correct header
function write_sql_header {
    if [ ! -f "$SQL_FILENAME" ]; then
        # Create the SQL file with the appropriate table structure
        echo "CREATE TABLE IF NOT EXISTS notes (" > "$SQL_FILENAME"
        echo "    id INTEGER PRIMARY KEY AUTOINCREMENT," >> "$SQL_FILENAME"
        echo "    name TEXT UNIQUE," >> "$SQL_FILENAME"
        echo "    address TEXT," >> "$SQL_FILENAME"
        echo "    phone TEXT," >> "$SQL_FILENAME"
        echo "    email TEXT," >> "$SQL_FILENAME"
        echo "    note TEXT" >> "$SQL_FILENAME"
        echo ");" >> "$SQL_FILENAME"
        echo "" >> "$SQL_FILENAME"
    fi
}

# Load existing notes into a list
function load_existing_notes {
    if [ -f "$SQL_FILENAME" ]; then
        # Extract existing note names from the SQL file
        grep -oP "INSERT INTO notes \(name, address, phone, email, note\) VALUES \('\K[^']+" "$SQL_FILENAME"
    fi
}

# Add a new note
function add_note {
    local existing_notes=$(load_existing_notes)
    local name address phone email note

    read -p "Name: " name
    if echo "$existing_notes" | grep -q "^$name$"; then
        echo "A note with the name '$name' already exists."
        return
    fi

    read -p "Address: " address

    # Validate phone number to allow digits, spaces, and hyphens
    while true; do
        read -p "Phone number: " phone
        if [[ "$phone" =~ ^[0-9\s\-]+$ ]]; then
            break
        else
            echo "Invalid phone number. Please enter a valid phone number (digits, spaces, and hyphens allowed)."
        fi
    done

    # Validate email to ensure it contains '@'
    while true; do
        read -p "Email address: " email
        if [[ "$email" =~ @ ]]; then
            break
        else
            echo "Missing @. Please enter a valid email address."
        fi
    done

    read -p "Note: " note

    # Append the new note to the SQL file
    echo "INSERT INTO notes (name, address, phone, email, note) VALUES ('$name', '$address', '$phone', '$email', '$note');" >> "$SQL_FILENAME"
    echo "Note added successfully."
}

# Delete a note
function delete_note {
    local search_name tempfile
    read -p "Enter the name of the note to delete: " search_name

    # Create a temporary file to store the updated SQL content
    tempfile=$(mktemp)
    local deleted=0

    # Copy all lines except the one to be deleted to the temporary file
    while IFS= read -r line; do
        if [[ "$line" != "INSERT INTO notes (name, address, phone, email, note) VALUES ('$search_name',"* ]]; then
            echo "$line" >> "$tempfile"
        else
            deleted=1
        fi
    done < "$SQL_FILENAME"

    # Replace the original file with the updated content
    mv "$tempfile" "$SQL_FILENAME"

    if [ $deleted -eq 1 ]; then
        echo "Note deleted successfully."
    else
        echo "No note with the name '$search_name' found."
    fi
}

# Search for a note
function search_note {
    local search_name
    read -p "Enter the name of the note to search: " search_name

    local found=0

    # Read each line in the SQL file and search for the matching note
    while IFS= read -r line; do
        if [[ "$line" == "INSERT INTO notes (name, address, phone, email, note) VALUES ('$search_name',"* ]]; then
            # Extract and print the note details
            echo "$line" | sed -E "s/INSERT INTO notes \(name, address, phone, email, note\) VALUES \('([^']*)', '([^']*)', '([^']*)', '([^']*)', '([^']*)'\);/Name: \1\nAddress: \2\nPhone: \3\nEmail: \4\nNote: \5/"
            found=1
            break
        fi
    done < "$SQL_FILENAME"

    if [ $found -eq 0 ]; then
        echo "No note with the name '$search_name' found."
    fi
}

# Edit a note
function edit_note {
    local search_name
    read -p "Enter the name of the note to edit: " search_name

    local existing_notes=$(load_existing_notes)
    if ! echo "$existing_notes" | grep -q "^$search_name$"; then
        echo "No note with the name '$search_name' found."
        return
    fi

    # Delete the old note and add a new one
    delete_note_by_name "$search_name"
    add_note
    echo "Note edited successfully."
}

# Delete a note by name without user interaction
function delete_note_by_name {
    local search_name="$1"
    local tempfile
    tempfile=$(mktemp)

    # Copy all lines except the one to be deleted to the temporary file
    while IFS= read -r line; do
        if [[ "$line" != "INSERT INTO notes (name, address, phone, email, note) VALUES ('$search_name',"* ]]; then
            echo "$line" >> "$tempfile"
        fi
    done < "$SQL_FILENAME"

    # Replace the original file with the updated content
    mv "$tempfile" "$SQL_FILENAME"
}

# Main menu loop
function main {
    write_sql_header
    while true; do
        echo "1. Add Note"
        echo "2. Delete Note"
        echo "3. Search Note"
        echo "4. Edit Note"
        echo "5. Exit"
        read -p "Enter your choice: " choice

        case $choice in
            1) add_note ;;
            2) delete_note ;;
            3) search_note ;;
            4) edit_note ;;
            5) break ;;
            *) echo "Invalid choice" ;;
        esac
    done
}

# Run the main function
main
