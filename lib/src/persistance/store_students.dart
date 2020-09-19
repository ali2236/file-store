import 'dart:convert';
import 'dart:io';

import 'package:file_store/src/models/student.dart';

import 'file_store.dart';

class StudentFile extends FileStore<Student> {
  StudentFile(String path) : super(File(path));

  @override
  Future<List<Student>> readFile() async {
    var content = await file.readAsString();
    List json = jsonDecode(content);
    return json.map((e) => Student.fromJson(e)).toList();
  }

  @override
  Future<void> writeFile() async{
    var json = jsonEncode(elements.map((e) => e.toJson()).toList());
    await file.writeAsString(json);
  }
}
