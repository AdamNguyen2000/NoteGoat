#!/bin/bash

add_record() {
    echo -n "Patient's Name: "
    read name
    echo -n "Patient's Address: "
    read address
    echo -n "Patient's Phone: "
    read phone
    echo -n "Patient's Email: "
    read email
    echo -n "Patient's Condition: "
    read note

    echo -e "$name\n$address\n$phone\n$email\n$note\n--------------" >> MedicalDatabase.txt
    echo "Patient information added successfully to medical database."
}

delete_record() {
    echo -n "Enter Patient's name to delete record: "
    read search_name

    temp_file=$(mktemp)
    skip=0
    while IFS= read -r line; do
        if [[ "$line" == "$search_name" ]]; then
            skip=1
        elif [[ "$line" == "--------------" ]]; then
            skip=0
        elif [[ $skip -eq 0 ]]; then
            echo "$line" >> "$temp_file"
        fi
    done < MedicalDatabase.txt

    mv "$temp_file" MedicalDatabase.txt
    echo "Record deleted successfully."
}

search_record() {
    echo -n "Enter Patient's name to search record: "
    read search_name

    record_found=0
    while IFS= read -r line; do
        if [[ "$line" == "$search_name" ]]; then
            record_found=1
        fi
        if [[ $record_found -eq 1 ]]; then
            echo "$line"
            if [[ "$line" == "--------------" ]]; then
                record_found=0
            fi
        fi
    done < MedicalDatabase.txt

    echo "Search completed."
}

edit_record() {
    echo -n "Enter Patient's name to edit record: "
    read search_name

    temp_file=$(mktemp)
    skip=0
    while IFS= read -r line; do
        if [[ "$line" == "$search_name" ]]; then
            skip=1
        elif [[ "$line" == "--------------" ]]; then
            skip=0
        elif [[ $skip -eq 0 ]]; then
            echo "$line" >> "$temp_file"
        fi
    done < MedicalDatabase.txt

    mv "$temp_file" MedicalDatabase.txt
    add_record
    echo "Record edited successfully."
}

while true; do
    echo "1. Add Patient Record"
    echo "2. Delete Patient Record"
    echo "3. Search Patient Record"
    echo "4. Edit Patient Record"
    echo "5. Exit Medlink"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) add_record ;;
        2) delete_record ;;
        3) search_record ;;
        4) edit_record ;;
        5) exit ;;
        *) echo "Invalid choice" ;;
    esac
done
