import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 83, 97, 50),
        ),
      ),
      home: MyHomePage(title: 'Iryna Klosheva`s profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _ageEntered = TextEditingController();
  final TextEditingController _emailEntered = TextEditingController();

  final User _user = User(
    name: 'Iryna',
    surname: 'Klosheva',
    age: 26,
    email: 'irynaklosheva@gmail.com',
    doNotDisturb: false,
  );

  void _updateAge() {
    int? newAge = int.tryParse(_ageEntered.text);
    if (newAge != null && Validator.isValidAge(newAge)) {
      _user.age = newAge;
      setState(() {});
    } else {
      _showError('Age should be between 1 and 99');
    }
  }

  void _updateEmail() {
    final String newEmail = _emailEntered.text;
    if (Validator.isValidEmail(newEmail)) {
      _user.email = newEmail;
      setState(() {});
    } else {
      _showError('Invalid email format');
    }
  }

  void _changeDoNotDisturb() {
    setState(() {
      _user.toggleStatus();
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Color _iconColor() {
    return _user.doNotDisturb ? Colors.red : Colors.green;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ageEntered.dispose();
    _emailEntered.dispose();
    super.dispose();
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
              _user.doNotDisturb
                  ? Icons.do_not_disturb_on_outlined
                  : Icons.do_not_disturb_off_outlined,
              color: _iconColor(),
            ),
            tooltip: _user.doNotDisturb ? 'Do Not Disturb' : 'Available',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 83, 97, 50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Hello, ${_user.name} ${_user.surname}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Age: ${_user.age != null ? '${_user.age} years old' : '-'}'),
            Text('Email: ${_user.email ?? '-'}'),

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
