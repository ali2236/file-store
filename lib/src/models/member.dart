

import 'dart:convert';

import 'package:file_store/src/models/basic/codec.dart';

import 'basic/store_object.dart';

const members = 'members';

class Member extends JsonStoreObject {
  final String firstName;
  final String lastName;

  Member(this.firstName, this.lastName) {
    if (firstName.isEmpty) throw 'first name can not be empty';
    if (lastName.isEmpty) throw 'last name can not be empty';
  }

  @override
  Map<String, dynamic> toJson() => {
      'firstName': firstName,
      'lastName': lastName,
    };

  @override
  String toString() => '$firstName $lastName';
}

class MemberJsonCodec extends JsonObjectCodec<Member>{
  @override
  Member deserialize(String source) {
    final json = jsonDecode(source);
    return Member(json['firstName'], json['lastName']);
  }
}