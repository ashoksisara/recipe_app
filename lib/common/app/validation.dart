class AppValidation {

  //check whether field is empty or not
  static String? fieldEmptyValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter value';
    } else {
      return null;
    }
  }

  //check whether email field is empty and valid
  static String? emailValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  //check whether password field is empty or not
  static String? passwordValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  //check whether confirm password field is empty or not
  static String? confirmPasswordValidation(value, value2) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value != value2) {
      return 'Please make sure your password match';
    }
    return null;
  }

}
