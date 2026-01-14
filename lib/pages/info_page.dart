import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Info Burjo")),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.brown),
              title: Text("Jam Buka"),
              subtitle: Text("Senin - Minggu: 08.00 - 23.00"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.brown),
              title: Text("Lokasi"),
              subtitle: Text("Jl. Burjo No. 1, Dekat Kampus"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.brown),
              title: Text("Kontak"),
              subtitle: Text("0812-3456-7890"),
            ),
          ],
        ),
      ),
    );
  }
}
