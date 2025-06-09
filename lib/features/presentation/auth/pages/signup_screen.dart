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

  String? _validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Enter password';
    if (val.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: _usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Enter username'
                    : null,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Enter email' : null,
              ),
              TextFormField(
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              TextFormField(
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
              ElevatedButton(onPressed: _signup, child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
