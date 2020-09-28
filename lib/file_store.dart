import 'dart:io' as dio;
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/views/lists/list_borrow.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/routes/routes_store_object.dart';
import 'src/views/lists/list_book.dart';
import 'src/views/lists/list_memeber.dart';
import 'src/views/pages/page_edit_book.dart';
import 'src/views/pages/page_edit_borrow.dart';
import 'src/views/pages/page_edit_member.dart';
import 'src/views/pages/page_index.dart';

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
  var metaStore = await setupMetaStore(_basePath);
  await setupJsonStore<Member>(_basePath, members, metaStore, (j) => Member.fromJson(j));
  await setupJsonStore<Book>(_basePath, books, metaStore, (j) => Book.fromJson(j));
  await setupJsonStore<Borrow>(_basePath, borrowings, metaStore, (j) => Borrow.fromJson(j));
}

Future<void> _addStoreAPIs(Router app) async{
  addStoreObjectRoutes<Member>(app, members, getStore<Member>(),
          (uri) => Member.fromUri(uri), memberEditPage, memberListCard);

  addStoreObjectRoutes<Book>(app, books, getStore<Book>(),
          (uri) => Book.fromUri(uri), bookEditPage, bookListCard);

  addStoreObjectRoutes<Borrow>(app, borrowings, getStore<Borrow>(),
          (uri) => Borrow.fromUri(uri), borrowEditPage, borrowListCard);
}