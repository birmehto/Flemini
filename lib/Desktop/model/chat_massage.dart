class ChatMessage {
  final String message;

  final String messageType;

  ChatMessage(this.message, this.messageType);

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      json['message'] as String,
      json['messageType'] as String,
    );
  }

  get system => null;

  get isUserMessage => null;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageType': messageType,
    };
  }
}
