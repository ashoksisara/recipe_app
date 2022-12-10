class AppValidation {
  static String? fieldEmptyValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter value';
    } else {
      return null;
    }
  }

  static String? emailValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidation(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

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
