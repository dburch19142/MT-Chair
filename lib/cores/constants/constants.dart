import 'package:flutter/material.dart';

const bool devMode = false;
const String username = 'username';
const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Email provided isn't valid.Try another email address";
const String passwordLengthError = 'At least 8 character';
const String passwordMatchError = 'Password mismatch';
const String passwordRegex =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
const String passwordStrengthError =
    'It must have at least one uppercase, lowercase, number, symbol ';
const String emptyUsernameField = 'Username cannot be empty';
const String usernameLengthError = 'Username length must be greater than 6';
const String emailRegex =
    '[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+';

const String phoneNumberRegex = r'0[789][01]\d{8}';

const String phoneNumberLengthError = 'Phone number must be more than 8 digits';

const String invalidPhoneNumberField =
    "Number provided isn't valid.Try another phone number";

//MediaQuery Width
double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//MediaQuery Height
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//get the shortest Side of the target device
double shortestSide(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide;
}

//check the type of target device
bool isMobileLayout(BuildContext context) {
  return shortestSide(context) < 600;
}

//aspect ratio
double aspectRatio(BuildContext context) {
  final double itemHeight = (height(context) - kToolbarHeight - 24) / 2;
  final double itemWidth = width(context) / 2;

  double aspectRatio = (itemWidth / itemHeight);

  return aspectRatio;
}
