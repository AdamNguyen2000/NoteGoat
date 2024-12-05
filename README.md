### Screenshots/Diagram
![Note Goat drawio (1)](https://github.com/user-attachments/assets/37ac43ec-c2bb-40fd-af87-d293ad89eccf)
![2024-12-04_18h17_16](https://github.com/user-attachments/assets/1494fb96-2d55-47d8-b101-020aa272cb55)
![2024-12-04_18h17_46](https://github.com/user-attachments/assets/e594ff8d-a72b-4fae-be3d-a9cdf7a99da1)

---

# NoteGoat

## Description
**Note Goat** is a command-line note-taking program designed for users to manage contact notes efficiently. The program allows users to add, delete, search, edit, and display notes using simple menu-driven inputs.

The core functionality is implemented in a shell script (`notegoat.sh`), incorporating modular operations for note management, and could be extended with additional tools like MySQL for persistent storage or Python for advanced processing.

---

### Features Implemented
1. **Menu-Driven Interface**
   - A simple text-based interface allows users to choose actions from a menu of five options:
     1. Add Note
     2. Delete Note
     3. Search Note
     4. Edit Note
     5. Exit the Program

2. **Add Note**
   - Users can input details for a new note, including:
     - Name
     - Address
     - Phone
     - Email
     - Additional Notes
   - Once all inputs are provided, the note is saved.

3. **Delete Note**
   - Users can delete a note by providing its name.
   - Confirmation of deletion is displayed.

4. **Search Note**
   - Search functionality allows users to retrieve a note by name.
   - If found, the note details are displayed.

5. **Edit Note**
   - Users can edit an existing note by entering its name and specifying the updated information.
   - Changes are saved and confirmed.

6. **Exit**
   - The program gracefully exits when users choose option 5.

---

### Program Flow
The program's flow is clearly outlined in the attached diagram, which includes the following key elements:
- **Input from Users:** 
  - For each menu option, users provide relevant data via the command line.
- **Backend Logic:**
  - Notes are processed, saved, and displayed dynamically based on user inputs.
- **Feedback to Users:**
  - Informational messages such as "New Note Saved," "Note Deleted," "Display Note," and "Changes Saved" provide clear feedback.

---

### Benefits
- **User-Friendly:** Designed for non-technical users who need a lightweight tool for storing and managing notes.
- **Portable:** Works on any system with shell scripting support.
- **Scalable:** Potential integration with MySQL or Python to enhance features.

---

### Future Enhancements
- Add persistent storage using a database (MySQL).
- Implement search functionality with advanced filtering (e.g., by phone number or email).
- Add data export/import features (e.g., CSV format).
- Integrate with Python for a GUI or RESTful APIs.

---

### How to Run
1. Clone the repository.
2. Open XAAMP and start Apache and MySQL
2. Put the project directory in to htdocs in XAMPP
3. Setup database tables in http://localhost/phpmyadmin
4. Access the web interface at http://localhost/NoteGoat/Homepage.php




