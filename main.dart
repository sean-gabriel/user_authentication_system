import 'dart:io';

Map<String, String> users = {};

void main() {
  print("\n--- Welcome to User Authentication System ---\n");
  print("[1] Login");
  print("[2] Sign Up");
  print("[3] Exit");
  print('\nEnter a number: ');

  String? choice = stdin.readLineSync()!;

  switch (choice) {
    case '1':
    loginUser();
    break;
    case '2':
    signUp();
    break;
    case '3':
    print('\nExiting the system, bye for now!');
    sleep(Duration(seconds: 2));
    exit(0);
    default:
    print('Invalid choice. Please try again.');
    main();
  }

}

void loginUser() {
  print('\nEnter your username: ');
  String username = stdin.readLineSync()!;

  if (users.containsKey(username)) {
    print('\nEnter your password: ');
    String password = stdin.readLineSync()!;

    if (users[username] == password) {
      print('\nLogin successful! Welcome, $username');
      home(username);
    } else {
      print('\nIncorrect password! Please try again.');
      loginUser();
    }
  } else {
    print('\nOops. User not found! Please check your username or register first if you don\'t have an account\n');
    print('Enter any key to try again or enter \'x\' to return to home page');
    String choice = stdin.readLineSync()!;
    if (choice.toLowerCase() == 'x') {
      main();
    } else {
      loginUser();
    }
  }
}

void signUp() {
  print('\nRegister an account');
  print('\nEnter a username: ');
  String username = stdin.readLineSync()!;

  void createPassword() {
    print('\nCreate a password: ');
    String password = stdin.readLineSync()!;
    print('\nConfirm your password: ');
    String confirmPassword = stdin.readLineSync()!;
    if (password == confirmPassword) {
      users[username] = password;
      print('\nAccount created successfully!');
      sleep(Duration(seconds: 2));
      home(username);
    } else {
      print('\nOops. Your password doesn\'t match.');
      print('Enter any key to try again or enter \'x\' to return to home page');
    String choice = stdin.readLineSync()!;
    if (choice.toLowerCase() == 'x') {
      main();
    } else {
      createPassword();
    }
    }
  }


  // if username is already taken
  if (users.containsKey(username)) {
    print('\nUsername is already taken, please try another one');
    print('Enter any key to try again or enter \'x\' to return to home page');
    String choice = stdin.readLineSync()!;
    if (choice.toLowerCase() == 'x') {
      main();
    } else {
      signUp();
    }
  } else {
    createPassword();
  }

}

void home(String username) {
  print("\nWelcome, $username!\n");
  print("[1] - Account Settings");
  print("[2] - Log-out");
  print("[3] - Exit");
  print('[4] - View all username and password in our database\n');
  print('Enter a number: ');
  String choice = stdin.readLineSync()!;

  switch (choice) {
    case '1': // account settings
      accountSettings(username);
      break;
    case '2': // logout
      main();
      break;
    case '3': // exit console
      print('\nExiting the system, bye for now!');
      sleep(Duration(seconds: 2));
      exit(0);
    case '4': // show database data
      for (var user in users.keys) {
        print('\nUser: $user\nPassword: ${users[user]}');
      }
      sleep(Duration(seconds: 3));
      home(username);
    default: // answer not in the choices
      print('\nOops, please try again.');
      home(username);
  }
}

void accountSettings(username) {
  print("\nAccount Settings\n");
  print("Username: $username");
  print("Password: ${users[username]}");
  print('\n[1] Change Account username or password');
  print('[2] Delete Account');
  print('[3] Return\n');
  print('Enter a number: ');
  String choice = stdin.readLineSync()!;

  switch (choice) {
    case '1': // goto change account info function 
      changeAcc(username);
      break;
    case '2': // goto delete account function
      deleteAcc(username);
      break;
    case '3': // back to menu
      home(username);
      break;
    default: // answer not in the choices
      print('\nOops, please try again.');
      accountSettings(username);
  }
}

