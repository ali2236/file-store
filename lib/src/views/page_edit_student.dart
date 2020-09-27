
import 'dart:async';
import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'form_student.dart';

FutureOr<Response> studentEditPage(Student student){
  return scaffold(
    body: '''
<div class="row my-2">
    <div class="col">${studentForm(student: student, action: '/students/${student.storeId}', title: 'Edit Student')}</div>
</div>
    ''',
  );
}