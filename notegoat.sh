#!/bin/bash

echo "



  ####  ###  #######  ####### ######     #######   #######    ###  ######## 
  ##### ### ###   ###   ###   ###       ####      ###   ###  #####   ###    
  ## ###### ###    ##   ###   ######    ### #### ###    ### ### ###  ###    
  ##  ##### ###   ###   ###   ###       ###   ##  ###   ### #######  ###    
  ##   ####  #######    ###   ######     #######   ####### ###   ### ###    
                                                                            
                                                                            
                                                                            
                          +++++++++    +++++++++                               
                        ++++++++   +++++++++++                            
                      ++++++++  ++++++++++                                  
                    #++++++++++++++++++                                     
           ############+#################        ###    ++++++++            
               #####################################    +++++++++           
             +------+#####+-.-###-.-###+#########+++++++++++++++            
          .#+..-+#............##+..+###+++++++++++++++++++++++              
          -.-#-..........+#############++++++++++++++++++++++++++           
           .....--......+############++++++++++++++++++++++++++++++         
               ###################+++++++++++++++++++++++++++++++++         
               #########  ++++++++++++++++++++++++++++++++++++++++++        
                 ######## ++++++++++++++++++++++++++++++++++++++++++        
                           ++++++++++++++++++++++++++    ##########         
                             +++++++++++++++++++++++     ##########         
                              ########## ##++++++###     ##########         
                              ########## ##########      #########          
                              #####################                         
                                #####   ###########                         
                                           ######
"


add_note() {
    read -p "Name: " name
    read -p "Address: " address
    read -p "Phone number: " phone
    read -p "Email address: " email
    read -p "Note: " note

    echo "$name|$address|$phone|$email|$note" >> notes.txt
    echo "Note added successfully."
}

delete_note() {
    read -p "Enter the name of the note to delete: " search_name
    sed -i "/^$search_name/d" notes.txt
    echo "Note deleted successfully."
}

search_note() {
    read -p "Enter the name of the note to search: " search_name
    grep -i "^$search_name" notes.txt
}

edit_note() {
    read -p "Enter the name of the note to edit: " search_name
    sed -i "/^$search_name/d" notes.txt
    add_note
    echo "Note edited successfully."
}

while true; do
    echo "1. Add Note"
    echo "2. Delete Note"
    echo "3. Search Note"
    echo "4. Edit Note"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) add_note ;;
        2) delete_note ;;
        3) search_note ;;
        4) edit_note ;;
        5) exit ;;
        *) echo "Invalid choice" ;;
    esac
done