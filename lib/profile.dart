import 'package:flutter/material.dart';
import 'package:login/dashboard.dart';
import 'user.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _name;
  late String _address;

  @override
  void initState() {
    super.initState();
    User user = users.firstWhere((u) => u.username == widget.username);
    _name = user.nama;
    _address = user.alamat;
  }

  void _updateProfile() {
    User user = users.firstWhere((u) => u.username == widget.username);
    user.nama = _name;
    user.alamat = _address;
    users.removeWhere((u) => u.username == widget.username);
    users.add(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard(username: user.username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              readOnly: true,
              controller: TextEditingController(text: widget.username),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                _name = value;
              },
              controller: TextEditingController(text: _name),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                _address = value;
              },
              controller: TextEditingController(text: _address),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}