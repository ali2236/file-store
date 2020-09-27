import 'package:file_store/src/models/student.dart';

String studentCard(Student student) {
  return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${student.firstName} ${student.lastName}</h4>
    <p>Id: ${student.id}</p>
    <p>First Name: ${student.firstName}</p>
    <p>Last Name: ${student.lastName}</p>
    <div>
    <a class="btn btn-secondary" type="button" href="/$students/edit/${student.storeId}">Edit</a>
    <a class="btn btn-danger" type="button" href="/$students/delete/${student.storeId}">Delete</a>
    </div>
  </div>
  ''';
}
