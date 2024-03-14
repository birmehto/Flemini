import 'dart:async';
import 'dart:typed_data';

import 'package:flemini/Desktop/model/image_model.dart';
import 'package:flemini/Mobile/wigeds/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

class ImageAi extends StatefulWidget {
  const ImageAi({super.key});

  @override
  State<ImageAi> createState() => _ImageAiState();
}

class _ImageAiState extends State<ImageAi> {
  final TextEditingController _textFieldController = TextEditingController();
  Uint8List? _selectedImage;
  final ScrollController _scrollController = ScrollController();
  bool _imageNotSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 255),
      drawer: const MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Center(
          child: Text(
            "Image Chat",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 165, 125, 233),
              fontSize: 17,
              fontFamily: 'Sixtyfour',
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _messages.clear();
              });
            },
            icon: const Icon(
              Icons.delete_sweep_outlined,
              size: 32,
              color: Colors.deepPurpleAccent,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView(
                  controller: _scrollController,
                  children: _messages
                      .map((message) => _buildChatBubble(message))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 60,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image_search_rounded,
                          color: Colors.black, size: 25),
                    ),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          final text = _textFieldController.text;
                          final image = _selectedImage;
                          if (text.isNotEmpty || image != null) {
                            _textFieldController.clear();
                            _sendMessage(text, image);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Please select an image or enter a message"),
                              ),
                            );
                          }
                          scrollToBottom();
                        },
                        controller: _textFieldController,
                        decoration: const InputDecoration(
                          hintText: "Ask me anything ..",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    _isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromARGB(255, 237, 186, 247),
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              final text = _textFieldController.text;
                              final image = _selectedImage;
                              if (text.isNotEmpty || image != null) {
                                _textFieldController.clear();
                                _sendMessage(text, image);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please select an image or enter a message"),
                                  ),
                                );
                              }
                              scrollToBottom();
                            },
                            icon: CircleAvatar(
                              backgroundColor:
                                  Colors.blueAccent.withOpacity(0.7),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ),
            if (_imageNotSelected)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Please select an image or enter a message",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isAi
                    ? const Color.fromARGB(255, 137, 176, 243)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message.isAi
                            ? const Color.fromARGB(255, 137, 176, 243)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          message.isAi
                              ? CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/robo.png',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                ), // AI or User Emoji
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment
                                  .start, // Adjusted to start from top
                              children: [
                                if (message.image != null)
                                  Image.memory(
                                    message.image!,
                                    width: 100,
                                    height: 100,
                                  ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SelectableText(
                                  message.text.toString().replaceAll('**', ''),
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = Uint8List.fromList(imageBytes);
        _imageNotSelected = false;
      });
    }
  }

  Uint8List? _previousSelectedImage;

  void _sendMessage(String text, Uint8List? imageBytes) {
    if (text.isEmpty && imageBytes == null && _previousSelectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an image or enter a message"),
        ),
      );
    } else {
      if (imageBytes == null && _previousSelectedImage != null) {
        imageBytes = _previousSelectedImage;
      }
      _messages.add(Message(text: text, image: imageBytes, isAi: false));
      if (imageBytes != null) {
        _previousSelectedImage = imageBytes;
        _updateAiResponse(text, imageBytes);
      }
    }
  }

  Future<void> _updateAiResponse(String text, Uint8List? imageBytes) async {
    setState(() {
      _isLoading.value = true;
    });

    try {
      final gemini = Gemini.instance;
      final response = await gemini.textAndImage(
        text: text,
        images: imageBytes != null ? [imageBytes] : [],
      );

      _messages.add(Message(
        text: response?.content?.parts?.last.text ?? '',
        isAi: true,
      ));

      setState(() {
        _isLoading.value = false;
      });
    } catch (e) {
      debugPrint('Error sending message: $e');
      setState(() {
        _isLoading.value = false;
      });
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  final RxBool _isLoading = false.obs;
  final List<Message> _messages = [];
}
