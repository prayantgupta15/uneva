import 'dart:convert';

class UserDetails {
  String person_full_name;
  String person_gender;
  String person_pic;
  String person_age;
  String person_pid;
  String person_phone;
  String person_address;
  String person_relation;

  UserDetails(
      {this.person_full_name,
      this.person_gender,
      this.person_pic,
      this.person_age,
      this.person_pid,
      this.person_phone,
      this.person_address,
      this.person_relation});

  factory UserDetails.fromJSON(Map<String, dynamic> Json) {
    return UserDetails(
        person_full_name: Json['person_full_name'],
        person_gender: Json['person_gender'],
        person_pic: Json['person_pic'],
        person_age: Json['person_age'],
        person_pid: Json['person_pid'],
        person_phone: Json['person_phone'],
        person_address: Json['person_address'],
        person_relation: Json['person_relation']);
  }
}
