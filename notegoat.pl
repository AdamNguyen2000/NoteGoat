use strict;
use warnings;
use File::Copy qw(move);

# The name of the file where the notes will be stored in SQL format
my $SQL_FILENAME = 'notes.sql';

sub load_existing_notes {
    # Load existing notes from the SQL file into a hash
    my %notes;
    if (open my $file, '<', $SQL_FILENAME) {
        while (my $line = <$file>) {
            # Use regex to find note names in the INSERT INTO statements
            if ($line =~ /INSERT INTO notes \(name, address, phone, email, note\) VALUES \('([^']+)'/) {
                $notes{$1} = 1;  # Store the note name in the hash
            }
        }
        close $file;
    }
    return %notes;  # Return the hash of note names
}

sub write_sql_header {
    # Write the SQL table header to the file if it does not already exist
    if (!-e $SQL_FILENAME) {
        open my $file, '>', $SQL_FILENAME or die "Could not open file '$SQL_FILENAME': $!";
        print $file "CREATE TABLE IF NOT EXISTS notes (\n";
        print $file "    id INTEGER PRIMARY KEY AUTOINCREMENT,\n";
        print $file "    name TEXT UNIQUE,\n";
        print $file "    address TEXT,\n";
        print $file "    phone TEXT,\n";
        print $file "    email TEXT,\n";
        print $file "    note TEXT\n";
        print $file ");\n\n";
        close $file;
    }
}

sub add_note {
    # Add a new note to the SQL file
    my %existing_notes = load_existing_notes();

    print "Name: ";
    chomp(my $name = <STDIN>);
    if (exists $existing_notes{$name}) {
        print "A note with the name '$name' already exists.\n";
        return;
    }

    print "Address: ";
    chomp(my $address = <STDIN>);

    my $phone;
    while (1) {
        print "Phone number: ";
        chomp($phone = <STDIN>);
        if ($phone =~ /^[0-9\s\-]+$/) {
            last;
        } else {
            print "Invalid phone number. Please enter a valid phone number (digits, spaces, and hyphens allowed).\n";
        }
    }

    my $email;
    while (1) {
        print "Email address: ";
        chomp($email = <STDIN>);
        if ($email =~ /@/) {
            last;
        } else {
            print "Missing @. Please enter a valid email address.\n";
        }
    }

    print "Note: ";
    chomp(my $note = <STDIN>);

    # Append the new note to the SQL file
    open my $file, '>>', $SQL_FILENAME or die "Could not open file '$SQL_FILENAME': $!";
    print $file "INSERT INTO notes (name, address, phone, email, note) VALUES ('$name', '$address', '$phone', '$email', '$note');\n";
    close $file;

    print "Note added successfully.\n";
}

sub delete_note {
    # Delete a note from the SQL file based on the note name provided by the user
    print "Enter the name of the note to delete: ";
    chomp(my $search_name = <STDIN>);

    my $tempfile = 'temp.sql';
    my $deleted = 0;

    open my $infile, '<', $SQL_FILENAME or die "Could not open file '$SQL_FILENAME': $!";
    open my $outfile, '>', $tempfile or die "Could not open file '$tempfile': $!";
    
    while (my $line = <$infile>) {
        if ($line =~ /INSERT INTO notes \(name, address, phone, email, note\) VALUES \('$search_name',/) {
            $deleted = 1;  # Mark the note as deleted
            next;
        }
        print $outfile $line;  # Copy all other lines to the temp file
    }

    close $infile;
    close $outfile;

    # Replace the original file with the updated file
    move($tempfile, $SQL_FILENAME) or die "Could not move file '$tempfile' to '$SQL_FILENAME': $!";

    if ($deleted) {
        print "Note deleted successfully.\n";
    } else {
        print "No note with the name '$search_name' found.\n";
    }
}

sub search_note {
    # Search for a note in the SQL file by the note name provided by the user
    print "Enter the name of the note to search: ";
    chomp(my $search_name = <STDIN>);

    my $found = 0;

    open my $file, '<', $SQL_FILENAME or die "Could not open file '$SQL_FILENAME': $!";
    while (my $line = <$file>) {
        if ($line =~ /INSERT INTO notes \(name, address, phone, email, note\) VALUES \('$search_name', '([^']*)', '([^']*)', '([^']*)', '([^']*)'\);/) {
            my ($address, $phone, $email, $note) = ($1, $2, $3, $4);
            print "Name: $search_name\n";
            print "Address: $address\n";
            print "Phone: $phone\n";
            print "Email: $email\n";
            print "Note: $note\n";
            print "---------------\n";
            $found = 1;
            last;
        }
    }
    close $file;

    if (!$found) {
        print "No note with the name '$search_name' found.\n";
    }
}

sub edit_note {
    # Edit an existing note by first deleting the old note and then adding a new note with the same name
    print "Enter the name of the note to edit: ";
    chomp(my $search_name = <STDIN>);

    my %existing_notes = load_existing_notes();
    if (!exists $existing_notes{$search_name}) {
        print "No note with the name '$search_name' found.\n";
        return;
    }

    delete_note_by_name($search_name);  # Delete the old note
    add_note();  # Add a new note with the same name
    print "Note edited successfully.\n";
}

sub delete_note_by_name {
    # Helper function to delete a note by name without user interaction
    my ($search_name) = @_;

    my $tempfile = 'temp.sql';

    open my $infile, '<', $SQL_FILENAME or die "Could not open file '$SQL_FILENAME': $!";
    open my $outfile, '>', $tempfile or die "Could not open file '$tempfile': $!";
    
    while (my $line = <$infile>) {
        if ($line =~ /INSERT INTO notes \(name, address, phone, email, note\) VALUES \('$search_name',/) {
            next;  # Skip the line that matches the note to delete
        }
        print $outfile $line;  # Copy all other lines to the temp file
    }

    close $infile;
    close $outfile;

    # Replace the original file with the updated file
    move($tempfile, $SQL_FILENAME) or die "Could not move file '$tempfile' to '$SQL_FILENAME': $!";
}

sub main {
    # Main function to run the note-taking application
    write_sql_header();  # Ensure the SQL file has the table schema
    while (1) {
        print "1. Add Note\n";
        print "2. Delete Note\n";
        print "3. Search Note\n";
        print "4. Edit Note\n";
        print "5. Exit\n";
        print "Enter your choice: ";
        chomp(my $choice = <STDIN>);

        if ($choice == 1) {
            add_note();
        } elsif ($choice == 2) {
            delete_note();
        } elsif ($choice == 3) {
            search_note();
        } elsif ($choice == 4) {
            edit_note();
        } elsif ($choice == 5) {
            last;
        } else {
            print "Invalid choice\n";
        }
    }
}

main();  # Run the main function to start the application
