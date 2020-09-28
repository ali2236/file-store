import 'package:file_store/src/models/json_store_object.dart';

const members = 'members';

class Member extends JsonStoreObject{
  final String firstName;
  final String lastName;

  Member(this.firstName, this.lastName) {
    if(firstName.isEmpty) throw 'first name can not be empty';
    if(lastName.isEmpty) throw 'last name can not be empty';
  }

  factory Member.fromJson(Map<String, dynamic> json){
      return Member( json['firstName'], json['lastName']);
  }

  factory Member.fromUri(String uri){
    var params = Uri.splitQueryString(uri);
    return Member.fromJson(params);
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      'firstName' : firstName,
      'lastName' : lastName,
    };
  }

  @override
  String toString() {
    return '$firstName $lastName';
  }
}