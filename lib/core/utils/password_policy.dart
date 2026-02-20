class PasswordPolicy {
  static const bool requireUppercase = true;
  static const bool requireLowercase = true;
  static const bool requireNumber = true;
  static const bool requireSpecialChar = true;
  static const int minLength = 8;

  static bool hasUppercase(String value) => RegExp(r'[A-Z]').hasMatch(value);

  static bool hasLowercase(String value) => RegExp(r'[a-z]').hasMatch(value);

  static bool hasNumber(String value) => RegExp(r'[0-9]').hasMatch(value);

  static bool hasSpecialChar(String value) =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

  static bool hasMinLength(String value) => value.length >= minLength;

  static bool validate(String value) {
    return hasMinLength(value) &&
        (!requireUppercase || hasUppercase(value)) &&
        (!requireLowercase || hasLowercase(value)) &&
        (!requireNumber || hasNumber(value)) &&
        (!requireSpecialChar || hasSpecialChar(value));
  }
}
