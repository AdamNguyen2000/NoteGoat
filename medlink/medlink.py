import os

def get_database_path():
    return os.path.join(os.path.dirname(__file__), 'MedicalDatabase.txt')

def add_record():
    name = input("Patient's Name: ").strip()
    address = input("Patient's Address: ").strip()
    phone = input("Patient's Phone: ").strip()
    email = input("Patient's Email: ").strip()
    note = input("Patient's Condition: ").strip()

    with open(get_database_path(), 'a') as file:
        file.write(f"{name}\n{address}\n{phone}\n{email}\n{note}\n--------------\n")
    
    print("Patient information added successfully to medical database.")

def delete_record():
    search_name = input("Enter Patient's name to delete record: ").strip()
    lines = []
    with open(get_database_path(), 'r') as file:
        lines = file.readlines()
    
    with open(get_database_path(), 'w') as file:
        skip = False
        for line in lines:
            if line.strip() == search_name:
                skip = True
            if not skip:
                file.write(line)
            if skip and line.strip() == '--------------':
                skip = False
    
    print("Record deleted successfully.")

def search_record():
    search_name = input("Enter Patient's name to search record: ").strip()
    found = False
    with open(get_database_path(), 'r') as file:
        for line in file:
            if line.strip().lower() == search_name.lower():
                found = True
                print(line, end='')
                continue
            if found:
                print(line, end='')
                if line.strip() == '--------------':
                    found = False
                    break
    
    print("Search completed.")

def edit_record():
    search_name = input("Enter Patient's name to edit record: ").strip()
    lines = []
    with open(get_database_path(), 'r') as file:
        lines = file.readlines()
    
    with open(get_database_path(), 'w') as file:
        skip = False
        for line in lines:
            if line.strip() == search_name:
                skip = True
            if not skip:
                file.write(line)
            if skip and line.strip() == '--------------':
                skip = False
    
    add_record()
    print("Record edited successfully.")

def main():
    while True:
        print("1. Add Patient Record")
        print("2. Delete Patient Record")
        print("3. Search Patient Record")
        print("4. Edit Patient Record")
        print("5. Exit Medlink")
        choice = input("Enter your choice: ").strip()

        if choice == '1':
            add_record()
        elif choice == '2':
            delete_record()
        elif choice == '3':
            search_record()
        elif choice == '4':
            edit_record()
        elif choice == '5':
            break
        else:
            print("Invalid choice")

if __name__ == "__main__":
    main()
