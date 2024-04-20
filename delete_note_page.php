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
    
    <style>
        /* Barn */
        body {
            background-image: url('images/barn.png');
            background-repeat: no-repeat;
            background-size: cover;
        }

        .input-container {
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            width: 500px;
            height: 400px;
            position: relative;
            left: 650px;
            top: -120px;
        }

        input[type="text"] {
            font-family: Arial, sans-serif;
            padding: 10px; /* Add padding */
            font-size: 16px; /* Set font size */
            border: 1px solid #ccc; /* Add border */
            border-radius: 5px; /* Add border-radius */
            margin-bottom: 10px; /* Add margin bottom */
            width: 100%; /* Occupy container width */
        }

        label {
            font-size: 28px;
            color: black;
            display: block;
            margin-bottom: 10px;
        }

        #deleteResult {
            margin-top: -420px;
            font-size: 28px;
            color: weight;
            font-family: Arial, sans-serif;
            text-align: center;
            font-weight: bold;
        }

        /* Homepage Button */
        .homepage-button {
            position: fixed;
            top: 376px;
            left: 257px;
            background-color: red;
            color: white;
            padding: 15px 32px;
            text-align: center;
            font-size: 32px;
            border: none;
            cursor: pointer;
            border-radius: 10px;
            font-weight: bold;
        }

        /* Delete Button */
        input[type="submit"].delete-button {
            background-color: #007BFF;
            font-family: Arial, sans-serif;
            padding: 10px 20px; /* Add padding */
            font-size: 16px; /* Set font size */
            font-weight: bold; /* Make button text bold */
            border: none; /* Remove border */
            color: #fff; /* Set text color */
            cursor: pointer; /* Add pointer cursor */
            border-radius: 5px; /* Add border-radius */
            margin-top: 5px;
        }

                /* Make search and delete buttons fixed */
        form {
            position: fixed;
        }

        form input[type="submit"] {
            position: fixed;
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
        <div class="input-container">
            <label for="note_name">Enter the name of the note to delete:</label>
            <input type="text" id="note_name" name="note_name" required maxlength="10">
            <br>
            <input type="submit" value="Delete" onclick="deleteNote()" class="delete-button">
        </div>
    </form>

    <div id="deleteResult"></div>

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
