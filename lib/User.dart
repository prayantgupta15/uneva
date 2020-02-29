import 'dart:convert';

class Other {
  int pid;

  Other({this.pid});

  factory Other.fromJSON(Map<String, dynamic> json) {
    return Other(pid: json['pid']);
  }
}

class User {
  String name;
  String description;
  String tokenName;
  Other other;
  int tokenNumber;
  int status;
  String createdAt;

  //CONSTRUCTOR
  User(
      {this.name,
      this.description,
      this.tokenName,
      this.other,
      this.status,
      this.tokenNumber,
      this.createdAt});

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        description: json['description'],
        tokenName: json['tokenName'],
        other: Other.fromJSON(json['other']),
        status: json['status'],
        tokenNumber: json['tokenNumber'],
        createdAt: json['createdAt']);
    //  other: Other.fromJson(parsedJson['other'])
  }
}
