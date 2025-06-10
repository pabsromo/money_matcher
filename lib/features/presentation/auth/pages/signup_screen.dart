import 'package:flutter/material.dart';
import '../../../../db/users_dao.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  // final AuthDatabase db;
  final UsersDao usersDao;
  const SignupScreen({super.key, required this.usersDao});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _passwordConfirmCtrl = TextEditingController();

  String? _errorText;

  Future<void> _signup() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameCtrl.text.trim();
      final email = _emailCtrl.text.trim();
      final password = _passwordCtrl.text;

      final existingUser = await widget.usersDao.getUserByUsername(username);
      if (existingUser != null) {
        setState(() {
          _errorText = 'Username already taken';
        });
        return;
      }

      await widget.usersDao.createUser(username, email, password);

      if (!mounted) return;

      // Navigate to home after successful signup
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) =>
              HomeScreen(usersDao: widget.usersDao, username: username),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    super.dispose();
  }

  String? _validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) return 'Enter username';
    if (username.length > 32) {
      return 'Username must be equal to or less than 32 characters';
    }
    return null;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Enter email';
    bool isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!isValidEmail) {
      return 'Email must be valid';
    }
    return null;
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Enter password';
    if (password.length < 8) return 'Password must be at least 8 characters';
    bool isValidPassword = RegExp(
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
        .hasMatch(password);
    if (!isValidPassword) {
      return 'Password must be at least 8 chars, at least have one letter, at least one number, and at least one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("signupScreen"),
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_errorText != null) ...[
                Text(_errorText!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextFormField(
                key: const Key("usernameTextForm"),
                controller: _usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: _validateUsername,
              ),
              TextFormField(
                key: const Key("emailTextForm"),
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              TextFormField(
                key: const Key("initialPasswordTextForm"),
                controller: _passwordCtrl,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  errorMaxLines: 3,
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              TextFormField(
                key: const Key("confirmPasswordTextForm"),
                controller: _passwordConfirmCtrl,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (val != _passwordCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: _signup,
                  key: const Key("signupBtn"),
                  child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
