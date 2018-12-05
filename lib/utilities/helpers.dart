import 'package:validate/validate.dart';

class Helpers{
String _validatePassword(String value) {
  if (value.length < 5) {
    return 'The Password must be atleast 5 characters.';
  }

  return null;
}
String _validateEmail(String value) {
  try {
    Validate.isEmail(value);
  } catch (e) {
    return 'The E-mail address must be valid';
  }

  return null;
}

}

