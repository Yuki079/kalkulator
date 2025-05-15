import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HistoryScreen extends StatelessWidget {
  final List<String> history;

  const HistoryScreen({required this.history, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Riwayat Perhitungan")),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(16.0),
          child: history.isEmpty
              ? const Text("Belum ada riwayat.", style: TextStyle(fontSize: 18))
              : ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(history[index], style: const TextStyle(fontSize: 18)),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
