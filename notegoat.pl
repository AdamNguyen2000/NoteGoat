#!/usr/bin/perl

sub add_note {
    print "Name: ";
    $name = <STDIN>;
    print "Address: ";
    $address = <STDIN>;
    print "Phone number: ";
    $phone = <STDIN>;
    print "Email address: ";
    $email = <STDIN>;
    print "Note: ";
    $note = <STDIN>;

    open(my $fh, '>>', 'notes.txt');
    print $fh "$name|$address|$phone|$email|$note";
    close($fh);
    print "Note added successfully.\n";
}

sub delete_note {
    print "Enter the name of the note to delete: ";
    $search_name = <STDIN>;
    system("perl -ni -e 'print unless /^$search_name/' notes.txt");
    print "Note deleted successfully.\n";
}

sub search_note {
    print "Enter the name of the note to search: ";
    $search_name = <STDIN>;
    system("grep -i \"^$search_name\" notes.txt");
}

sub edit_note {
    print "Enter the name of the note to edit: ";
    $search_name = <STDIN>;
    system("perl -ni -e 'print unless /^$search_name/' notes.txt");
    add_note();
    print "Note edited successfully.\n";
}

while (1) {
    print "1. Add Note\n";
    print "2. Delete Note\n";
    print "3. Search Note\n";
    print "4. Edit Note\n";
    print "5. Exit\n";
    print "Enter your choice: ";
    $choice = <STDIN>;

    if ($choice == 1) {
        add_note();
    } elsif ($choice == 2) {
        delete_note();
    } elsif ($choice == 3) {
        search_note();
    } elsif ($choice == 4) {
        edit_note();
    } elsif ($choice == 5) {
        exit;
    } else {
        print "Invalid choice\n";
    }
}