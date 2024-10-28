import 'package:flutter/material.dart';
import 'package:login/dashboard.dart';
import 'user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void updateProfile(user) {
    user = widget.user;
    users.removeWhere((u) => u.username == user.username);
    users.add(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile berhasil diubah')),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard(user: user)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              readOnly: true,
              controller: TextEditingController(text: user.username),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                user.nama = value;
              },
              controller: TextEditingController(text: user.nama),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                user.alamat = value;
              },
              controller: TextEditingController(text: user.alamat),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateProfile(user);
              },
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}