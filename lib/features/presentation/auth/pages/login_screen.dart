import 'package:flutter/material.dart';
import '../../../../db/auth_database.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthDatabase db;
  const LoginScreen({super.key, required this.db});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  String? _errorText;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameCtrl.text.trim();
      final password = _passwordCtrl.text;
      final success = await widget.db.checkUserCredentials(username, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(db: widget.db, username: username),
          ),
        );
      } else {
        setState(() {
          _errorText = 'Invalid username or password';
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorText != null) ...[
                Text(_errorText!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Enter username'
                    : null,
              ),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter password' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _login, child: const Text('Login')),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignupScreen(db: widget.db),
                    ),
                  );
                },
                child: const Text('Create an account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
