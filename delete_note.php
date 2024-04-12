<?php
// If the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Connect to the database
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "notes_db";

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Get the note ID to delete
    $delete_id = $_POST['delete_id'];

    // Delete note from the database
    $sql = "DELETE FROM notes WHERE id=$delete_id";

    if ($conn->query($sql) === TRUE) {
        echo "Note deleted successfully";
    } else {
        echo "Error deleting note: " . $conn->error;
    }

    $conn->close();
}
?>
