def add_note():
    name = input("Name: ")
    address = input("Address: ")
    phone = input("Phone number: ")
    email = input("Email address: ")
    note = input("Note: ")

    with open("notes.txt", "a") as file:
        file.write(f"{name}|{address}|{phone}|{email}|{note}\n")
    print("Note added successfully.")

def delete_note():
    search_name = input("Enter the name of the note to delete: ")
    with open("notes.txt", "r+") as file:
        lines = file.readlines()
        file.seek(0)
        for line in lines:
            if not line.startswith(search_name):
                file.write(line)
        file.truncate()
    print("Note deleted successfully.")

def search_note():
    search_name = input("Enter the name of the note to search: ")
    with open("notes.txt", "r") as file:
        for line in file:
            if line.startswith(search_name):
                print(line.strip())

def edit_note():
    search_name = input("Enter the name of the note to edit: ")
    delete_note()
    add_note()
    print("Note edited successfully.")

while True:
    print("1. Add Note")
    print("2. Delete Note")
    print("3. Search Note")
    print("4. Edit Note")
    print("5. Exit")
    choice = int(input("Enter your choice: "))

    if choice == 1:
        add_note()
    elif choice == 2:
        delete_note()
    elif choice == 3:
        search_note()
    elif choice == 4:
        edit_note()
    elif choice == 5:
        break
    else:
        print("Invalid choice")