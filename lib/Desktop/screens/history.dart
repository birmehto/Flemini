import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flemini/Desktop/wigeds/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DHistory extends StatelessWidget {
  const DHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 217, 250),
      // drawer: const DMyDrawer(),
      // appBar: AppBar(
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      //   title: const Text(
      //     'Chat History',
      //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      //   ),
      //   centerTitle: true,
      //   foregroundColor: Colors.deepPurple,
      // ),
      body: Row(
        children: [
          const Expanded(
            flex: 2,
            child: DMyDrawer(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          'Chat History',
                          style: GoogleFonts.adamina(
                              fontSize: 20,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(), // Spacer to push the IconButton to the right
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    // Explicit type for clarity
                    stream: FirebaseFirestore.instance
                        .collection('chat_messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      // Enhanced data check
                      return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                // No need for intermediate 'data' variable
                                final docData = snapshot.data!.docs[index]
                                    .data() as Map<String, dynamic>;
                                return ChatTile(
                                  message: docData['message'] ??
                                      '', // Handle potential nulls
                                  role: docData['role'] ?? '',
                                  timestamp: (docData['timestamp'] as Timestamp)
                                      .toDate(),
                                  onDelete: () =>
                                      deleteChat(snapshot.data!.docs[index].id),
                                );
                              },
                            )
                          : const Center(
                              child: Text('No chat history available.'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteChat(String messageId) {
    FirebaseFirestore.instance
        .collection('chat_messages')
        .doc(messageId)
        .delete()
        .then((_) => log('Chat deleted successfully!'))
        .catchError((error) => log('Failed to delete chat: $error'));
  }
}

class ChatTile extends StatefulWidget {
  final String message;
  final String role;
  final DateTime timestamp;
  final VoidCallback onDelete;

  const ChatTile({
    super.key,
    required this.message,
    required this.role,
    required this.timestamp,
    required this.onDelete,
  });

  @override
  ChatTileState createState() => ChatTileState();
}

class ChatTileState extends State<ChatTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: ListTile(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          title: Text(
            widget.message.length > 20
                ? '${widget.message.substring(0, 20)}...'
                : widget.message,
            style: const TextStyle(fontSize: 16.0),
          ),
          subtitle: !_expanded
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Role: ${widget.role}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${DateFormat('MMM dd, yyyy').format(widget.timestamp)} ${DateFormat('hh:mm a').format(widget.timestamp)}',
                          style: const TextStyle(
                              fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Message: ${widget.message}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: widget.onDelete,
          ),
        ),
      ),
    );
  }
}
