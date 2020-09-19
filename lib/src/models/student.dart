import 'package:file_store/src/models/store_object.dart';

class Student implements StoreObject{
  final int id;
  final String firstName;
  final String lastName;

  Student(this.id, this.firstName, this.lastName);

  factory Student.fromJson(Map<String, dynamic> json){
      return Student(json['id'], json['firstName'], json['lastName']);
  }

  factory Student.fromUri(String uri){
    var params = Uri.splitQueryString(uri);
    return Student(int.tryParse(params['id']), params['firstName'], params['lastName']);
  }

  @override
  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'firstName' : firstName,
      'lastName' : lastName,
    };
  }
}