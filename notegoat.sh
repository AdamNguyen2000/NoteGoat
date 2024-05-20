#!/bin/bash

# Function to add a note
add_note() {
    load_existing_notes

    echo -n "Name: "
    read name
    if [[ -n ${existing_notes["$name"]} ]]; then
        echo "A note with the name '$name' already exists."
        return
    fi

    echo -n "Address: "
    read address

    while true; do
        echo -n "Phone number: "
        read phone
        if [[ $phone =~ ^[0-9]+$ ]]; then
            break
        else
            echo "Invalid phone number. Please enter numbers only."
        fi
    done

    while true; do
        echo -n "Email address: "
        read email
        if [[ $email =~ @ ]]; then
            break
        else
            echo "Missing @. Please enter a valid email address."
        fi
    done

    echo -n "Note: "
    read note

    echo -e "$name\n$address\n$phone\n$email\n$note\n---------------" >> notes.txt
    echo "Note added successfully."
}

# Function to delete a note
delete_note() {
    echo -n "Enter the name of the note to delete: "
    read search_name

    tempfile=$(mktemp)
    delete=0
    deleted=0

    while IFS= read -r line; do
        if [[ $line == "$search_name" ]] && [[ $delete -eq 0 ]]; then
            delete=1
            deleted=1
        elif [[ $delete -eq 1 ]] && [[ $line == "---------------" ]]; then
            delete=0
            continue
        fi
        [[ $delete -eq 0 ]] && echo "$line" >> "$tempfile"
    done < notes.txt

    mv "$tempfile" notes.txt

    if [[ $deleted -eq 1 ]]; then
        echo "Note deleted successfully."
    else
        echo "No note with the name '$search_name' found."
    fi
}

# Function to search a note
search_note() {
    echo -n "Enter the name of the note to search: "
    read search_name

    found=0
    while IFS= read -r line; do
        if [[ $line == "$search_name" ]]; then
            found=1
            echo "$line"
        elif [[ $found -eq 1 ]]; then
            [[ $line == "---------------" ]] && break
            echo "$line"
        fi
    done < notes.txt
}

# Function to edit a note
edit_note() {
    echo -n "Enter the name of the note to edit: "
    read search_name

    load_existing_notes
    if [[ -z ${existing_notes["$search_name"]} ]]; then
        echo "No note with the name '$search_name' found."
        return
    fi

    delete_note_by_name "$search_name"
    add_note
    echo "Note edited successfully."
}

# Function to delete a note by name
delete_note_by_name() {
    search_name=$1

    tempfile=$(mktemp)
    delete=0

    while IFS= read -r line; do
        if [[ $line == "$search_name" ]] && [[ $delete -eq 0 ]]; then
            delete=1
        elif [[ $delete -eq 1 ]] && [[ $line == "---------------" ]]; then
            delete=0
            continue
        fi
        [[ $delete -eq 0 ]] && echo "$line" >> "$tempfile"
    done < notes.txt

    mv "$tempfile" notes.txt
}

# Function to load existing notes into an associative array
load_existing_notes() {
    declare -gA existing_notes
    while IFS= read -r line; do
        if [[ -n $line ]] && [[ $line != "---------------" ]]; then
            existing_notes["$line"]=1
        fi
    done < notes.txt
}

# Main menu loop
while true; do
    echo "1. Add Note"
    echo "2. Delete Note"
    echo "3. Search Note"
    echo "4. Edit Note"
    echo "5. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) add_note ;;
        2) delete_note ;;
        3) search_note ;;
        4) edit_note ;;
        5) exit ;;
        *) echo "Invalid choice" ;;
    esac
done
