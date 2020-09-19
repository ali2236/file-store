import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/persistance/store_students.dart';
import 'package:file_store/src/services/service.dart';

class StudentService extends FileService<Student>{

  StudentService(String path) : super(StudentFile(path));

}