// To do: October 27, 2024
// -Change username or password function
// -Delete account function

void changeAcc(username) {
  print("\nWhich do you want to change?\n");
  print('[1] Username');
  print('[2] Password');
  print('[3] Return\n');
  print('Enter a number: ');
  String choice = stdin.readLineSync()!;

  switch (choice) {
    case '1': // Change username
      changeUsername(username);
      break;
    case '2': // Change password
      changePassword(username);
      break;
    case '3': // back to menu
      home(username);
      break;
    default: // answer not in the choices
      print('\nOops, please try again.');
      changeAcc(username);
  }
}

void changeUsername(username) {
  print('\nChanging username');
  print('\nEnter your new username: ');
  String newUsername = stdin.readLineSync()!;
  if (users.containsKey(newUsername)) {
    print('\nUsername is already taken, please try another one.');
    print('\nEnter any key to try again or enter \'x\' to return to home page\n');
    String choice = stdin.readLineSync()!;
    if (choice.toLowerCase() == 'x') {
      home(username);
    } else {
      changeUsername(username);
    }
  } else {

    // you can not change a key on a map in dart, so instead, we will add teh new key with the old value, then remove the old key.

    // Add new key-value (username-password) pair
    users[newUsername] = users[username]!;

    // Remove old key-value (username-password) pair
    users.remove(username);

    print('\nYou have successfully changed your username, $newUsername!');
    sleep(Duration(seconds: 3));
    home(newUsername);
  }
}

void changePassword(username) {
  print('\nChanging password');
  print('\nEnter your old password: ');
  String password = stdin.readLineSync()!;

  if (users[username] == password) {
    // If old password is correct, then proceed on changing old password
    print('\nPlease enter your new password: \n');
    String newPassword = stdin.readLineSync()!;

    print('\nPlease confirm your new password: \n');
    String confirmNewPassword = stdin.readLineSync()!;
    if (confirmNewPassword == newPassword) {
      // override the old password
      users[username] = newPassword;

      print('\nYou have successfully changed your password! You\'ll be redirected back to home page.');
      sleep(Duration(seconds: 3));
      home(username);
    } else {
      print('\nOops. Your password doesn\'t match.');
      print('\nEnter any key to try again or enter \'x\' to return to home page\n');
      String choice = stdin.readLineSync()!;
      if (choice.toLowerCase() == 'x') {
        home(username);
      } else {
        changePassword(username);
      }
    }
  } else {
    print('\nOops. Your password is incorrect.');
    print('\nEnter any key to try again or enter \'x\' to return to home page\n');
    String choice = stdin.readLineSync()!;
    if (choice.toLowerCase() == 'x') {
      home(username);
    } else {
      changePassword(username);
    }
  }

}

void deleteAcc(username) {
  print('\nAre you sure you want to delete your account, $username?\n');
  print('This action cannot be undone.');
  print('[1] Yes');
  print('[2] Cancel\n');
  String choice = stdin.readLineSync()!;

  switch (choice) {
    case '1':
    print('\nPlease enter your password to confirm: ');
    String password = stdin.readLineSync()!;

    // Check if the entered password matches the one in the users map
    if (users[username] == password) {
      // If password is correct, remove the user from the map
      users.remove(username);
      print('\nYour account has been successfully deleted.');
      sleep(Duration(seconds: 2));
      main(); // Redirect to the main menu
    } else {
      // Password is incorrect
      print('\nIncorrect password. Deletion canceled.');
      print('\nEnter any key to try again or enter \'x\' to return to the Account Settings.');
      String choice = stdin.readLineSync()!;
      if (choice.toLowerCase() == 'x') {
        accountSettings(username); // Return to account settings
      } else {
        deleteAcc(username); // Retry deletion
      }
    }
      break;
    case '2':
      home(username);
      break;
    default:
      print('\nOops, please try again.');
      deleteAcc(username);
  }  
}