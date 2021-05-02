class FieldValidators {
  static validateEmail(String value) {
    FieldValidators fv = new FieldValidators();
    if (fv._fieldNullCheck(value)) return 'Please enter an email id.';
    if (!fv._isEmail(value)) return 'Please enter a valid email id.';
    return null;
  }

  static validatePassword(String value) {
    FieldValidators fv = new FieldValidators();
    if (fv._fieldNullCheck(value)) return 'Please enter a Password.';
    if (value.length < 4) return 'Enter a valid Password';
  }

  bool _fieldNullCheck(String value) {
    if (value == null) return true;
    if (value == "") return true;
    return false;
  }

  bool _isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

// r'^
//   (?=.*[A-Z])       // should contain at least one upper case
//   (?=.*[a-z])       // should contain at least one lower case
//   (?=.*?[0-9])      // should contain at least one digit
//   (?=.*?[!@#\$&*~]) // should contain at least one Special character
//   .{8,}             // Must be at least 8 characters in length
// $
  bool _isValidPassword(String em) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
