import 'package:file_store/src/models/student.dart';

String studentCard(Student student){
  return '''
  <div class="card card-body my-2">
    <p>${student.id}: ${student.firstName} ${student.lastName}</p>
    <a class="button delete" href="/students/delete/${student.index}">Delete</a>
  </div>
  ''';
}