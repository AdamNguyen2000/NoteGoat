<?php
// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Check if the note_name parameter is set
    if (isset($_POST["note_name"])) {
        // Sanitize the input to prevent SQL injection
        $note_name = htmlspecialchars($_POST["note_name"]);

        // Connect to your database (replace with your database credentials)
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "notes_db";

        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Prepare a select statement to check if the note exists
        $sql_check = "SELECT * FROM notes WHERE name = ?";
        $stmt_check = $conn->prepare($sql_check);
        $stmt_check->bind_param("s", $note_name);
        $stmt_check->execute();
        $result_check = $stmt_check->get_result();

        // If the note exists, proceed with deletion
        if ($result_check->num_rows > 0) {
            // Prepare a delete statement
            $sql_delete = "DELETE FROM notes WHERE name = ?";
            $stmt_delete = $conn->prepare($sql_delete);
            $stmt_delete->bind_param("s", $note_name);

            // Attempt to execute the delete statement
            if ($stmt_delete->execute()) {
                // Note deleted successfully
                echo "Note deleted successfully.";
            } else {
                // Error executing the delete statement
                echo "Error deleting note: " . $stmt_delete->error;
            }

            // Close statement
            $stmt_delete->close();
        } else {
            // Note does not exist
            echo "Note does not exist.";
        }

        // Close statement
        $stmt_check->close();

        // Close connection
        $conn->close();
    } else {
        // If note_name parameter is not set
        echo "Note name parameter is not set.";
    }
} else {
    // If the form is not submitted via POST method
    echo "Form not submitted.";
}
?>
