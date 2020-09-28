import 'dart:async';
import 'package:shelf/shelf.dart';
import 'template.dart';

FutureOr<Response> scaffold({String body = ''}) async {
  return render(
    html: htmlPage(
      title: 'FileStore by Ali.gh',
      body: '''<div class="container">$body</div>''',
    ),
  );
}
