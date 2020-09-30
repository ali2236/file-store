import 'dart:async';
import 'dart:io';
import 'package:file_store/src/views/pages/page.dart';
import 'package:shelf/shelf.dart';

FutureOr<Response> exceptionPage(Request request, String exception){
  return scaffold(
    statusCode: HttpStatus.badRequest,
    container: false,
    body: '''
      <h2>Exception: $exception</h2>
    ''',
  );
}