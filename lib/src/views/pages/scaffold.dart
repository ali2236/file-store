import 'dart:async';
import 'package:shelf/shelf.dart';
import 'template.dart';

FutureOr<Response> scaffold({String body = '', bool container = true, int statusCode = 200}) async {
  return render(
    type: statusCode,
    html: htmlPage(
      title: 'FileStore by Ali.gh',
      body: '''<div class="${container ? 'container' : ''}">$body</div>''',
    ),
  );
}
