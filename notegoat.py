import re
import os

def load_existing_notes():
    notes = set()
    try:
        with open('notes.txt', 'r') as file:
            for line in file:
                line = line.strip()
                if line and line != '---------------':
                    notes.add(line)
    except FileNotFoundError:
        pass
    return notes

def add_note():
    existing_notes = load_existing_notes()

    name = input("Name: ").strip()
    if name in existing_notes:
        print(f"A note with the name '{name}' already exists.")
        return

    address = input("Address: ").strip()

    while True:
        phone = input("Phone number: ").strip()
        if phone.isdigit():
            break
        else:
            print("Invalid phone number. Please enter numbers only.")

    while True:
        email = input("Email address: ").strip()
        if '@' in email:
            break
        else:
            print("Missing @. Please enter a valid email address.")

    note = input("Note: ").strip()

    with open('notes.txt', 'a') as file:
        file.write(f"{name}\n{address}\n{phone}\n{email}\n{note}\n---------------\n")
    print("Note added successfully.")

def delete_note():
    search_name = input("Enter the name of the note to delete: ").strip()

    tempfile = 'temp.txt'
    deleted = False
    with open('notes.txt', 'r') as infile, open(tempfile, 'w') as outfile:
        delete = False
        for line in infile:
            if line.strip() == search_name and not delete:
                delete = True
                deleted = True
            elif delete and line.strip() == '---------------':
                delete = False
                continue
            if not delete:
                outfile.write(line)

    os.replace(tempfile, 'notes.txt')

    if deleted:
        print("Note deleted successfully.")
    else:
        print(f"No note with the name '{search_name}' found.")

def search_note():
    search_name = input("Enter the name of the note to search: ").strip()

    found = False
    with open('notes.txt', 'r') as file:
        for line in file:
            if line.strip() == search_name:
                found = True
                print(line.strip())
            elif found:
                if line.strip() == '---------------':
                    break
                print(line.strip())

def edit_note():
    search_name = input("Enter the name of the note to edit: ").strip()

    existing_notes = load_existing_notes()
    if search_name not in existing_notes:
        print(f"No note with the name '{search_name}' found.")
        return

    delete_note_by_name(search_name)
    add_note()
    print("Note edited successfully.")

def delete_note_by_name(search_name):
    tempfile = 'temp.txt'
    with open('notes.txt', 'r') as infile, open(tempfile, 'w') as outfile:
        delete = False
        for line in infile:
            if line.strip() == search_name and not delete:
                delete = True
            elif delete and line.strip() == '---------------':
                delete = False
                continue
            if not delete:
                outfile.write(line)

    os.replace(tempfile, 'notes.txt')

def main():
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
