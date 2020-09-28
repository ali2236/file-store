import 'dart:async';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/views/forms/form_borrow.dart';
import 'package:file_store/src/views/pages/scaffold.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> borrowEditPage(Borrow borrow){
  return scaffold(
    body: '''
<div class="row my-2">
    <div class="col">${borrowForm(borrow: borrow, action: '/$borrowings/${borrow.storeId}', title: 'Edit a Borrowing')}</div>
</div>
    ''',
  );
}