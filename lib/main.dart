import 'dart:io';
import 'package:args/args.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/routes/routes_store_object.dart';
import 'package:file_store/src/views/card_books.dart';
import 'package:file_store/src/views/card_students.dart';
import 'package:file_store/src/views/page_edit_book.dart';
import 'package:file_store/src/views/page_edit_student.dart';
import 'src/views/page_index.dart';

const _hostname = 'localhost';
const _basePath = 'files';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '2236';
  var port = int.tryParse(portStr);

  var app = Router();

  ///
  /// setup stores
  ///
  await setupJsonStore<Student>(
      _basePath, students, (j) => Student.fromJson(j));

  await setupJsonStore<Book>(_basePath, books, (j) => Book.fromJson(j));

  ///
  /// add store interaction APIs
  ///
  addStoreObjectRoutes<Student>(app, students, getStore<Student>(),
      (uri) => Student.fromUri(uri), studentEditPage, studentsCard);

  addStoreObjectRoutes<Book>(app, books, getStore<Book>(),
      (uri) => Book.fromUri(uri), bookEditPage, booksCard);

  ///
  /// add index page
  ///
  app.get('/', indexPage);

  ///
  /// start server
  ///
  var server = await io.serve(app.handler, 'localhost', port);
  print('Serving at http://${server.address.host}:${server.port}');
}
