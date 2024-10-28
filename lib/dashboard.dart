import 'package:flutter/material.dart';
import 'package:login/setting.dart';
import 'login.dart';
import 'profile.dart';
import 'user.dart';

class Dashboard extends StatelessWidget {
  final String username;
  const Dashboard({super.key, required this.username});
  
  @override
  Widget build(BuildContext context) {
    User user = users.firstWhere((u) => u.username == username);
    var nama = user.nama;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Welcome, $username',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(username: username,)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage(username: username,)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.square_rounded),
              title: const Text('Placeholder'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.square_rounded),
              title: const Text('Placeholder'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome, $nama!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  DashboardCard(
                    title: 'Profile',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage(username: username,)),
                      );
                    },),
                  DashboardCard(
                    title: 'Settings',
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage(username: username)),
                      );
                    },),
                  DashboardCard(
                    title: 'Placeholder',
                    icon: Icons.square_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KosongPage()),
                      );
                    },),
                  DashboardCard(
                    title: 'Placeholder',
                    icon: Icons.square_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KosongPage()),
                      );
                    },
                  ),
                ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap:  onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

class KosongPage extends StatelessWidget {
  const KosongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kosong')),
      body: const Center(
        child: Text('Nothing to see here', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}