#!/usr/bin/perl
use strict;
use warnings;

sub add_record {
    print "Patient's Name: ";
    chomp(my $name = <STDIN>);
    print "Patient's Address: ";
    chomp(my $address = <STDIN>);
    print "Patient's Phone: ";
    chomp(my $phone = <STDIN>);
    print "Patient's Email: ";
    chomp(my $email = <STDIN>);
    print "Patient's Condition: ";
    chomp(my $note = <STDIN>);

    open(my $fh, '>>', 'MedicalDatabase.txt') or die "Could not open file 'MedicalDatabase.txt' $!";
    print $fh "$name\n$address\n$phone\n$email\n$note\n--------------\n";
    close($fh);
    print "Patient information added successfully to medical database.\n";
}

sub delete_record {
    print "Enter Patient's name to delete record: ";
    chomp(my $search_name = <STDIN>);

    # Read the entire file into an array
    open(my $fh, '<', 'MedicalDatabase.txt') or die "Could not open file 'MedicalDatabase.txt' $!";
    my @lines = <$fh>;
    close($fh);

    # Write back only the records that do not match the search name
    open($fh, '>', 'MedicalDatabase.txt') or die "Could not open file 'MedicalDatabase.txt' $!";
    my $skip = 0;
    foreach my $line (@lines) {
        if ($line =~ /^$search_name$/) {
            $skip = 1; # Start skipping the lines for the current record
        } elsif ($line =~ /^--------------$/) {
            $skip = 0; # Stop skipping at the end of the record
        } elsif (!$skip) {
            print $fh $line; # Write lines that are not part of the record to be deleted
        }
    }
    close($fh);

    print "Record deleted successfully.\n";
}

sub search_record {
    print "Enter Patient's name to search record: ";
    chomp(my $search_name = <STDIN>);

    open(my $fh, '<', 'MedicalDatabase.txt') or die "Could not open file 'MedicalDatabase.txt' $!";
    my $record_found = 0;
    while (my $line = <$fh>) {
        if ($line =~ /^$search_name$/i) {
            $record_found = 1;
        }
        if ($record_found) {
            print $line;
            if ($line =~ /^--------------$/) {
                $record_found = 0;
            }
        }
    }
    close($fh);

    print "Search completed.\n";
}

sub edit_record {
    print "Enter Patient's name to edit record: ";
    chomp(my $search_name = <STDIN>);
    system("perl -ni -e 'print unless /^$search_name/' MedicalDatabase.txt");
    add_record();
    print "Record edited successfully.\n";
}

while (1) {
    print "1. Add Patient Record\n";
    print "2. Delete Patient Record\n";
    print "3. Search Patient Record\n";
    print "4. Edit Patient Record\n";
    print "5. Exit Medlink\n";
    print "Enter your choice: ";
    chomp(my $choice = <STDIN>);

    if ($choice == 1) {
        add_record();
    } elsif ($choice == 2) {
        delete_record();
    } elsif ($choice == 3) {
        search_record();
    } elsif ($choice == 4) {
        edit_record();
    } elsif ($choice == 5) {
        exit;
    } else {
        print "Invalid choice\n";
    }
}
