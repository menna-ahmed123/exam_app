class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /*static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*\d).{6,}$',
  );
  */

 static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _numberRegex = RegExp(r'\d');
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'This Email is not valid';
    }
    return null;
  }

  static String? resetCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Code is required';
    }
    if (value.trim().length != 4) {
      return 'Invalid code';
    }
    return null;
  }

static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (!_upperCaseRegex.hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }

    if (!_numberRegex.hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Password not matched';
    }
    return null;
  }
}
