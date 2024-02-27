class Bardmodel {
  String? system;
  String? message;

  Bardmodel({this.system, this.message});

  factory Bardmodel.fromJson(Map<String, dynamic> json) {
    return Bardmodel(
      system: json['role'],
      message: json['parts'][0]['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'system': system,
      'message': message,
    };
  }
}

// Example usage:
// void main() {
//   String responseJson = '{"role": "model", "parts": [{"text": "Hello"}]}';
//   Map<String, dynamic> jsonResponse = jsonDecode(responseJson);
  
//   Bardmodel model = Bardmodel.fromJson(jsonResponse);
//   print(model.system); // Output: model
//   print(model.message); // Output: Hello
// }
