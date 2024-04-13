<!DOCTYPE html>
<html>
<head>

    <title>Search Note</title>
    <link rel="stylesheet" type="text/css" href="styles.css">

    <h2 class="custom-font">Note Goat</h2>
    <div class="rectangle-rounded"></div>
    <div class="goat"><?php echo '<img src="images/goat.png" alt="Goat Image">' ?></div>
    <div class="sticky"><?php echo '<img src="images/sticky.png" alt="Sticky Note">' ?></div>
    <div class="pinksticky"><?php echo '<img src="images/pinksticky.png" alt="Pink Sticky">' ?></div>

    <style>
        /* Beach */
        body {
            background-image: url('images/beach.png');
            background-repeat: no-repeat;
            background-size: cover;
        }

        /* Container for search box */
        .container {
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            height: 200px;
            position: relative;
            left: 726px;
            top: -161px;
        }

        /* Search Note by Name: */
        label {
            font-family: Arial, sans-serif;
            margin-bottom: 9px; /* distance betweet search note by name as the text box */
            font-size: 31px;
            color: white;
        }

        /* Search Notes button */
        button {
            font-family: Arial, sans-serif;
            font-size: 24px;
            padding: 10px 20px; /* Add padding */
            font-size: 16px; /* Set font size */
            font-weight: bold; /* Make button text bold */
            border: none; /* Remove border */
            background-color: #007BFF; /* Set background color */
            color: #fff; /* Set text color */
            border-radius: 5px; /* Add border-radius */
            margin-top: 13px;
            margin-bottom: 10px;
            
        }

    </style>

    <script>
        function searchNote() {
            var searchValue = document.getElementById("search_name").value;

            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("searchResults").innerHTML = this.responseText;
                }
            };
            xhttp.open("POST", "display_results.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("search_name=" + searchValue);
        }
    </script>

</head>

<body>

<div class="container">
    <!-- Search Note Form -->
    <div class="actionForm">
        <form id="searchForm">
            <label for="search_name">Search Note by Name:</label>
            <input type="text" id="search_name" required>
            <button type="button" onclick="searchNote()">Search</button>
        </form>
        <div id="searchResults"></div>
    </div>
</div>

<!-- Switch pages button along with css -->
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


</body>

</html>
