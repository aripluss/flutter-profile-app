import 'package:flutter/material.dart';

void main() {
  User thisUser = new User(
    name: 'Iryna',
    surname: 'Klosheva',
    age: 26,
    email: 'irynaklosheva@gmail.com',
    doNotDisturb: false,
  );

  runApp(MyApp(user: thisUser));
}

class MyApp extends StatelessWidget {
  final User user;

  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 83, 97, 50),
        ),
      ),
      home: MyHomePage(title: 'Iryna Klosheva`s profile', user: user),
    );
  }
}

class User {
  String? _name;
  String? _surname;
  int? _age;
  String? _email;
  bool _doNotDisturb = false;

  User({
    required String name,
    String? surname,
    int? age,
    String? email,
    bool doNotDisturb = false,
  }) {
    _name = name;
    _surname = surname;
    _age = age;
    _email = email;
    _doNotDisturb = doNotDisturb;
  }

  String? get name => _name;
  String? get surname => _surname;
  int? get age => _age;
  String? get email => _email;
  bool get doNotDisturb => _doNotDisturb;

  void set setAge(int? value) {
    if (value != null && value > 0 && value < 100) _age = value;
  }

  void set setEmail(String? value) {
    if (value != null && value.isNotEmpty) _email = value;
  }

  void toggleStatus() => _doNotDisturb = !_doNotDisturb;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.user});

  final String title;
  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _ageEntered = TextEditingController();
  final TextEditingController _emailEntered = TextEditingController();

  void _updateAge() {
    setState(() {
      int? newAge = int.tryParse(_ageEntered.text);
      if (newAge != null) widget.user.setAge = newAge;
    });
  }

  void _updateEmail() {
    String newEmail = _emailEntered.text;
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(newEmail)) return;

    setState(() {
      widget.user.setEmail = newEmail;
    });
  }

  void _changeDoNotDisturb() {
    setState(() {
      widget.user.toggleStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _changeDoNotDisturb,
            icon: Icon(
              widget.user.doNotDisturb
                  ? Icons.do_not_disturb_on_outlined
                  : Icons.do_not_disturb_off_outlined,
              color: widget.user.doNotDisturb ? Colors.red : Colors.green,
            ),
            tooltip: widget.user.doNotDisturb ? 'Do Not Disturb' : 'Available',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 83, 97, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Hello, ${widget.user.name} ${widget.user.surname}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Age: ${widget.user.age != null ? '${widget.user.age} years old' : '-'}',
            ),
            Text('Email: ${widget.user.email ?? '-'}'),

            SizedBox(height: 100),

            //change info
            TextField(
              controller: _ageEntered,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your current age'),
            ),
            ElevatedButton(onPressed: _updateAge, child: Text('Update age')),

            TextField(
              controller: _emailEntered,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Enter your new email'),
            ),
            ElevatedButton(
              onPressed: _updateEmail,
              child: Text('Update email'),
            ),
          ],
        ),
      ),
    );
  }
}
