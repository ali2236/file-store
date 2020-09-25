import 'dart:async';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/views/form_book.dart';
import 'package:file_store/src/views/form_student.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'card_book.dart';
import 'card_student.dart';

final _responsiveSizing = 'col-lg-6 col-sm-12';
FutureOr<Response> indexPage(Request request) async {
  var students = getStore<Student>().elements;
  var books = getStore<Book>().elements;
  return scaffold(
      body: '''
<div class="row my-2">
    <div class="$_responsiveSizing">${studentForm()}</div>
    <div class="$_responsiveSizing">${bookForm()}</div>
</div>
<div class="row">
    <div class="$_responsiveSizing">
        <div class="card">
            <div class="card-title"><h3 class="m-4">All Students</h3></div>
            <div class="card-body">
                ${students.map(studentCard).join('\n')}
            </div>
        </div>
    </div>
    <div class="$_responsiveSizing">
        <div class="card">
            <div class="card-title"><h3 class="m-4">All Books</h3></div>
            <div class="card-body">
                ${books.map(bookCard).join('\n')}
            </div>
        </div>
    </div>
</div>
      ''',
  );
}
