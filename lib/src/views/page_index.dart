import 'dart:async';
import 'package:file_store/src/persistance/store_student.dart';
import 'package:file_store/src/views/form_student.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'card_student.dart';

FutureOr<Response> indexPage(Request request) async {
  var students = studentStore.elements;
  return scaffold(
      body: '''
<div class="row my-2">
    <div class="col">${studentForm()}</div>
</div>
<div class="row">
    <div class="col">
        <div class="card">
            <div class="card-title"><h3 class="m-4">All Students</h3></div>
            <div class="card-body">
                ${students.map(studentCard).join('\n')}
            </div>
        </div>
    </div>
</div>
      ''',
  );
}
