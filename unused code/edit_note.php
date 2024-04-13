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

    // Get the note ID to edit
    $edit_id = $_POST['edit_id'];

    // Fetch the note from the database
    $sql = "SELECT * FROM notes WHERE id=$edit_id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Display the note details in a form for editing
        while ($row = $result->fetch_assoc()) {
            echo "Name: " . $row["name"]. " Address: " . $row["address"]. " Phone: " . $row["phone"]. " Email: " . $row["email"]. " Note: " . $row["note"]. "<br>";
            echo "<form action='update_note.php' method='post'>";
            echo "<input type='hidden' name='edit_id' value='" . $row["id"] . "'>";
            echo "<label for='name'>Name:</label>";
            echo "<input type='text' id='name' name='name' value='" . $row["name"] . "' required><br><br>";
            echo "<label for='address'>Address:</label>";
            echo "<input type='text' id='address' name='address' value='" . $row["address"] . "'><br><br>";
            echo "<label for='phone'>Phone:</label>";
            echo "<input type='text' id='phone' name='phone' value='" . $row["phone"] . "'><br><br>";
            echo "<label for='email'>Email:</label>";
            echo "<input type='email' id='email' name='email' value='" . $row["email"] . "'><br><br>";
            echo "<label for='note'>Note:</label><br>";
            echo "<textarea id='note' name='note' rows='4' cols='50' required>" . $row["note"] . "</textarea><br><br>";
            echo "<input type='submit' value='Update Note'>";
            echo "</form>";
        }
    } else {
        echo "No note found with ID: $edit_id";
    }

    $conn->close();
}
?>
