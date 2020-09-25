import 'dart:async';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/views/card_books.dart';
import 'package:file_store/src/views/form_book.dart';
import 'package:file_store/src/views/form_student.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'card_students.dart';

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
        ${studentsCard(students)}
    </div>
    <div class="$_responsiveSizing">
        ${booksCard(books)}
    </div>
</div>
      ''',
  );
}
