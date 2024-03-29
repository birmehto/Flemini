import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

void saveUserMessage(String userId, String message) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference chatCollection = firestore.collection('chat_history');

  try {
    chatCollection.add({
      'user_id': userId,
      'sender': 'user',
      'message': message,
      'timestamp': Timestamp.now(),
    });
  } catch (e) {
    log('Error saving user message: $e');
  }
}

void saveAIReply(String userId, String reply) {
  FirebaseFirestore.instance
      .collection('user_chats')
      .doc(userId)
      .collection('messages')
      .add({
    'sender': 'ai',
    'message': reply,
    'timestamp': Timestamp.now(),
  });
}

void saveMessageToFirestore(String userId, String message, String role) {
  CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('chat_messages');
  messagesCollection.add({
    'userId': userId,
    'message': message,
    'role': role,
    'timestamp': Timestamp.now(),
  }).then((value) {
  log('Message saved to Firestore: $message');
  }).catchError((error) {
    log('Failed to save message: $error');
  });
}
