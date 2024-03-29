class DBardmodel {
  String? system;
  String? message;

  DBardmodel({this.system, this.message});

  factory DBardmodel.fromJson(Map<String, dynamic> json) {
    return DBardmodel(
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
