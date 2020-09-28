import 'dart:async';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/views/forms/form_book.dart';
import 'package:file_store/src/views/forms/form_borrow.dart';
import 'package:file_store/src/views/forms/form_member.dart';
import 'package:file_store/src/views/lists/list_book.dart';
import 'package:file_store/src/views/lists/list_borrow.dart';
import 'package:file_store/src/views/lists/list_memeber.dart';
import 'package:file_store/src/views/pages/scaffold.dart';
import 'package:shelf/shelf.dart';

final _responsiveSizing = 'col-lg-4 col-sm-12';

FutureOr<Response> indexPage(Request request) async {
  var students = getStore<Member>().elements;
  var books = getStore<Book>().elements;
  var borrows = getStore<Borrow>().elements;
  return scaffold(
    body: '''
    <div class="row my-2">
    <div class="$_responsiveSizing">${borrowForm()}</div>
    <div class="$_responsiveSizing">${memberForm()}</div>
    <div class="$_responsiveSizing">${bookForm()}</div>
</div>
<div class="row">
    <div class="$_responsiveSizing">
        ${borrowListCard(borrows)}
    </div>
    <div class="$_responsiveSizing">
        ${memberListCard(students)}
    </div>
    <div class="$_responsiveSizing">
        ${bookListCard(books)}
    </div>
</div>
      ''',
  );
}
