import 'package:flutter/material.dart';
import 'package:login/register.dart';
import 'dashboard.dart';
import 'user.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, title});

  final String title = 'Halaman Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (users.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Belum ada user yang terdaftar'))
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    var bytes = utf8.encode(_passwordController.text);
    var hashedInputPassword = sha256.convert(bytes).toString();
    
    try {
      User user = users.firstWhere(
        (u) => u.username == _usernameController.text && u.password == hashedInputPassword,
        orElse: () => throw Exception('Username atau password salah'),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(username: user.username)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Masukan username' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Masukan Password' : null,
              ),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}