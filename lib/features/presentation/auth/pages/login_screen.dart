import 'package:flutter/material.dart';
import '../../../../db/auth_database.dart';
import '../../../../db/users_dao.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthDatabase db;
  // final UsersDao usersDao;
  const LoginScreen({super.key, required this.db});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  late UsersDao _usersDao;

  @override
  void initState() {
    super.initState();
    _usersDao = UsersDao(widget.db);
  }

  String? _errorText;

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameCtrl.text.trim();
      final password = _passwordCtrl.text;
      final success = await _usersDao.checkUserCredentials(username, password);

      final user = await _usersDao.getUserByUsername(username);

      if (!mounted) return;

      if (success && user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(db: widget.db, userId: user.id),
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
      key: const Key("loginScreen"),
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
                key: const Key("usernameInput"),
                controller: _usernameCtrl,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (val) => (val == null || val.trim().isEmpty)
                    ? 'Enter username'
                    : null,
              ),
              TextFormField(
                key: const Key("passwordInput"),
                controller: _passwordCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Enter password' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                key: const Key("loginBtn"),
                child: const Text('Login'),
              ),
              TextButton(
                key: const Key("createAccntBtn"),
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
