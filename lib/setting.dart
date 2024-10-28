import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; 
import 'user.dart';
import 'login.dart';

class SettingPage extends StatefulWidget {
  final String username;

  const SettingPage({super.key, required this.username});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _changePassword() {
    if (!_formKey.currentState!.validate()) return;
    
    var bytes = utf8.encode(_oldPasswordController.text);
    var hashedOldPassword = sha256.convert(bytes).toString();

    User user = users.firstWhere((u) => u.username == widget.username);

    if (user.password != hashedOldPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password lama tidak sesuai')),
      );
      return;
    }

    var bytesNew = utf8.encode(_newPasswordController.text);
    var hashedNewPassword = sha256.convert(bytesNew).toString();

    user.password = hashedNewPassword;
    users.removeWhere((u) => u.username == widget.username);
    users.add(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diubah')),
    );
    
    Navigator.pop(context);
  }

  void _deleteUser() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus akun?'),
          content: const Text('Apakah anda yakin ingin menghapus akun?'),
          actions: [
            TextButton(
              onPressed: () {
                users.removeWhere((u) => u.username == widget.username);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Akun berhasil dihapus')),
                );
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                decoration: const InputDecoration(labelText: 'Password lama'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Msukan password lama' : null,
              ),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Password baru'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Masukan password baru' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Ganti Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
              onPressed: _deleteUser,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red,foregroundColor: Colors.white ),
              child: const Text('Delete User'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}