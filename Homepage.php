<!DOCTYPE html>
<html>
<head>
    
    <title>NoteGoat.com</title>
    <link rel="stylesheet" type="text/css" href="styles.css">

    <h2 class="custom-font">Note Goat</h2>
    <div class="rectangle-rounded"></div>
    <div class="goat"><?php echo '<img src="images/goat.png" alt="Goat Image">' ?></div>
    <div class="sticky"><?php echo '<img src="images/sticky.png" alt="Sticky Note">' ?></div>
    <div class="paper"><?php echo '<img src="images/paper.png" alt="Paper">' ?></div>

    <style>
        /* Jungle */
        body {
            background-image: url('images/jungle.png');
            background-repeat: no-repeat;
            background-size: cover;
        }
        
        input[type="button"] {
            font-family: Arial, sans-serif;
            padding: 10px 20px; /* Add padding */
            font-size: 16px; /* Set font size */
            font-weight: bold; /* Make button text bold */
            border: none; /* Remove border */
            background-color: #007BFF; /* Set background color */
            color: #fff; /* Set text color */
            cursor: pointer; /* Add pointer cursor */
            border-radius: 5px; /* Add border-radius */
            position: relative;
            top: 7px;
        }

        /* Make search and delete buttons fixed */
        form {
            position: fixed;
        }

        form input[type="submit"] {
            position: fixed;
        }
    </style>
    
</head>

<body>
<form id="addNoteForm">

    <label for="name">Name</label><input type="text" id="name" name="name" required>
    <label for="address">Address</label><input type="text" id="address" name="address">
    <label for="phone">Phone</label><input type="text" id="phone" name="phone">
    <label for="email">Email</label><input type="email" id="email" name="email">
    <label for="note">Note</label><textarea id="note" name="note" rows="3" required></textarea>
    <input type="button" value="Add Note" onclick="addNote()">

</form>

    <div id="addNoteMessage"></div>

    <script>
        function addNote() {
            var formData = new FormData(document.getElementById("addNoteForm"));

            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("addNoteMessage").innerHTML = this.responseText;
                }
            };
            xhttp.open("POST", "add_note.php", true);
            xhttp.send(formData);
        }
    </script>

<?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        if (isset($_POST['search'])) {
            header("Location: search_note_page.php");
            exit();
        } elseif (isset($_POST['delete'])) {
            header("Location: delete_note_page.php");
            exit();
        } elseif (isset($_POST['edit'])) {
            header("Location: edit_note_page.php");
            exit();
        } elseif (isset($_POST['Homepage'])) {
            header("Location: Homepage.php");
            exit();
        }
    }
?>

<form method="post">
    <input type="submit" name="Homepage" value=" Homepage  " style="background-color: #fff16e; color: black; padding: 15px 32px; text-align: center; font-size: 32px; 
    margin: 4px 2px; border: none; cursor: pointer; border-radius: 10px; font-weight: bold; top: 100px; left: 20px;">

    <input type="submit" name="search" value="Search Note" style="background-color: #fff16e; color: black; padding: 15px 32px; text-align: center; font-size: 32px; 
    margin: 4px 2px; border: none; cursor: pointer; border-radius: 10px; font-weight: bold; top: 200px; left: 20px;">
    
    <input type="submit" name="delete" value="Delete  Note" style="background-color: #fff16e; color: black; padding: 15px 32px; text-align: center; font-size: 32px; 
    margin: 4px 2px; border: none; cursor: pointer; border-radius: 10px; font-weight: bold; top: 300px; left: 20px;">

    <input type="submit" name="edit" value="  Edit Note   " style="background-color: #fff16e; color: black; padding: 15px 32px; text-align: center; font-size: 32px; 
    margin: 4px 2px; border: none; cursor: pointer; border-radius: 10px; font-weight: bold; top: 400px; left: 20px;">
</form>

</body>

</html>
