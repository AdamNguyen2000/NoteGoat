<?php
// Connect to database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "notes_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get search criteria
$search_name = $_POST['search_name'];

// Search for notes matching the search criteria
$sql = "SELECT * FROM notes WHERE name LIKE '%$search_name%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Display search results
    while ($row = $result->fetch_assoc()) {
        echo " Name: " . $row["name"]. "<br>";
        echo " Address: " . $row["address"]. "<br>";
        echo " Phone: " . $row["phone"]. "<br>";
        echo " Email: " . $row["email"]. "<br>";
        echo " Note: " . $row["note"]. "<br>";
    }
} else {
    echo "No notes found matching the search criteria.";
}

$conn->close();
?>
