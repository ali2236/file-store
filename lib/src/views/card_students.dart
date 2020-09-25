import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/views/element_search.dart';
import 'card_student.dart';

String studentsCard(List<Student> studentList){
  return '''
  <div class="card">
    <div class="card-title"><h3 class="m-4">All Students</h3></div>
    <div class="card-body">
        ${searchBar('/search/$students')}
        ${studentList.map(studentCard).join('\n')}
     </div>
</div>
  ''';
}