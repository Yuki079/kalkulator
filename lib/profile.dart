import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Profil")),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/asset/images/profile.jpg'), // Sesuaikan path gambar profil
            ),
            const SizedBox(height: 20),
            const Text("Yuki Al Falah", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Flutter Developer", style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}