import 'validator.dart';

class User {
  final String _name;
  final String _surname;
  int? _age;
  String? _email;
  bool _doNotDisturb;

  User({
    required String name,
    required String surname,
    int? age,
    String? email,
    bool doNotDisturb = false,
  }) : _name = name,
       _surname = surname,
       _age = age,
       _email = email,
       _doNotDisturb = doNotDisturb;

  String? get name => _name;
  String? get surname => _surname;
  int? get age => _age;
  String? get email => _email;
  bool get doNotDisturb => _doNotDisturb;

  void set age(int? value) {
    if (Validator.isValidAge(value)) {
      _age = value;
    }
  }

  set email(String? value) {
    if (Validator.isValidEmail(value)) {
      _email = value;
    }
  }

  void toggleStatus() => _doNotDisturb = !_doNotDisturb;
}
