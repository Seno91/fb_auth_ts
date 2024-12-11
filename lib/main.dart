import 'package:fb_auth_ts/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = "";

  final String userEmail = "dude@dude.com";
  final String userPw = "dudedudedude";

  //final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _pwController = TextEditingController();

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPw);

      setState(() {
        _message = "User '${userCredential.user?.email}' is Loged in";
      });
    } catch (e) {
      print(e);
      setState(
        () {
          _message = "Nice try moron: ${e.toString()}}";
        },
      );
    }
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut();

      setState(() {
        _message = "User not found brahh";
      });
    } catch (e) {
      setState(
        () {
          _message = "Nice try moron: ${e.toString()}}";
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Dude..",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("MailDUDE: $userEmail"),
            //Text("PasswordDUDE: $userPw"),
            TextField(
              controller: TextEditingController(text: _message),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "MailDUDE"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _message),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "PasswordDUDE"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: _message),
            ),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text("Log TF in"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              child: const Text("Get TF out here"),
            ),
          ],
        ),
      ),
    );
  }
}
