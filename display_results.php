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

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get search criteria
    $search_name = $_POST['search_name'];

    // Prepare SQL statement
    $sql = "SELECT * FROM notes WHERE name LIKE ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $search_name_like);
    
    // Set parameter
    $search_name_like = '%' . $search_name . '%';

    // Execute query
    $stmt->execute();
    
    // Get result
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Display search results
        while ($row = $result->fetch_assoc()) {
            echo "<div style='font-size: 35px; color: white; font-family: Arial;'>";
            echo "<strong>Name:</strong> " . $row["name"]. "<br>";
            echo "<strong>Address:</strong> " . $row["address"]. "<br>";
            echo "<strong>Phone:</strong> " . $row["phone"]. "<br>";
            echo "<strong>Email:</strong> " . $row["email"]. "<br>";
            echo "<strong>Note:</strong> " . $row["note"]. "<br>";
            echo "</div>";
            echo "<br>"; // Add a line break for spacing
        }
    } else {
        echo "<div style='font-size: 34px; color: red; font-family: Arial;font-weight:bold'>";
        echo "No notes found matching the search criteria.";
        echo "</div>";
    }

    // Close statement
    $stmt->close();
}

$conn->close();
?>
