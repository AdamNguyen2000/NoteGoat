<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Note has been added.</title>
    <style>
        .center-text {
            text-align: center;
        }

        .big-bold-text {
            font-size: 24px;
            font-weight: bold;
            font-family: Arial, sans-serif;
        }

        .custom-height {
            margin-top: -55px;
            position: relative;
        }

    </style>
</head>
<body>

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

    // Get form data
    $name = $_POST['name'];
    $address = $_POST['address'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $note = $_POST['note'];

    // Insert data into database
    $sql = "INSERT INTO notes (name, address, phone, email, note) VALUES ('$name', '$address', '$phone', '$email', '$note')";

    if ($conn->query($sql) === TRUE) {
        $message = "<span style='font-size: 30px; color: white;'>Note added successfully</span>";
        $class = "big-bold-text";
    } else {
        $message = "<span style='font-size: 30px; color: red;'>Error: " . $sql . "<br>" . $conn->error . "</span>";
        $class = "big-bold-text"; // Adjust the class as needed
    }
    ?>

    <!-- Output the message within HTML structure with CSS styles -->
    <div class="center-text <?php echo $class; ?> custom-height">
        <?php echo $message; ?>
    </div>

</body>
</html>

