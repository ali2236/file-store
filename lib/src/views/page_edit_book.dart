import 'dart:async';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'form_book.dart';

FutureOr<Response> bookEditPage(Book book){
  return scaffold(
    body: '''
<div class="row my-2">
    <div class="col">${bookForm(book: book, action: '/$books/${book.storeId}', title: 'Edit Book')}</div>
</div>
    ''',
  );
}