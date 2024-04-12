<!DOCTYPE html>
<html>
<head>
    <title>The Best Note Taking App</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    
    <h2 class="custom-font">Note Goat</h2>
    <div class="rectangle-rounded"></div>
    
    <div class="container">
        <?php echo '<img src="goat.png" alt="Goat Image">' ?>
    </div>

    <form id="addNoteForm">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>
        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address"><br><br>
        <label for="phone">Phone:</label><br>
        <input type="text" id="phone" name="phone"><br><br>
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email"><br><br>
        <label for="note">Note:</label><br>
        <textarea id="note" name="note" rows="4" cols="50" required></textarea><br>
        <input type="button" value="Add Note" onclick="addNote()">
    </form>

    <br><div id="addNoteMessage"></div>

    <h2>Actions</h2>

    <!-- Edit Note Form -->
    <div class="actionForm">
        <h3>Edit Note</h3>
        <form action="edit_note.php" method="post">
            <label for="edit_id">Enter Note ID to Edit:</label>
            <input type="number" id="edit_id" name="edit_id" required><br><br>
            <input type="submit" value="Edit Note">
        </form>
    </div>

    <!-- Search Note Form -->
    <div class="actionForm">
        <h3>Search Note</h3>
        <form id="searchForm">
            <label for="search_name">Search Note by Name:</label>
            <input type="text" id="search_name" name="search_name" required>
            <button type="button" onclick="searchNote()">Search Note</button>
        </form>
        <div id="searchResults"></div>
    </div>

    <!-- Delete Note Form -->
    <div class="actionForm">
        <h3>Delete Note</h3>
        <form action="delete_note.php" method="post">
            <label for="delete_id">Enter Note ID to Delete:</label>
            <input type="number" id="delete_id" name="delete_id" required><br><br>
            <input type="submit" value="Delete Note">
        </form>
    </div>

    <a href="index1.php">Return to PHP Homepage</a>

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

        function searchNote() {
            var searchValue = document.getElementById("search_name").value;

            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    document.getElementById("searchResults").innerHTML = this.responseText;
                }
            };
            xhttp.open("POST", "search_note.php", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("search_name=" + searchValue);
        }
    </script>
</body>
</html>
