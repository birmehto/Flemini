import 'dart:typed_data';

class Message {
  final String text;
  final Uint8List? image;
  final bool isAi;

  Message({
    required this.text,
    this.image,
    required this.isAi,
  });
}
