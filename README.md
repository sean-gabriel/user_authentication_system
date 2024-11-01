# user_authentication_system

 Practicing the Dart programming language with standard input and CRUD operations using maps, recursion, and conditional statements (if-else and switch).

 In this program, users can sign in and sign up for an account with their username and password.

 Once users have created an account, they can:
 -change their username
 -change their password
 -delete their account
 -view the contents of the map (a database of usernames and passwords)
 
 This program only allows unique usernames. 
 
 It checks the map, where usernames and passwords are stored, to see if the user's preferred username already exists. If the username is already in use, the program will not allow the user to create an account with it.

 When creating an account, users are required to confirm their password.

 If a user wishes to delete their account, they will need to enter their password to proceed.

The function to check the database allows users to verify whether the changes (such as updating their username, changing their password, or deleting their account) were successfully applied. It can only be accessed once a user is signed in, so the user must have an account first.


