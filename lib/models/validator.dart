class Validator {
  static bool isValidAge(int? age) {
    return age != null && age > 0 && age < 100;
  }

  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
