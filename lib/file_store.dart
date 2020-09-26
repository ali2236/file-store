import 'dart:io' as dio;
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

const _basePath = 'files';

void main(List<String> args) async {

  // setup routing
  final app = Router();
  app.get('/', indexPage);
  await _setupStores(app);
  await _addStoreAPIs(app);

  // start server
  var server = await io.serve(app.handler, 'localhost', 2236);
  print('Serving at http://${server.address.host}:${server.port}');
  print('File Store made by Ali Ghanbari');
  _launchBrowser(server);
}

void _launchBrowser(dio.HttpServer server) => dio.Process.runSync(
    'start http://${server.address.host}:${server.port}', [],
    runInShell: true);

Future<void> _setupStores(Router app) async{
  await setupJsonStore<Student>(_basePath, students, (j) => Student.fromJson(j));
  await setupJsonStore<Book>(_basePath, books, (j) => Book.fromJson(j));
}

Future<void> _addStoreAPIs(Router app) async{
  addStoreObjectRoutes<Student>(app, students, getStore<Student>(),
          (uri) => Student.fromUri(uri), studentEditPage, studentsCard);

  addStoreObjectRoutes<Book>(app, books, getStore<Book>(),
          (uri) => Book.fromUri(uri), bookEditPage, booksCard);
}