<!DOCTYPE html>
<html>
<head>

    <title>Delete Note</title>
    <link rel="stylesheet" type="text/css" href="styles.css">

    <h2 class="custom-font">Delete</h2>
    <div class="rectangle-rounded"></div>
    <div class="goat"><?php echo '<img src="images/goat.png" alt="Goat Image">' ?></div>
    <div class="sticky"><?php echo '<img src="images/sticky.png" alt="Sticky Note">' ?></div>
    <div class="crumpled"><?php echo '<img src="images/crumpled.png" alt="Crumpled Note">' ?></div>
1
    <style>
        /* Barn */
        body {
            background-image: url('images/barn.png');
            background-repeat: no-repeat;
            background-size: cover;
        }
        
        input[type="text"] {
            font-family: Arial, sans-serif;
            padding: 10px; /* Add padding */
            font-size: 16px; /* Set font size */
            border: 1px solid #ccc; /* Add border */
            border-radius: 5px; /* Add border-radius */
            margin-bottom: 10px; /* Add margin bottom */
        }

        input[type="submit"] {
            font-family: Arial, sans-serif;
            padding: 10px 20px; /* Add padding */
            font-size: 16px; /* Set font size */
            font-weight: bold; /* Make button text bold */
            border: none; /* Remove border */
            background-color: #007BFF; /* Set background color */
            color: #fff; /* Set text color */
            cursor: pointer; /* Add pointer cursor */
            border-radius: 5px; /* Add border-radius */
        }

        #deleteResult {
            margin-top: 20px;
        }
    </style>


    <script>
        function deleteNote() {
            var noteName = document.getElementById("note_name").value;

            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("deleteResult").innerHTML = this.responseText;
                }
            };
            xhttp.open("POST", "delete_note.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("note_name=" + noteName);
        }
    </script>
</head>
<body>
    <form method="post" action="javascript:void(0);">
        <label for="note_name">Enter the name of the note to delete:</label>
        <input type="text" id="note_name" name="note_name" required maxlength="10">
        <input type="submit" value="Delete" onclick="deleteNote()">
    </form>
    <div id="deleteResult"></div>
</body>

<?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Handle button click here
        header("Location: Homepage.php"); // Redirect to another PHP file
        exit();
    }
?>

<form method="post">
    <input type="submit" value="  Homepage " style="background-color: red; color: white; padding: 15px 32px; text-align: center; font-size: 32px; 
    margin: 4px 2px; border: none; cursor: pointer; border-radius: 10px; font-weight: bold; position: relative; top: -329px; left: 247px;">


</html>
