import 'package:flemini/ai_bot.dart';
import 'package:flemini/history.dart';
import 'package:flemini/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerHeader(
              child: CircleAvatar(
            maxRadius: 50,
            child: Text('hi'),
          )),
          ListTile(
            onTap: () {
              Get.to(const HomePage());
            },
            title: const Text('New Chat'),
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            onTap: () {
              Get.to(const AiBot());
            },
            title: const Text('Ai Bots'),
            trailing: const Icon(Icons.add),
          ),
          ListTile(
            onTap: () {
              Get.to(const History());
            },
            title: const Text('History'),
            trailing: const Icon(Icons.history_outlined),
          ),
        ],
      ),
    );
  }
}
