import 'package:flemini/my_drawer.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Mydrawer(),
      appBar: AppBar(
        title: const Center(child: Text('History')),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
