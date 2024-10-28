import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/dashboard.dart';
import 'user.dart';

class DanaPage extends StatefulWidget {
  final User user;

  DanaPage({required this.user});

  @override
  _DanaPageState createState() => _DanaPageState();
}

class _DanaPageState extends State<DanaPage> {
  final _controller = TextEditingController();
  late int currentDana;

  @override
  void initState() {
    super.initState();
    currentDana = widget.user.dana;
  }

  void _updateFunds(bool tambahDana) {
    final inputJumlah = int.tryParse(_controller.text) ?? 0;
    
    if (inputJumlah == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Masukan jumlah'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      currentDana = tambahDana
          ? currentDana + inputJumlah
          : (currentDana - inputJumlah).clamp(0, double.infinity).toInt();
    });
    widget.user.dana = currentDana;

    _controller.clear();

    final formattedDana = NumberFormat('#,##0', 'id_ID').format(currentDana);
    final formattedJumlah = NumberFormat('#,##0', 'id_ID').format(currentDana);
    final action = tambahDana ? 'bertambah' : 'berkurang';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dana $action Rp. $formattedJumlah. Dana: Rp. $formattedDana'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _updateUser() {
    User user = widget.user;
    users.removeWhere((u) => u.username == user.username);
    users.add(user);
  }

  @override
  Widget build(BuildContext context) {
    // Format the funds with periods as thousand separators
    final formattedDana = NumberFormat('#,##0', 'id_ID').format(currentDana);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Dana'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _updateUser();
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(user: widget.user)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dana : RP. $formattedDana',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukan jumlah',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateFunds(true),
                    child: Text('Tambah'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateFunds(false),
                    child: Text('Kurang'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
