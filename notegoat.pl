#!/usr/bin/perl

use strict;
use warnings;

sub add_note {
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
        if ($phone =~ /^\d+$/) {
            last;
        } else {
            print "Invalid phone number. Please enter numbers only.\n";
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

    open(my $fh, '>>', 'notes.txt') or die "Could not open file 'notes.txt' $!";
    print $fh "$name\n$address\n$phone\n$email\n$note\n---------------\n";
    close($fh);
    print "Note added successfully.\n";
}

sub delete_note {
    print "Enter the name of the note to delete: ";
    chomp(my $search_name = <STDIN>);

    my $tempfile = 'temp.txt';
    open(my $in, '<', 'notes.txt') or die "Could not open file 'notes.txt' $!";
    open(my $out, '>', $tempfile) or die "Could not open file '$tempfile' $!";

    my $delete = 0;
    my $deleted = 0;
    while (my $line = <$in>) {
        if ($line =~ /^$search_name$/i && !$delete) {
            $delete = 1;
            $deleted = 1;
        } elsif ($delete && $line =~ /^---------------$/) {
            $delete = 0;
            next;
        }
        print $out $line unless $delete;
    }

    close($in);
    close($out);
    rename $tempfile, 'notes.txt' or die "Could not rename file: $!";
    
    if ($deleted) {
        print "Note deleted successfully.\n";
    } else {
        print "No note with the name '$search_name' found.\n";
    }
}

sub search_note {
    print "Enter the name of the note to search: ";
    chomp(my $search_name = <STDIN>);

    open(my $fh, '<', 'notes.txt') or die "Could not open file 'notes.txt' $!";
    my $found = 0;
    while (my $line = <$fh>) {
        if ($line =~ /^$search_name$/i) {
            $found = 1;
            print $line;
        } elsif ($found) {
            last if $line =~ /^---------------$/;
            print $line;
        }
    }
    close($fh);
}

sub edit_note {
    print "Enter the name of the note to edit: ";
    chomp(my $search_name = <STDIN>);

    my %existing_notes = load_existing_notes();
    if (!exists $existing_notes{$search_name}) {
        print "No note with the name '$search_name' found.\n";
        return;
    }

    delete_note_by_name($search_name);
    add_note();
    print "Note edited successfully.\n";
}

sub delete_note_by_name {
    my ($search_name) = @_;

    my $tempfile = 'temp.txt';
    open(my $in, '<', 'notes.txt') or die "Could not open file 'notes.txt' $!";
    open(my $out, '>', $tempfile) or die "Could not open file '$tempfile' $!";

    my $delete = 0;
    while (my $line = <$in>) {
        if ($line =~ /^$search_name$/i && !$delete) {
            $delete = 1;
        } elsif ($delete && $line =~ /^---------------$/) {
            $delete = 0;
            next;
        }
        print $out $line unless $delete;
    }

    close($in);
    close($out);
    rename $tempfile, 'notes.txt' or die "Could not rename file: $!";
}

sub load_existing_notes {
    my %notes;
    open(my $fh, '<', 'notes.txt') or return %notes;
    while (my $line = <$fh>) {
        chomp $line;
        if ($line ne '' && $line !~ /^---------------$/) {
            $notes{$line} = 1;
        }
    }
    close($fh);
    return %notes;
}

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
        exit;
    } else {
        print "Invalid choice\n";
    }
}
