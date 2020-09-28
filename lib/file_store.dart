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

const _basePath = 'fileStore';

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

Future<void> _setupStores(Router app) async {
  setupJsonStore<Member>(_basePath, members, MemberJsonCodec());
  setupJsonStore<Book>(_basePath, books, BookJsonCodec());
  setupJsonStore<Borrow>(_basePath, borrowings, BorrowJsonCodec());
}

Future<void> _addStoreAPIs(Router app) async {
  addStoreObjectRoutes<Member>(
    app,
    members,
    getStore<Member>(),
    MemberJsonCodec(),
    null,
  );

  addStoreObjectRoutes<Book>(
    app,
    books,
    getStore<Book>(),
    BookJsonCodec(),
    null,
  );

  addStoreObjectRoutes<Borrow>(
    app,
    borrowings,
    getStore<Borrow>(),
    BorrowJsonCodec(),
    null,
  );
}
