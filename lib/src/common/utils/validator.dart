class Validator {
  Validator._();

  static const _emailRegExpString =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
      r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';

  static const _numberRegExpString = r'^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$';

  static final _emailRegex = RegExp(_emailRegExpString, caseSensitive: false);

  static final _numberRegex = RegExp(_numberRegExpString, caseSensitive: false);

  static bool isValidPassword(String password) => password.length >= 6;

  static bool isValidNumber(String number) => _numberRegex.hasMatch(number);

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidUserName(String userName) => userName.length >= 3;
}
