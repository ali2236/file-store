import 'dart:io';
import 'package:file_store/src/models/student.dart';
import 'package:path/path.dart';
import 'file_store.dart';
import 'json_file_store.dart';

JsonFileStore<Student> _studentFileStore;
FileStore<Student> get studentStore => _studentFileStore;

Future<void> setupStudentStore(String basePath) async{
  if(_studentFileStore!=null) return;
  var getFile = (String name) => File(join(basePath, '$name.json'));
  var studentFile = JsonFileStore<Student>(
    file: getFile('students'),
    objectDecoder: (json) => Student.fromJson(json),
  );
  await studentFile.init();
  _studentFileStore = studentFile;
}