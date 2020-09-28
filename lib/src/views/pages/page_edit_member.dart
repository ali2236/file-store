import 'dart:async';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/views/pages/scaffold.dart';
import 'package:shelf/shelf.dart';
import '../forms/form_member.dart';

FutureOr<Response> memberEditPage(Member member) {
  return scaffold(
    body: '''
<div class="row my-2">
    <div class="col">${memberForm(member: member, action: '/$members/${member.storeId}', title: 'Edit Member')}</div>
</div>
    ''',
  );
}
